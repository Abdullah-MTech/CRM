// lib/app/data/models/recent_contact_model.dart

class RecentContact {
  final int conversationId;
  final int userId;
  final String name;
  final String phoneNumber;

  RecentContact({
    required this.conversationId,
    required this.userId,
    required this.name,
    required this.phoneNumber,
  });

  factory RecentContact.fromJson(Map<String, dynamic> json) {
    return RecentContact(
      conversationId: json['conversation_id'] is int
          ? json['conversation_id'] as int
          : int.tryParse(json['conversation_id']?.toString() ?? '') ?? 0,
      userId: json['user_id'] is int
          ? json['user_id'] as int
          : int.tryParse(json['user_id']?.toString() ?? '') ?? 0,
      name: (json['name'] ?? '').toString(),
      phoneNumber: (json['phone_number'] ?? '').toString(),
    );
  }
}
