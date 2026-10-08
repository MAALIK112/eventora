import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/service_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/service_provider.dart';
import '../../widgets/sticky_booking_dock.dart';
import '../../widgets/verified_badge.dart';
import '../booking/booking_wizard_screen.dart';
import '../support/live_chat_screen.dart';
import 'widgets/package_selector_card.dart';
import 'widgets/provider_profile_card.dart';
import 'widgets/reviews_list_section.dart';
import 'widgets/service_gallery_view.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String serviceId;

  const ServiceDetailScreen({
    super.key,
    required this.serviceId,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ServicePackage? _selectedPackage;
  final Set<String> _selectedAddonIds = {};

  @override
  void initState() {
    super.initState();
    final service =
        context.read<ServiceProvider>().getServiceById(widget.serviceId);
    if (service != null && service.packages.isNotEmpty) {
      // Default to popular package or first
      _selectedPackage = service.packages.firstWhere(
        (p) => p.isPopular,
        orElse: () => service.packages.first,
      );
    }
  }

  double get _currentTotalPrice {
    double total = _selectedPackage?.price ?? 0.0;
    final service =
        context.read<ServiceProvider>().getServiceById(widget.serviceId);
    if (service != null) {
      for (final addon in service.availableAddons) {
        if (_selectedAddonIds.contains(addon.id)) {
          total += addon.price;
        }
      }
    }
    return total;
  }

  void _proceedToBooking(EventService service) {
    final bookingProvider = context.read<BookingProvider>();
    bookingProvider.initDraft(
      service: service,
      package: _selectedPackage,
    );

    // Add selected add-ons to draft
    for (final addon in service.availableAddons) {
      if (_selectedAddonIds.contains(addon.id)) {
        bookingProvider.toggleDraftAddon(addon);
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BookingWizardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service =
        context.watch<ServiceProvider>().getServiceById(widget.serviceId);
    final serviceProvider = context.watch<ServiceProvider>();

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Service Detail')),
        body: const Center(child: Text('Service not found')),
      );
    }

    final isWishlisted = serviceProvider.isWishlisted(service.id);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Media Gallery Sliver App Bar
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: AppColors.obsidianCharcoal,
                leading: IconButton(
                  icon: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 16, color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: isWishlisted ? Colors.redAccent : Colors.white,
                      ),
                    ),
                    onPressed: () => serviceProvider.toggleWishlist(service.id),
                  ),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      child: const Icon(Icons.share_outlined,
                          size: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Service link copied to clipboard')),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: ServiceGalleryView(images: service.images),
                ),
              ),

              // Content Body
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category & Verified Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.alabasterVeil,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.warmLinen),
                            ),
                            child: Text(
                              service.category.toUpperCase(),
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.deepAmber,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          if (service.provider.isVerified)
                            const VerifiedBadge(text: 'Verified Master'),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        service.title,
                        style:
                            AppTypography.displayMobile.copyWith(fontSize: 23),
                      ),
                      const SizedBox(height: 8),

                      // Location & Rating line
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 16, color: AppColors.deepAmber),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              service.location,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.midnightSlate,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: AppColors.sunlitAmber, size: 16),
                              const SizedBox(width: 3),
                              Text(
                                service.rating.toStringAsFixed(2),
                                style: AppTypography.labelMedium
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                ' (${service.reviewsCount} reviews)',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Description
                      Text(
                        service.description,
                        style: AppTypography.bodyLarge.copyWith(height: 1.55),
                      ),
                      const SizedBox(height: 20),

                      // Highlights
                      Text(
                        'Service Highlights',
                        style:
                            AppTypography.headlineMedium.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.alabasterVeil,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.warmLinen),
                        ),
                        child: Column(
                          children: service.highlights.map((h) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle,
                                      size: 16, color: AppColors.emeraldSage),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      h,
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.obsidianCharcoal,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Select Package Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Service Tier',
                            style: AppTypography.headlineMedium
                                .copyWith(fontSize: 19),
                          ),
                          Text(
                            '${service.packages.length} Packages',
                            style: AppTypography.bodySmall
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: service.packages.map((pkg) {
                          final isSelected = _selectedPackage?.id == pkg.id;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PackageSelectorCard(
                              package: pkg,
                              isSelected: isSelected,
                              onSelect: () =>
                                  setState(() => _selectedPackage = pkg),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Bespoke Add-ons
                      if (service.availableAddons.isNotEmpty) ...[
                        Text(
                          'Enhance Your Experience (Add-ons)',
                          style: AppTypography.headlineMedium
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: service.availableAddons.map((addon) {
                            final isAdded =
                                _selectedAddonIds.contains(addon.id);
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isAdded
                                    ? AppColors.amberLight
                                        .withValues(alpha: 0.3)
                                    : AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isAdded
                                      ? AppColors.deepAmber
                                      : AppColors.warmLinen,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isAdded,
                                    activeColor: AppColors.deepAmber,
                                    onChanged: (val) {
                                      setState(() {
                                        if (isAdded) {
                                          _selectedAddonIds.remove(addon.id);
                                        } else {
                                          _selectedAddonIds.add(addon.id);
                                        }
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          addon.name,
                                          style: AppTypography.titleSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          addon.description,
                                          style: AppTypography.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '+${CurrencyFormatter.format(addon.price)}',
                                    style: AppTypography.labelMedium.copyWith(
                                      color: AppColors.deepAmber,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Provider Profile Card
                      Text(
                        'About The Provider',
                        style:
                            AppTypography.headlineMedium.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ProviderProfileCard(
                        provider: service.provider,
                        onContactPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const LiveChatScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Escrow & Cancellation Guarantee
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldSageLight,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color:
                                  AppColors.emeraldSage.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.shield_outlined,
                                color: AppColors.emeraldSage, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '100% Escrow Protection & Flexible Cancellation',
                                    style: AppTypography.titleSmall.copyWith(
                                      color: AppColors.emeraldSage,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    service.cancellationPolicy,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.obsidianCharcoal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Reviews List Section
                      ReviewsListSection(
                        reviews: service.reviews,
                        rating: service.rating,
                        totalCount: service.reviewsCount,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Bottom Dock
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: StickyBookingDock(
              price: _currentTotalPrice,
              priceSubtitle: _selectedPackage?.tier ?? 'Tier Price',
              buttonText: 'Reserve Date',
              isSecondaryActionAvailable: true,
              onSecondaryAction: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LiveChatScreen()),
                );
              },
              onButtonPressed: () => _proceedToBooking(service),
            ),
          ),
        ],
      ),
    );
  }
}
