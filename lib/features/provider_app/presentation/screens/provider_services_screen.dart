import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../domain/models/service_model.dart';
import '../../data/provider_service.dart';

class ProviderServicesScreen extends ConsumerStatefulWidget {
  const ProviderServicesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProviderServicesScreen> createState() =>
      _ProviderServicesScreenState();
}

class _ProviderServicesScreenState
    extends ConsumerState<ProviderServicesScreen> {
  Future<List<ServiceModel>>? _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final user = ref.read(authServiceProvider).currentUser;
    if (user != null) {
      _future = ref
          .read(providerServiceProvider)
          .getServicesForProvider(user.id);
    } else {
      _future = Future.value([]);
    }
  }

  Future<void> _delete(String id) async {
    await ref.read(providerServiceProvider).deleteService(id);
    setState(() => _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Services')),
      backgroundColor: AppTheme.background,
      body: FutureBuilder<List<ServiceModel>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          final items = snap.data ?? [];
          if (items.isEmpty)
            return const Center(child: Text('No services yet'));
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, idx) {
              final s = items[idx];
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  s.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(s.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('₹${s.price.toStringAsFixed(0)}'),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () => _delete(s.id),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
