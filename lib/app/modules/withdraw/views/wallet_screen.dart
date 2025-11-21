import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final userController = Get.find<UserController>();
    final userModel = userController.userModel;
    final currency = userModel.value?.wallet?.currency ?? 'USD';

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.3),
                    AppColors.cardColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.walletAvailableBalance,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    return Text(
                      '${userModel.value?.wallet?.balance ?? 0} $currency',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return _StatCard(
                      title: text.walletTotalEarned,
                      amount: userModel.value?.wallet?.totalEarned ?? 0,
                      currency: currency,
                      icon: Icons.trending_up,
                      color: Colors.green,
                    );
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() {
                    return _StatCard(
                      title: text.walletWithdrawn,
                      amount: userModel.value?.wallet?.totalWithdrawn ?? 0,
                      currency: currency,
                      icon: Icons.trending_down,
                      color: Colors.orange,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 32),

            _ActionButton(
              icon: Icons.account_balance_wallet,
              title: text.walletWithdrawFunds,
              subtitle: text.walletWithdrawFundsSubtitle,
              onTap: () => Get.toNamed(AppRoutes.withdrawScreen),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.payment,
              title: text.walletPaymentMethods,
              subtitle: text.walletPaymentMethodsSubtitle,
              onTap: () => Get.toNamed(AppRoutes.paymentMethodScreen),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.history,
              title: text.walletTransactionHistory,
              subtitle: text.walletTransactionHistorySubtitle,
              onTap: () => Get.toNamed(AppRoutes.transactionHistoryScreen),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    final text = AppLocalizations.of(Get.context!)!;
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: Colors.white,
      elevation: 0,
      title: Text(
        text.walletTitle,
        style: GoogleFonts.fredoka(color: AppColors.textPrimary),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history, color: AppColors.primaryColor),
          onPressed: () => Get.toNamed(AppRoutes.transactionHistoryScreen),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int amount;
  final String currency;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.currency,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            '$amount $currency',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
