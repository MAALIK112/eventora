import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/eventora_button.dart';
import 'package:eventora/routes/app_router.dart';

class EventPlanningPage extends StatelessWidget {
  const EventPlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Event Planning & Management', style: AppTypography.headlineMD.copyWith(color: Colors.white)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: Colors.grey), // Placeholder for image
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.deepOnyx.withValues(alpha: 0.8)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.marginMobile),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Professional planning for unforgettable moments.',
                  style: AppTypography.bodyMD,
                ),
                const SizedBox(height: 24),
                _buildCategoryTile(context, Icons.event, 'Event Planning & Management'),
                _buildCategoryTile(context, Icons.business, 'Corporate Events'),
                _buildCategoryTile(context, Icons.favorite, 'Weddings'),
                _buildCategoryTile(context, Icons.celebration, 'Private Parties'),
                _buildCategoryTile(context, Icons.mic, 'Conferences & Exhibitions'),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginMobile),
          child: EventoraButton(
            text: 'Book Now',
            isFullWidth: true,
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTypography.labelLG),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Navigator.pushNamed(context, AppRouter.serviceList, arguments: title),
    );
  }
}
