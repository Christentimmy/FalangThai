import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userController = Get.find<UserController>();
    final userModel = userController.userModel;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Transfer
            Obx(() {
              final paymentInfo = userModel.value?.paymentInfo;
              Map<String, String>? details = {};
              if (paymentInfo?.bankTransfer != null &&
                  paymentInfo!.bankTransfer!.accountHolderName!.isNotEmpty) {
                final accounName = paymentInfo.bankTransfer!.accountHolderName!
                    .split(" ")
                    .first;
                details = {
                  l10n.paymentDetailsAccountHolder: accounName,
                  l10n.paymentDetailsAccountNumber:
                      paymentInfo.bankTransfer!.accountNumber ?? "",
                  l10n.paymentDetailsBankName:
                      paymentInfo.bankTransfer!.bankName ?? "",
                };
              }
              return _PaymentMethodCard(
                icon: Icons.account_balance,
                title: l10n.withdrawBankTransfer,
                isConfigured: paymentInfo?.bankTransfer != null,
                details: details,
                onEdit: () => Get.toNamed(AppRoutes.editBankTransferScreen),
              );
            }),
            const SizedBox(height: 16),

            // PayPal
            Obx(() {
              final paymentInfo = userModel.value?.paymentInfo;
              dynamic details;
              if (paymentInfo?.paypal != null &&
                  paymentInfo!.paypal!.isNotEmpty) {
                details = {l10n.paymentDetailsEmail: paymentInfo.paypal!};
              }
              return _PaymentMethodCard(
                icon: Icons.payment,
                title: 'PayPal',
                isConfigured:
                    paymentInfo?.paypal != null &&
                    paymentInfo!.paypal!.isNotEmpty,
                details: details,
                onEdit: () => Get.toNamed(AppRoutes.editPayPalScreen),
              );
            }),
            const SizedBox(height: 16),

            // Stripe
            // Obx(() {
            //   final paymentInfo = userModel.value?.paymentInfo;
            //   dynamic details;
            //   if (paymentInfo?.stripe != null &&
            //       paymentInfo!.stripe!.isNotEmpty) {
            //     details = {'Account ID': paymentInfo.stripe!};
            //   }
            //   return _PaymentMethodCard(
            //     icon: Icons.credit_card,
            //     title: 'Stripe',
            //     isConfigured:
            //         paymentInfo?.stripe != null &&
            //         paymentInfo!.stripe!.isNotEmpty,
            //     details: details,
            //     onEdit: () => Get.toNamed(AppRoutes.editStripeScreen),
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Get.back(),
      ),
      title: Text(
        l10n.walletPaymentMethods,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isConfigured;
  final Map<String, String>? details;
  final VoidCallback onEdit;

  const _PaymentMethodCard({
    required this.icon,
    required this.title,
    required this.isConfigured,
    this.details,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      isConfigured
                          ? l10n.paymentConfigured
                          : l10n.paymentNotConfigured,
                      style: TextStyle(
                        color: isConfigured
                            ? Colors.green
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isConfigured
                      ? Colors.green.withOpacity(0.2)
                      : AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isConfigured
                      ? l10n.paymentStatusActive
                      : l10n.paymentStatusSetup,
                  style: TextStyle(
                    color: isConfigured ? Colors.green : AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (details != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: details!.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.key,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              e.value,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onEdit,
              icon: Icon(
                isConfigured ? Icons.edit : Icons.add,
                color: AppColors.primaryColor,
                size: 18,
              ),
              label: Text(
                isConfigured
                    ? l10n.paymentEditDetails
                    : l10n.paymentAddMethod,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
