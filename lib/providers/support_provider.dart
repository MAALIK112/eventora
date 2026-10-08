import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/support_model.dart';
import '../services/mock_data_service.dart';

class SupportProvider extends ChangeNotifier {
  List<FaqItem> _faqs = [];
  List<SupportTicket> _tickets = [];
  List<ChatMessage> _chatMessages = [];
  bool _isTyping = false;

  SupportProvider() {
    _initSupport();
  }

  List<FaqItem> get faqs => _faqs;
  List<SupportTicket> get tickets => _tickets;
  List<ChatMessage> get chatMessages => _chatMessages;
  bool get isTyping => _isTyping;

  void _initSupport() {
    _faqs = MockDataService.getFaqs();
    _tickets = [
      SupportTicket(
        id: 'TCK-8812',
        subject: 'Venue Drone Permit Confirmation',
        category: 'Venues',
        relatedBookingId: 'EVT-2026-8841',
        description: 'Verified Bel-Air municipal aerial authorization for our 5:30 PM sunset session.',
        status: TicketStatus.resolved,
        createdAt: DateTime(2026, 10, 2),
      ),
    ];
    _chatMessages = [
      ChatMessage(
        id: 'msg-1',
        text: 'Bonjour Lady Genevieve. Welcome to Eventora VIP Concierge. How may I assist you with your upcoming celebrations today?',
        isUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        senderName: 'Clara (VIP Concierge)',
      ),
    ];
    notifyListeners();
  }

  void submitTicket({
    required String subject,
    required String category,
    required String bookingId,
    required String description,
  }) {
    final newTicket = SupportTicket(
      id: 'TCK-${(1000 + _tickets.length * 47).toString()}',
      subject: subject,
      category: category,
      relatedBookingId: bookingId,
      description: description,
      status: TicketStatus.open,
      createdAt: DateTime.now(),
    );
    _tickets.insert(0, newTicket);
    notifyListeners();
  }

  void sendChatMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: 'msg-${const Uuid().v4().substring(0, 6)}',
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );
    _chatMessages.add(userMsg);
    _isTyping = true;
    notifyListeners();

    // Auto-respond with concierge luxury response
    Future.delayed(const Duration(milliseconds: 1400), () {
      _isTyping = false;
      String replyText = "I have noted your inquiry regarding '$text'. Our lead concierge coordinator is reviewing your details and has attached priority status to your request.";
      if (text.toLowerCase().contains('refund') || text.toLowerCase().contains('cancel')) {
        replyText = "Rest assured, your escrow funds are 100% safeguarded under Eventora Guarantee. I can immediately help facilitate your refund or provider rescheduling.";
      } else if (text.toLowerCase().contains('book') || text.toLowerCase().contains('venue') || text.toLowerCase().contains('photographer')) {
        replyText = "I would be delighted to arrange a private consultation or check direct availability for our verified top-tier partners for your celebration date.";
      }

      _chatMessages.add(
        ChatMessage(
          id: 'msg-${const Uuid().v4().substring(0, 6)}',
          text: replyText,
          isUser: false,
          timestamp: DateTime.now(),
          senderName: 'Clara (VIP Concierge)',
        ),
      );
      notifyListeners();
    });
  }
}
