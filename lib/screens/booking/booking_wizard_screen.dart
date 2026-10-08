import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/booking_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/step_progress_bar.dart';
import '../../widgets/sticky_booking_dock.dart';
import 'booking_success_screen.dart';
import 'steps/step1_package_addons.dart';
import 'steps/step2_schedule_location.dart';
import 'steps/step3_event_details.dart';
import 'steps/step4_payment_method.dart';
import 'steps/step5_order_summary.dart';

class BookingWizardScreen extends StatefulWidget {
  const BookingWizardScreen({super.key});

  @override
  State<BookingWizardScreen> createState() => _BookingWizardScreenState();
}

class _BookingWizardScreenState extends State<BookingWizardScreen> {
  int _currentStep = 1;
  final PageController _pageController = PageController();

  final List<String> _stepTitles = [
    'Package & Add-ons',
    'Schedule & Venue',
    'Event Details',
    'Payment & Escrow',
    'Summary & Review',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 5) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _confirmBooking();
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _confirmBooking() {
    final bookingProvider = context.read<BookingProvider>();
    final walletProvider = context.read<WalletProvider>();

    final createdBooking = bookingProvider.confirmDraftBooking();

    // Record wallet deduction / escrow hold
    walletProvider.recordBookingDeduction(
      createdBooking.totalAmount,
      createdBooking.id,
      createdBooking.service.title,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BookingSuccessScreen(booking: createdBooking),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: CustomAppBar(
        title: 'Reserve Celebration',
        onBack: _prevStep,
        subtitleWidget: Text(
          booking.draftService?.title ?? '',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.deepAmber,
            fontSize: 11,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppColors.surfaceContainerLowest,
            child: StepProgressBar(
              currentStep: _currentStep,
              totalSteps: 5,
              stepLabels: _stepTitles,
            ),
          ),
          const Divider(color: AppColors.warmLinen, height: 1),

          // Wizard Pages
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Step1PackageAddons(),
                Step2ScheduleLocation(),
                Step3EventDetails(),
                Step4PaymentMethod(),
                Step5OrderSummary(),
              ],
            ),
          ),

          // Sticky Bottom Confirmation Action Dock
          StickyBookingDock(
            price: booking.draftGrandTotal,
            priceSubtitle: _currentStep == 5 ? 'Total Escrow Deposit' : 'Estimated Total',
            buttonText: _currentStep == 5 ? 'Confirm & Authorize' : 'Continue',
            buttonIcon: _currentStep == 5 ? Icons.lock : Icons.arrow_forward,
            onButtonPressed: _nextStep,
          ),
        ],
      ),
    );
  }
}
