enum TicketStatus {
  open,
  inReview,
  resolved,
  closed,
}

class FaqItem {
  final String id;
  final String category;
  final String question;
  final String answer;

  const FaqItem({
    required this.id,
    required this.category,
    required this.question,
    required this.answer,
  });
}

class SupportTicket {
  final String id;
  final String subject;
  final String category;
  final String relatedBookingId;
  final String description;
  final TicketStatus status;
  final DateTime createdAt;
  final String priority;

  const SupportTicket({
    required this.id,
    required this.subject,
    required this.category,
    required this.relatedBookingId,
    required this.description,
    required this.status,
    required this.createdAt,
    this.priority = 'High',
  });
}

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? senderName;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.senderName,
  });
}
