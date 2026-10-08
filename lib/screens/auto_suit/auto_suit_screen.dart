import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../providers/auto_suit_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/luxe_button.dart';
import '../../widgets/luxe_card.dart';
import 'auto_suit_result_screen.dart';

class AutoSuitScreen extends StatefulWidget {
  const AutoSuitScreen({super.key});

  @override
  State<AutoSuitScreen> createState() => _AutoSuitScreenState();
}

class _AutoSuitScreenState extends State<AutoSuitScreen> {
  final List<String> _aesthetics = [
    'Royal Opulence & Estate Glasshouse',
    'Modern Minimalist Parisian Haute',
    'Sunset Garden & Classical String Symphony',
    'Canyon Candlelight & Wine Country Romance',
  ];

  Future<void> _pickDate() async {
    final autoSuit = context.read<AutoSuitProvider>();
    final picked = await showDatePicker(
      context: context,
      initialDate: autoSuit.targetDate,
      firstDate: DateTime.now().add(const Duration(days: 7)),
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
      autoSuit.setTargetDate(picked);
    }
  }

  void _runAutoSuiting() {
    final autoSuit = context.read<AutoSuitProvider>();
    autoSuit.generateSuitedBundles();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AutoSuitResultScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final autoSuit = context.watch<AutoSuitProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'AI Auto-Suiting Concierge'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Intro Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2C1605),
                    Color(0xFF532402),
                    Color(0xFF903F00),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    offset: const Offset(0, 8),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: AppColors.sunlitAmber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'INTELLIGENT MULTI-VENDOR HARMONY',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.sunlitAmber,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Synthesize Your Perfectly Suited Celebration',
                    style: AppTypography.headlineMedium.copyWith(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Our algorithm curates and synchronizes top venues, Michelin chefs, fine art photographers, and musicians into a seamless bundle with up to 18% multi-vendor savings.',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 1. Event Type
            Text(
              '1. Select Celebration Type',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.eventTypes.map((type) {
                final isSelected = autoSuit.eventType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) autoSuit.setEventType(type);
                  },
                  selectedColor: AppColors.obsidianCharcoal,
                  labelStyle: TextStyle(
                    color:
                        isSelected ? Colors.white : AppColors.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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

            // 2. Guest Count Scale
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2. Guest Attendance Scale',
                  style: AppTypography.headlineMedium.copyWith(fontSize: 18),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.amberLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${autoSuit.guestCount} Guests',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.deepAmber,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Slider(
                value: autoSuit.guestCount.toDouble(),
                min: 20,
                max: 400,
                divisions: 38,
                activeColor: AppColors.deepAmber,
                inactiveColor: AppColors.surfaceContainerHigh,
                onChanged: (val) => autoSuit.setGuestCount(val.toInt()),
              ),
            ),
            const SizedBox(height: 24),

            // 3. Target Budget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '3. Target Budget Envelope',
                  style: AppTypography.headlineMedium.copyWith(fontSize: 18),
                ),
                Text(
                  CurrencyFormatter.format(autoSuit.targetBudget),
                  style: AppTypography.priceCard.copyWith(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LuxeCard(
              padding: const EdgeInsets.all(16),
              child: Slider(
                value: autoSuit.targetBudget,
                min: 3000,
                max: 35000,
                divisions: 32,
                activeColor: AppColors.deepAmber,
                inactiveColor: AppColors.surfaceContainerHigh,
                onChanged: (val) => autoSuit.setTargetBudget(val),
              ),
            ),
            const SizedBox(height: 24),

            // 4. Aesthetic & Atmosphere
            Text(
              '4. Desired Aesthetic & Atmosphere',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Column(
              children: _aesthetics.map((aes) {
                final isSelected = autoSuit.preferredAesthetic == aes;
                return GestureDetector(
                  onTap: () => autoSuit.setPreferredAesthetic(aes),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.amberLight.withValues(alpha: 0.35)
                          : AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(14),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            aes,
                            style: AppTypography.titleSmall.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
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

            // 5. Target Date
            Text(
              '5. Desired Event Date',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            LuxeCard(
              onTap: _pickDate,
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          color: AppColors.deepAmber, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('EEEE, MMMM dd, yyyy')
                            .format(autoSuit.targetDate),
                        style: AppTypography.titleSmall
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppColors.mutedStone),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Run Button
            LuxeButton(
              text: 'Synthesize Suited Packages',
              icon: Icons.auto_awesome,
              onPressed: _runAutoSuiting,
            ),
          ],
        ),
      ),
    );
  }
}
