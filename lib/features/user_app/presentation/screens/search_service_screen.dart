import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../provider_app/domain/models/service_model.dart';
import '../../../provider_app/data/provider_service.dart';
import 'service_detail_screen.dart';

class SearchServiceScreen extends ConsumerStatefulWidget {
  const SearchServiceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchServiceScreen> createState() =>
      _SearchServiceScreenState();
}

class _SearchServiceScreenState extends ConsumerState<SearchServiceScreen> {
  final _ctrl = TextEditingController();
  String _query = '';
  Future<List<ServiceModel>>? _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(providerServiceProvider).getAllServices();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: TextField(
          controller: _ctrl,
          decoration: const InputDecoration(
            hintText: 'Search services or providers',
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => _query = v.trim()),
        ),
        actions: [
          IconButton(
            onPressed: () => _ctrl.clear(),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      backgroundColor: AppTheme.background,
      body: FutureBuilder<List<ServiceModel>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          final list = snap.data ?? [];
          final results = _query.isEmpty
              ? list
              : list
                    .where(
                      (s) =>
                          s.title.toLowerCase().contains(
                            _query.toLowerCase(),
                          ) ||
                          s.description.toLowerCase().contains(
                            _query.toLowerCase(),
                          ),
                    )
                    .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      [
                            'AC repair',
                            'Electrician',
                            'Plumber',
                            'Cleaning',
                            'Tutor',
                          ]
                          .map(
                            (t) => ActionChip(
                              label: Text(t),
                              onPressed: () => setState(() => _ctrl.text = t),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: results.isEmpty
                      ? const Center(child: Text('No services found'))
                      : ListView.separated(
                          itemCount: results.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, idx) {
                            final s = results[idx];
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ServiceDetailScreen(serviceId: s.id),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF0B3DFF),
                                            Color(0xFF00E6C6),
                                          ],
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.build,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            s.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            s.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppTheme.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '₹${s.price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
