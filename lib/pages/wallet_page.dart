import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';
import 'package:eventora/widgets/transaction_tile.dart';
import 'package:eventora/routes/app_router.dart';
import 'package:eventora/providers/wallet_provider.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = context.watch<WalletProvider>();

    return Scaffold(
      backgroundColor: AppColors.canvasBase,
      appBar: AppBar(
        backgroundColor: AppColors.canvasBase,
        elevation: 0,
        title: Text('Wallet', style: AppTypography.headlineMD),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.marginMobile),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.deepOnyx,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Balance', style: AppTypography.bodySM.copyWith(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(
                      '\$${walletProvider.balance.toStringAsFixed(2)}',
                      style: AppTypography.headlineXLMobile.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, AppRouter.addFunds),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amberAccent,
                          foregroundColor: AppColors.deepOnyx,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          elevation: 0,
                        ),
                        child: Text('Add Funds', style: AppTypography.labelMD),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.marginMobile),
              child: Text('Transaction History', style: AppTypography.headlineSM),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: walletProvider.transactions.isEmpty
                  ? Center(child: Text('No transactions yet', style: AppTypography.bodyMD.copyWith(color: AppColors.mutedText)))
                  : ListView.builder(
                      itemCount: walletProvider.transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionTile(transaction: walletProvider.transactions[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
