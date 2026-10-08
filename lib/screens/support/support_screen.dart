import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/support_model.dart';
import '../../providers/support_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/luxe_card.dart';
import 'live_chat_screen.dart';
import 'submit_ticket_modal.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String _faqQuery = '';
  final Set<String> _expandedFaqIds = {'faq-1'};

  void _showTicketModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SubmitTicketModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final support = context.watch<SupportProvider>();

    final filteredFaqs = support.faqs.where((faq) {
      if (_faqQuery.isEmpty) return true;
      final q = _faqQuery.toLowerCase();
      return faq.question.toLowerCase().contains(q) ||
          faq.answer.toLowerCase().contains(q) ||
          faq.category.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Concierge & Help Center'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Concierge Hero Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF18181B),
                    Color(0xFF332318),
                    Color(0xFF903F00),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.support_agent,
                          color: AppColors.sunlitAmber, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        'Eventora VIP Concierge',
                        style: AppTypography.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Direct 24/7 access to your dedicated event producer, booking resolution, and vendor coordination.',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const LiveChatScreen()),
                            );
                          },
                          icon: const Icon(Icons.chat_bubble_outline, size: 16),
                          label: const Text('Live Chat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.obsidianCharcoal,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _showTicketModal,
                          icon: const Icon(Icons.confirmation_number_outlined,
                              size: 16),
                          label: const Text('New Ticket'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.12),
                            foregroundColor: Colors.white,
                            side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.4)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Active Tickets Section
            if (support.tickets.isNotEmpty) ...[
              Text(
                'My Support Requests',
                style: AppTypography.headlineMedium.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Column(
                children: support.tickets.map((ticket) {
                  final isResolved = ticket.status == TicketStatus.resolved;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LuxeCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${ticket.id} • ${ticket.category}',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.deepAmber,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isResolved
                                      ? AppColors.emeraldSageLight
                                      : AppColors.amberLight,
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: Text(
                                  isResolved ? 'RESOLVED' : 'IN REVIEW',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: isResolved
                                        ? AppColors.emeraldSage
                                        : AppColors.deepAmber,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            ticket.subject,
                            style: AppTypography.titleSmall
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ticket.description,
                            style: AppTypography.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Logged: ${DateFormat('MMM dd, yyyy • hh:mm a').format(ticket.createdAt)}',
                            style: AppTypography.bodySmall.copyWith(
                                fontSize: 10, color: AppColors.mutedStone),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],

            // Frequently Asked Questions
            Text(
              'Frequently Asked Questions',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // FAQ Search
            TextField(
              onChanged: (val) => setState(() => _faqQuery = val),
              decoration: const InputDecoration(
                hintText: 'Search FAQ topics (escrow, refund, vetting)...',
                prefixIcon: Icon(Icons.search, color: AppColors.deepAmber),
              ),
            ),
            const SizedBox(height: 14),

            // FAQ Accordion
            Column(
              children: filteredFaqs.map((faq) {
                final isExpanded = _expandedFaqIds.contains(faq.id);
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.warmLinen),
                  ),
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        child: ListTile(
                          title: Text(
                            faq.question,
                            style: AppTypography.titleSmall.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.deepAmber,
                          ),
                          onTap: () {
                            setState(() {
                              if (isExpanded) {
                                _expandedFaqIds.remove(faq.id);
                              } else {
                                _expandedFaqIds.add(faq.id);
                              }
                            });
                          },
                        ),
                      ),
                      if (isExpanded)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            faq.answer,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
