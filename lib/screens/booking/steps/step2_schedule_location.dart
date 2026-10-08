import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/security/input_validator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../providers/booking_provider.dart';
import '../../../widgets/luxe_card.dart';

class Step2ScheduleLocation extends StatefulWidget {
  const Step2ScheduleLocation({super.key});

  @override
  State<Step2ScheduleLocation> createState() => _Step2ScheduleLocationState();
}

class _Step2ScheduleLocationState extends State<Step2ScheduleLocation> {
  final TextEditingController _locationController = TextEditingController();

  final List<String> _timeSlots = [
    '09:00 - 14:00 (Morning Brunch & Setup)',
    '15:00 - 21:00 (Sunset Gala & Reception)',
    '18:00 - 00:00 (Evening Banquet & Party)',
    'Full Day Access (10:00 - 01:00)',
  ];

  @override
  void initState() {
    super.initState();
    final booking = context.read<BookingProvider>();
    _locationController.text = booking.draftLocation.isNotEmpty
        ? booking.draftLocation
        : booking.draftService?.location ?? '';
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final booking = context.read<BookingProvider>();
    final picked = await showDatePicker(
      context: context,
      initialDate: booking.draftDate,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.deepAmber,
              onPrimary: Colors.white,
              onSurface: AppColors.obsidianCharcoal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      booking.setDraftDate(picked);
    }
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
            'Date, Time & Venue',
            style: AppTypography.headlineMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Specify the celebration schedule and destination for team logistics.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 20),

          // Date Picker Card
          Text(
            'Event Date',
            style:
                AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          LuxeCard(
            onTap: _pickDate,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.amberLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.calendar_month,
                          color: AppColors.deepAmber, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, MMMM d, yyyy')
                              .format(booking.draftDate),
                          style: AppTypography.titleSmall
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tap to modify celebration date',
                          style: AppTypography.bodySmall.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.mutedStone),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Time Slot Selector
          Text(
            'Time Window',
            style:
                AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Column(
            children: _timeSlots.map((slot) {
              final isSelected = booking.draftTime == slot;
              return GestureDetector(
                onTap: () => booking.setDraftTime(slot),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.amberLight.withValues(alpha: 0.3)
                        : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.deepAmber
                          : AppColors.warmLinen,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? AppColors.deepAmber
                            : AppColors.mutedStone,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          slot,
                          style: AppTypography.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.obsidianCharcoal
                                : AppColors.onSurfaceVariant,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Venue Location Input
          Text(
            'Venue Address / Destination',
            style:
                AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _locationController,
            onChanged: (val) {
              final sanitized = InputValidator.sanitizeText(val);
              booking.setDraftLocation(sanitized);
            },
            decoration: const InputDecoration(
              hintText: 'e.g. Bel-Air Estate Villa, 90210 Los Angeles, CA',
              prefixIcon:
                  Icon(Icons.location_on_outlined, color: AppColors.deepAmber),
            ),
          ),
        ],
      ),
    );
  }
}
