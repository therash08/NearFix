import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../domain/models/booking_model.dart';
import '../../data/provider_service.dart';

class ProviderBookingsScreen extends ConsumerStatefulWidget {
  const ProviderBookingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProviderBookingsScreen> createState() =>
      _ProviderBookingsScreenState();
}

class _ProviderBookingsScreenState
    extends ConsumerState<ProviderBookingsScreen> {
  Future<List<BookingModel>>? _future;

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
          .getBookingsForProvider(user.id);
    } else {
      _future = Future.value([]);
    }
  }

  Future<void> _update(String id, BookingStatus status) async {
    await ref.read(providerServiceProvider).updateBookingStatus(id, status);
    setState(() => _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      backgroundColor: AppTheme.background,
      body: FutureBuilder<List<BookingModel>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          final items = snap.data ?? [];
          if (items.isEmpty)
            return const Center(child: Text('No bookings yet'));
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, idx) {
              final b = items[idx];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking from: ${b.userId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text('Service: ${b.serviceId}'),
                    const SizedBox(height: 6),
                    Text(
                      'When: ${DateTime.fromMillisecondsSinceEpoch(b.timestamp)}',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                _update(b.id, BookingStatus.rejected),
                            child: const Text('Reject'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                _update(b.id, BookingStatus.accepted),
                            child: const Text('Accept'),
                          ),
                        ),
                      ],
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
