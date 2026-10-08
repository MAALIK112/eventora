import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/security/input_validator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/booking_provider.dart';
import '../../../widgets/luxe_card.dart';

class Step3EventDetails extends StatefulWidget {
  const Step3EventDetails({super.key});

  @override
  State<Step3EventDetails> createState() => _Step3EventDetailsState();
}

class _Step3EventDetailsState extends State<Step3EventDetails> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final booking = context.read<BookingProvider>();
    _notesController.text = booking.draftSpecialRequests;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Celebration Specifications',
            style: AppTypography.headlineMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Tell us about the milestone nature and guest scale to tailor the service.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 20),

          // Event Type Dropdown/Wrap
          Text(
            'Event Classification',
            style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppConstants.eventTypes.map((type) {
              final isSelected = booking.draftEventType == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) booking.setDraftEventType(type);
                },
                selectedColor: AppColors.obsidianCharcoal,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 13,
                ),
                backgroundColor: AppColors.alabasterVeil,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                  side: const BorderSide(color: AppColors.warmLinen),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Guest Count Stepper Card
          Text(
            'Estimated Guest Attendance',
            style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          LuxeCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Attendees',
                      style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: AppColors.deepAmber),
                          onPressed: booking.draftGuestCount > 10
                              ? () => booking.setDraftGuestCount(booking.draftGuestCount - 10)
                              : null,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.alabasterVeil,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.warmLinen),
                          ),
                          child: Text(
                            '${booking.draftGuestCount} Guests',
                            style: AppTypography.titleSmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.obsidianCharcoal,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, color: AppColors.deepAmber),
                          onPressed: () => booking.setDraftGuestCount(booking.draftGuestCount + 10),
                        ),
                      ],
                    ),
                  ],
                ),
                Slider(
                  value: booking.draftGuestCount.toDouble().clamp(10, 1000),
                  min: 10,
                  max: 500,
                  divisions: 49,
                  activeColor: AppColors.deepAmber,
                  inactiveColor: AppColors.surfaceContainerHigh,
                  onChanged: (val) => booking.setDraftGuestCount(val.toInt()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Special Notes and Requests
          Text(
            'Special Requests & Dietary Requirements',
            style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 4,
            onChanged: (val) {
              final sanitized = InputValidator.sanitizeText(val);
              booking.setDraftSpecialRequests(sanitized);
            },
            decoration: const InputDecoration(
              hintText: 'Share any key instructions, shot list preferences, song entrance requests, or VIP guest accommodations...',
            ),
          ),
        ],
      ),
    );
  }
}
