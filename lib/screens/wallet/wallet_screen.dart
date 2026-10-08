import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/wallet_model.dart';
import '../../providers/wallet_provider.dart';
import '../../widgets/luxe_card.dart';
import 'add_payment_method_modal.dart';
import 'top_up_modal.dart';
import 'transaction_detail_modal.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String _selectedTxFilter = 'All';

  void _showTopUpModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TopUpModal(),
    );
  }

  void _showAddCardModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddPaymentMethodModal(),
    );
  }

  void _showTxDetail(WalletTransaction tx) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TransactionDetailModal(transaction: tx),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletProvider>();

    final filteredTransactions = wallet.transactions.where((tx) {
      if (_selectedTxFilter == 'All') return true;
      if (_selectedTxFilter == 'Deposits') {
        return tx.type == TransactionType.topUp;
      }
      if (_selectedTxFilter == 'Escrow') {
        return tx.type == TransactionType.bookingPayment;
      }
      if (_selectedTxFilter == 'Rewards') {
        return tx.type == TransactionType.cashbackReward;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Luxe Escrow & Wallet',
          style: AppTypography.headlineMedium.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_card, color: AppColors.deepAmber),
            onPressed: _showAddCardModal,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Luxury Balance Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1B1B1E),
                      Color(0xFF332318),
                      Color(0xFF903F00),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(0, 10),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.verified_user,
                                color: AppColors.sunlitAmber, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'ESCROW VAULT ACCOUNT',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.sunlitAmber,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'MEMBER VIP',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Available Escrow Balance',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormatter.format(wallet.balance),
                      style: AppTypography.displayLarge.copyWith(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Secondary stats row: In Active Escrow & Lifetime Cashback
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'In Protected Escrow',
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                CurrencyFormatter.format(wallet.escrowHold),
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.sunlitAmber,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                              width: 1,
                              height: 24,
                              color: Colors.white.withValues(alpha: 0.2)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Managed Assets',
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                CurrencyFormatter.format(wallet.totalAssets),
                                style: AppTypography.labelMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Quick Action Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _showTopUpModal,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Deposit Funds'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepAmber,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _showAddCardModal,
                      icon: const Icon(Icons.credit_card, size: 18),
                      label: const Text('Add Card'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.warmLinen, width: 1.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Saved Payment Methods Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stored Payment Vault',
                    style: AppTypography.headlineMedium.copyWith(fontSize: 18),
                  ),
                  Text(
                    '${wallet.paymentMethods.length} Methods',
                    style: AppTypography.bodySmall
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Payment Methods Horizontal Carousel
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: wallet.paymentMethods.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final pm = wallet.paymentMethods[index];
                  final isSelected = wallet.selectedMethodId == pm.id;

                  return GestureDetector(
                    onTap: () => wallet.selectPaymentMethod(pm.id),
                    child: Container(
                      width: 230,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pm.title,
                                style: AppTypography.titleSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                size: 16,
                                color: isSelected
                                    ? AppColors.deepAmber
                                    : AppColors.mutedStone,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            pm.subtitle,
                            style:
                                AppTypography.bodySmall.copyWith(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Transaction Activity Header & Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction & Escrow History',
                    style: AppTypography.headlineMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Deposits', 'Escrow', 'Rewards']
                          .map((filter) {
                        final isSelected = _selectedTxFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedTxFilter = filter);
                              }
                            },
                            selectedColor: AppColors.obsidianCharcoal,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.onSurfaceVariant,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: 12,
                            ),
                            backgroundColor: AppColors.alabasterVeil,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9999),
                              side:
                                  const BorderSide(color: AppColors.warmLinen),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Transactions List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tx = filteredTransactions[index];
                  final isCredit = tx.amount > 0;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LuxeCard(
                      onTap: () => _showTxDetail(tx),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCredit
                                  ? AppColors.emeraldSageLight
                                  : AppColors.amberLight,
                            ),
                            child: Icon(
                              isCredit
                                  ? Icons.arrow_downward
                                  : Icons.lock_outline,
                              color: isCredit
                                  ? AppColors.emeraldSage
                                  : AppColors.deepAmber,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx.title,
                                  style: AppTypography.titleSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  DateFormat('MMM d, yyyy • hh:mm a')
                                      .format(tx.date),
                                  style: AppTypography.bodySmall
                                      .copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            (isCredit ? '+' : '') +
                                CurrencyFormatter.format(tx.amount),
                            style: AppTypography.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isCredit
                                  ? AppColors.emeraldSage
                                  : AppColors.obsidianCharcoal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filteredTransactions.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
