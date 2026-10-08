import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/support_provider.dart';
import '../../widgets/luxe_button.dart';

class SubmitTicketModal extends StatefulWidget {
  const SubmitTicketModal({super.key});

  @override
  State<SubmitTicketModal> createState() => _SubmitTicketModalState();
}

class _SubmitTicketModalState extends State<SubmitTicketModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bookingIdController =
      TextEditingController(text: 'EVT-2026-8841');
  final TextEditingController _descController = TextEditingController();

  String _selectedCategory = 'Booking & Escrow';

  final List<String> _categories = [
    'Booking & Escrow',
    'Provider & Venue Coordination',
    'Payment & Wallet Inquiries',
    'Special Custom Requests',
    'Cancellation / Rescheduling',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _bookingIdController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SupportProvider>().submitTicket(
            subject: _subjectController.text.trim(),
            category: _selectedCategory,
            bookingId: _bookingIdController.text.trim(),
            description: _descController.text.trim(),
          );

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('VIP Support Ticket submitted. Priority handler assigned!'),
          backgroundColor: AppColors.emeraldSage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDim,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Submit Concierge Ticket',
                style: AppTypography.headlineMedium.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                'Direct escalation to our senior event management and resolution team.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 20),

              // Category Selector
              Text('Topic Category',
                  style: AppTypography.titleSmall
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                items: _categories
                    .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c, style: AppTypography.bodyMedium)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
                decoration: const InputDecoration(),
              ),
              const SizedBox(height: 14),

              // Subject
              Text('Inquiry Subject',
                  style: AppTypography.titleSmall
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _subjectController,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Subject is required'
                    : null,
                decoration: const InputDecoration(
                  hintText:
                      'e.g. Flight arrival time update for catering setup',
                ),
              ),
              const SizedBox(height: 14),

              // Related Booking ID
              Text('Related Booking ID (Optional)',
                  style: AppTypography.titleSmall
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _bookingIdController,
                decoration: const InputDecoration(
                  hintText: 'e.g. EVT-2026-8841',
                ),
              ),
              const SizedBox(height: 14),

              // Description
              Text('Details & Requests',
                  style: AppTypography.titleSmall
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Description is required'
                    : null,
                decoration: const InputDecoration(
                  hintText:
                      'Provide complete details and any time sensitivities...',
                ),
              ),
              const SizedBox(height: 24),

              LuxeButton(
                text: 'Submit Priority Ticket',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
