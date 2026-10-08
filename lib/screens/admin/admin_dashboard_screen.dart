import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/admin_model.dart';
import '../../models/booking_model.dart';
import '../../providers/admin_provider.dart';
import '../../providers/booking_provider.dart';
import '../../providers/support_provider.dart';
import '../auth/login_screen.dart';
import '../../widgets/luxe_card.dart';
import '../../widgets/verified_badge.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProvider>();
    final analytics = admin.analytics;

    if (!admin.isAdminAuthenticated) {
      return Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 40),
                const SizedBox(height: 12),
                Text(
                  'Admin sign-in required',
                  style: AppTypography.headlineMedium.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen.admin(),
                    ),
                  ),
                  child: const Text('Continue to admin sign-in'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.obsidianCharcoal,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'ADMIN CONSOLE',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.sunlitAmber,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Eventora Master Operations',
              style: AppTypography.headlineMedium.copyWith(fontSize: 17),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Sign out of admin console',
            icon: const Icon(Icons.logout),
            onPressed: () {
              admin.endAdminSession();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen.admin(),
                ),
                (_) => false,
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.deepAmber,
          indicatorWeight: 3,
          labelColor: AppColors.deepAmber,
          unselectedLabelColor: AppColors.mutedStone,
          labelStyle:
              AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700),
          tabs: const [
            Tab(text: 'Overview & GMV'),
            Tab(text: 'Vendor Onboarding'),
            Tab(text: 'Bookings & Escrow'),
            Tab(text: 'Tickets & Support'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(analytics, admin),
          _buildVendorOnboardingTab(admin),
          _buildBookingsEscrowTab(context),
          _buildSupportTicketsTab(context),
        ],
      ),
    );
  }

  // TAB 1: OVERVIEW & GMV
  Widget _buildOverviewTab(dynamic analytics, AdminProvider admin) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat Metrics Grid
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Gross Marketplace (GMV)',
                  CurrencyFormatter.format(analytics.totalGmv),
                  '+18.4% this month',
                  Icons.trending_up,
                  AppColors.emeraldSage,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Active Escrow Funds',
                  CurrencyFormatter.format(analytics.activeEscrowHold),
                  '100% Insured in Vault',
                  Icons.lock_clock,
                  AppColors.deepAmber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Platform Net Fee (4%)',
                  CurrencyFormatter.format(analytics.totalCommissionEarned),
                  'Direct revenue',
                  Icons.account_balance_wallet,
                  AppColors.obsidianCharcoal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Active Vetted Partners',
                  '${analytics.activeVendorsCount} Masters',
                  '${analytics.satisfactionRate}% Satisfaction',
                  Icons.verified,
                  AppColors.emeraldSage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Escrow Actions Box
          Text(
            'Escrow Liquidity & Release Controls',
            style: AppTypography.headlineMedium.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),
          LuxeCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pending Milestone Disbursements',
                              style: AppTypography.titleSmall
                                  .copyWith(fontWeight: FontWeight.w700)),
                          Text(
                              'Releases funds to provider bank accounts upon signoff',
                              style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        admin.releaseEscrowToVendor(4275.0);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Escrow payout authorized and wired to Elena Rostova!'),
                            backgroundColor: AppColors.emeraldSage,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldSage,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                      ),
                      child: const Text('Release \$4,275 Payout'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Security & Audit Log
          Text(
            'OWASP MASVS Platform Integrity',
            style: AppTypography.headlineMedium.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),
          LuxeCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildAuditRow('API Tokenization & Rate Limiting',
                    'Enforced (200 req/min max)'),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildAuditRow(
                    'Payment Vault PCI-DSS Level 1', 'Compliant & Active'),
                const Divider(color: AppColors.warmLinen, height: 16),
                _buildAuditRow(
                    'Active Admin Session', 'Superuser / Master Dispatcher'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB 2: VENDOR ONBOARDING
  Widget _buildVendorOnboardingTab(AdminProvider admin) {
    final apps = admin.applications;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: apps.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  'Vendor applications',
                  style: AppTypography.headlineMedium.copyWith(fontSize: 19),
                ),
              ),
              FilledButton.icon(
                onPressed: () => _showVendorEditor(admin),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add vendor'),
              ),
            ],
          );
        }

        final app = apps[index - 1];

        return LuxeCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      app.businessName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.titleSmall
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: app.isApproved
                          ? AppColors.emeraldSageLight
                          : AppColors.amberLight,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      app.isApproved ? 'VERIFIED PARTNER' : 'PENDING REVIEW',
                      style: AppTypography.labelSmall.copyWith(
                        color: app.isApproved
                            ? AppColors.emeraldSage
                            : AppColors.deepAmber,
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Applicant: ${app.applicantName} • Category: ${app.category} • Location: ${app.location}',
                style: AppTypography.bodySmall,
              ),
              Text(
                'Insurance Validation: ${app.insuranceDocRef}',
                style: AppTypography.bodySmall.copyWith(
                    color: AppColors.deepAmber, fontWeight: FontWeight.w600),
              ),
              const Divider(color: AppColors.warmLinen, height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Starting Tier: ${CurrencyFormatter.format(app.startingPrice)}',
                    style: AppTypography.labelMedium
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (!app.isApproved)
                    ElevatedButton(
                      onPressed: () {
                        admin.approveVendorApplication(app.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${app.businessName} approved as verified partner!'),
                            backgroundColor: AppColors.emeraldSage,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepAmber,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        minimumSize: const Size(0, 34),
                      ),
                      child: const Text('Approve & Verify'),
                    )
                  else
                    const VerifiedBadge(text: 'Verified Partner Active'),
                ],
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'Edit ${app.businessName}',
                      onPressed: () => _showVendorEditor(admin, vendor: app),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      tooltip: 'Delete ${app.businessName}',
                      onPressed: () => _confirmDeleteVendor(admin, app),
                      color: AppColors.error,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showVendorEditor(
    AdminProvider admin, {
    VendorApplication? vendor,
  }) async {
    final formKey = GlobalKey<FormState>();
    final businessName = TextEditingController(text: vendor?.businessName);
    final applicantName = TextEditingController(text: vendor?.applicantName);
    final category = TextEditingController(text: vendor?.category);
    final location = TextEditingController(text: vendor?.location);
    final startingPrice = TextEditingController(
      text: vendor?.startingPrice.toStringAsFixed(0),
    );
    final portfolioUrl = TextEditingController(text: vendor?.portfolioUrl);
    final insuranceDocRef =
        TextEditingController(text: vendor?.insuranceDocRef);

    String? requiredField(String? value) =>
        (value ?? '').trim().isEmpty ? 'Required' : null;

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(vendor == null ? 'Add vendor' : 'Edit vendor'),
        content: SizedBox(
          width: 440,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: businessName,
                    decoration:
                        const InputDecoration(labelText: 'Business name'),
                    validator: requiredField,
                  ),
                  TextFormField(
                    controller: applicantName,
                    decoration:
                        const InputDecoration(labelText: 'Contact name'),
                    validator: requiredField,
                  ),
                  TextFormField(
                    controller: category,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: requiredField,
                  ),
                  TextFormField(
                    controller: location,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: requiredField,
                  ),
                  TextFormField(
                    controller: startingPrice,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Starting price',
                      prefixText: '\$ ',
                    ),
                    validator: (value) {
                      final price = double.tryParse(value ?? '');
                      return price == null || !price.isFinite || price < 0
                          ? 'Enter a valid non-negative price.'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: portfolioUrl,
                    keyboardType: TextInputType.url,
                    decoration:
                        const InputDecoration(labelText: 'Portfolio URL'),
                    validator: requiredField,
                  ),
                  TextFormField(
                    controller: insuranceDocRef,
                    decoration:
                        const InputDecoration(labelText: 'Insurance reference'),
                    validator: requiredField,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: Text(vendor == null ? 'Add vendor' : 'Save changes'),
          ),
        ],
      ),
    );

    if (saved == true) {
      final values = {
        'businessName': businessName.text,
        'applicantName': applicantName.text,
        'category': category.text,
        'location': location.text,
        'startingPrice': startingPrice.text,
        'portfolioUrl': portfolioUrl.text,
        'insuranceDocRef': insuranceDocRef.text,
      };
      final price = double.parse(values['startingPrice']!);
      if (vendor == null) {
        admin.addVendorApplication(
          businessName: values['businessName']!,
          applicantName: values['applicantName']!,
          category: values['category']!,
          location: values['location']!,
          startingPrice: price,
          portfolioUrl: values['portfolioUrl']!,
          insuranceDocRef: values['insuranceDocRef']!,
        );
      } else {
        admin.updateVendorApplication(
          id: vendor.id,
          businessName: values['businessName']!,
          applicantName: values['applicantName']!,
          category: values['category']!,
          location: values['location']!,
          startingPrice: price,
          portfolioUrl: values['portfolioUrl']!,
          insuranceDocRef: values['insuranceDocRef']!,
        );
      }
    }

    await WidgetsBinding.instance.endOfFrame;
    for (final controller in [
      businessName,
      applicantName,
      category,
      location,
      startingPrice,
      portfolioUrl,
      insuranceDocRef,
    ]) {
      controller.dispose();
    }
  }

  Future<void> _confirmDeleteVendor(
    AdminProvider admin,
    VendorApplication vendor,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete vendor application?'),
        content: Text('Remove ${vendor.businessName} from the vendor list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) admin.deleteVendorApplication(vendor.id);
  }

  // TAB 3: BOOKINGS & ESCROW
  Widget _buildBookingsEscrowTab(BuildContext context) {
    final bookings = context.watch<BookingProvider>().bookings;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final b = bookings[index];

        return LuxeCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${b.id} • ${b.service.category}',
                    style: AppTypography.labelSmall.copyWith(
                        color: AppColors.deepAmber,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    b.status.shortLabel.toUpperCase(),
                    style: AppTypography.labelSmall
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                b.service.title,
                style: AppTypography.titleSmall
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'Date: ${DateFormat('MMM d, yyyy').format(b.eventDate)} • Escrow Total: ${CurrencyFormatter.format(b.totalAmount)}',
                style: AppTypography.bodySmall,
              ),
              const Divider(color: AppColors.warmLinen, height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment: ${b.paymentMethodTitle}',
                    style: AppTypography.bodySmall.copyWith(fontSize: 11),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Audit log generated for ${b.id}')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      minimumSize: const Size(0, 32),
                    ),
                    child: const Text('View Full Escrow Audit',
                        style: TextStyle(fontSize: 11)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // TAB 4: TICKETS & SUPPORT
  Widget _buildSupportTicketsTab(BuildContext context) {
    final support = context.watch<SupportProvider>();

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: support.tickets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final ticket = support.tickets[index];

        return LuxeCard(
          padding: const EdgeInsets.all(16),
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
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.emeraldSageLight,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'STATUS: RESOLVED',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.emeraldSage,
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(ticket.subject,
                  style: AppTypography.titleSmall
                      .copyWith(fontWeight: FontWeight.w700)),
              Text(ticket.description, style: AppTypography.bodySmall),
              const SizedBox(height: 8),
              Text(
                'Related Booking: ${ticket.relatedBookingId}',
                style: AppTypography.bodySmall
                    .copyWith(fontSize: 11, color: AppColors.mutedStone),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricCard(
      String title, String value, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warmLinen),
        boxShadow: const [AppColors.cardRestShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 20, color: color),
              Expanded(
                child: Text(
                  sub,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: AppTypography.priceCard
                  .copyWith(fontSize: 17, color: AppColors.obsidianCharcoal)),
          const SizedBox(height: 2),
          Text(title,
              style: AppTypography.bodySmall.copyWith(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildAuditRow(String title, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.check_circle,
                size: 14, color: AppColors.emeraldSage),
            const SizedBox(width: 4),
            Text(status,
                style: AppTypography.bodySmall.copyWith(
                    fontSize: 11,
                    color: AppColors.emeraldSage,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
