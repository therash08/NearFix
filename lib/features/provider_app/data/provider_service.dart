import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/service_model.dart';
import '../domain/models/booking_model.dart';

final providerServiceProvider = Provider<ProviderService>(
  (ref) => ProviderService(),
);

class ProviderService {
  static const _kServicesKey = 'nearfix_services';
  static const _kBookingsKey = 'nearfix_bookings';

  Future<List<ServiceModel>> getAllServices() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kServicesKey) ?? '[]';
    final List list = jsonDecode(s);
    return list
        .map((e) => ServiceModel.fromJson(e))
        .cast<ServiceModel>()
        .toList();
  }

  Future<ServiceModel?> getServiceById(String id) async {
    final all = await getAllServices();
    for (final s in all) {
      if (s.id == id) return s;
    }
    return null;
  }

  Future<List<ServiceModel>> getServicesForProvider(String providerId) async {
    final all = await getAllServices();
    return all.where((s) => s.providerId == providerId).toList();
  }

  Future<void> addService(ServiceModel service) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kServicesKey) ?? '[]';
    final List list = jsonDecode(s);
    list.add(service.toJson());
    await prefs.setString(_kServicesKey, jsonEncode(list));
  }

  Future<void> updateService(ServiceModel service) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kServicesKey) ?? '[]';
    final List list = jsonDecode(s);
    final idx = list.indexWhere((e) => (e['id'] ?? '') == service.id);
    if (idx >= 0) {
      list[idx] = service.toJson();
      await prefs.setString(_kServicesKey, jsonEncode(list));
    }
  }

  Future<void> deleteService(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kServicesKey) ?? '[]';
    final List list = jsonDecode(s);
    list.removeWhere((e) => (e['id'] ?? '') == id);
    await prefs.setString(_kServicesKey, jsonEncode(list));
  }

  Future<List<BookingModel>> getBookingsForProvider(String providerId) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kBookingsKey) ?? '[]';
    final List list = jsonDecode(s);
    final all = list.map((e) => BookingModel.fromJson(e)).toList();
    return all.where((b) => b.providerId == providerId).toList();
  }

  Future<void> createBooking(BookingModel booking) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kBookingsKey) ?? '[]';
    final List list = jsonDecode(s);
    list.add(booking.toJson());
    await prefs.setString(_kBookingsKey, jsonEncode(list));
  }

  Future<void> updateBookingStatus(
    String bookingId,
    BookingStatus status,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kBookingsKey) ?? '[]';
    final List list = jsonDecode(s);
    final idx = list.indexWhere((e) => (e['id'] ?? '') == bookingId);
    if (idx >= 0) {
      final data = Map<String, dynamic>.from(list[idx]);
      data['status'] = bookingStatusToString(status);
      list[idx] = data;
      await prefs.setString(_kBookingsKey, jsonEncode(list));
    }
  }
}
