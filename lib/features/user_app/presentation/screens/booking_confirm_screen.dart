import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../provider_app/data/provider_service.dart';
import '../../../provider_app/domain/models/booking_model.dart';

class BookingConfirmScreen extends ConsumerStatefulWidget {
  final String serviceId;
  const BookingConfirmScreen({Key? key, required this.serviceId})
    : super(key: key);

  @override
  ConsumerState<BookingConfirmScreen> createState() =>
      _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends ConsumerState<BookingConfirmScreen> {
  bool _loading = false;
  Future? _serviceFuture;

  @override
  void initState() {
    super.initState();
    _serviceFuture = ref
        .read(providerServiceProvider)
        .getServiceById(widget.serviceId);
  }

  Future<void> _confirm() async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please login to book')));
      return;
    }

    setState(() => _loading = true);
    final s = await ref
        .read(providerServiceProvider)
        .getServiceById(widget.serviceId);
    if (s == null) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Service not found')));
      setState(() => _loading = false);
      return;
    }

    final booking = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: user.id,
      providerId: s.providerId,
      serviceId: s.id,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      status: BookingStatus.pending,
    );

    try {
      await ref.read(providerServiceProvider).createBooking(booking);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Booking created')));
        context.go('/home');
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      backgroundColor: AppTheme.background,
      body: FutureBuilder(
        future: _serviceFuture,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          final s = snap.data;
          if (s == null) return const Center(child: Text('Service not found'));
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  s.description,
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 20),
                Text('Price', style: TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 8),
                Text(
                  '₹${s.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _loading ? null : _confirm,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text('Confirm Booking'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
