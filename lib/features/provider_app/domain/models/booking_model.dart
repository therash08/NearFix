import 'dart:convert';

enum BookingStatus { pending, accepted, rejected, completed, cancelled }

BookingStatus bookingStatusFromString(String s) {
  switch (s) {
    case 'accepted':
      return BookingStatus.accepted;
    case 'rejected':
      return BookingStatus.rejected;
    case 'completed':
      return BookingStatus.completed;
    case 'cancelled':
      return BookingStatus.cancelled;
    case 'pending':
    default:
      return BookingStatus.pending;
  }
}

String bookingStatusToString(BookingStatus s) => s.toString().split('.').last;

class BookingModel {
  final String id;
  final String userId;
  final String providerId;
  final String serviceId;
  final int timestamp;
  final BookingStatus status;
  final String notes;

  BookingModel({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceId,
    required this.timestamp,
    required this.status,
    this.notes = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'providerId': providerId,
    'serviceId': serviceId,
    'timestamp': timestamp,
    'status': bookingStatusToString(status),
    'notes': notes,
  };

  factory BookingModel.fromJson(Map<dynamic, dynamic> json) => BookingModel(
    id: json['id']?.toString() ?? '',
    userId: json['userId']?.toString() ?? '',
    providerId: json['providerId']?.toString() ?? '',
    serviceId: json['serviceId']?.toString() ?? '',
    timestamp: int.tryParse(json['timestamp']?.toString() ?? '0') ?? 0,
    status: bookingStatusFromString(json['status'] ?? 'pending'),
    notes: json['notes'] ?? '',
  );

  String encode() => jsonEncode(toJson());

  static BookingModel decode(String s) => BookingModel.fromJson(jsonDecode(s));
}
