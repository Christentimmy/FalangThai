import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/controller/wallet_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  String? selectedMethod;

  final walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userController = Get.find<UserController>();
    final wallet = userController.userModel.value?.wallet;
    final paymentInfo = userController.userModel.value?.paymentInfo;
    final balance = wallet?.balance ?? 0;
    final currency = wallet?.currency ?? 'USD';

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          l10n.walletWithdrawFunds,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.walletAvailableBalance,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$balance $currency',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Amount Input
            Text(
              l10n.withdrawAmountLabel,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                hintText: l10n.withdrawAmountHint,
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: AppColors.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _QuickAmountButton(
                  amount: 50,
                  currency: currency,
                  onTap: () => _amountController.text = '50',
                ),
                const SizedBox(width: 8),
                _QuickAmountButton(
                  amount: 100,
                  currency: currency,
                  onTap: () => _amountController.text = '100',
                ),
                const SizedBox(width: 8),
                _QuickAmountButton(
                  amount: 500,
                  currency: currency,
                  onTap: () => _amountController.text = '500',
                ),
                const SizedBox(width: 8),
                _QuickAmountButton(
                  amount: balance,
                  currency: currency,
                  label: l10n.withdrawAllLabel,
                  onTap: () => _amountController.text = balance.toString(),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Payment Method Selection
            Text(
              l10n.withdrawMethodLabel,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            if (paymentInfo?.bankTransfer != null)
              _PaymentMethodTile(
                icon: Icons.account_balance,
                title: l10n.withdrawBankTransfer,
                subtitle:
                    paymentInfo!.bankTransfer!.accountNumber ?? l10n.withdrawBankAccountNotSet,
                isSelected: selectedMethod == 'bank_transfer',
                onTap: () => setState(() => selectedMethod = 'bank_transfer'),
              ),

            if (paymentInfo?.paypal != null && paymentInfo!.paypal!.isNotEmpty)
              _PaymentMethodTile(
                icon: Icons.payment,
                title: 'PayPal',
                subtitle: paymentInfo.paypal ?? '',
                isSelected: selectedMethod == 'paypal',
                onTap: () => setState(() => selectedMethod = 'paypal'),
              ),

            if (paymentInfo?.stripe != null && paymentInfo!.stripe!.isNotEmpty)
              _PaymentMethodTile(
                icon: Icons.credit_card,
                title: 'Stripe',
                subtitle: 'Account ID: ${paymentInfo.stripe}',
                isSelected: selectedMethod == 'stripe',
                onTap: () => setState(() => selectedMethod = 'stripe'),
              ),

            if (paymentInfo?.bankTransfer == null &&
                (paymentInfo?.paypal == null || paymentInfo!.paypal!.isEmpty) &&
                (paymentInfo?.stripe == null || paymentInfo!.stripe!.isEmpty))
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.withdrawNoPaymentMethods,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // Processing Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.withdrawProcessingInfo,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildContinueButton(context, balance),
    );
  }

  SafeArea buildContinueButton(BuildContext context, int balance) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          ontap: () => _handleWithdraw(context, balance),
          isLoading: false.obs,
          child: Text(
            l10n.walletWithdrawFunds,
            style: GoogleFonts.fredoka(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  void _handleWithdraw(BuildContext context, int balance) {
    final l10n = AppLocalizations.of(context)!;
    final amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      Get.snackbar(
        l10n.withdrawErrorTitle,
        l10n.withdrawErrorInvalidAmount,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (amount > balance) {
      Get.snackbar(
        l10n.withdrawErrorTitle,
        l10n.withdrawErrorInsufficientBalance,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedMethod == null) {
      Get.snackbar(
        l10n.withdrawErrorTitle,
        l10n.withdrawErrorNoMethod,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Show confirmation dialog
    String methodLabel;
    switch (selectedMethod) {
      case 'bank_transfer':
        methodLabel = l10n.withdrawBankTransfer;
        break;
      case 'paypal':
        methodLabel = 'PayPal';
        break;
      case 'stripe':
        methodLabel = 'Stripe';
        break;
      default:
        methodLabel = selectedMethod!;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.cardColor,
        title: Text(
          l10n.withdrawConfirmTitle,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          l10n.withdrawConfirmMessage(amount, methodLabel),
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              l10n.withdrawCancel,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          SizedBox(
            width: 100,
            height: 45,
            child: CustomButton(
              ontap: () async {
                await walletController.requestWithdrawal(
                  amount: amount,
                  paymentMethod: selectedMethod!,
                );
              },
              isLoading: walletController.isloading,
              child: Text(
                l10n.withdrawConfirmButton,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     await walletController.requestWithdrawal(
          //       amount: amount,
          //       paymentMethod: selectedMethod!,
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColors.primaryColor,
          //   ),
          //   child: const Text('Confirm', style: TextStyle(color: Colors.black)),
          // ),
        ],
      ),
    );
  }
}

class _QuickAmountButton extends StatelessWidget {
  final int amount;
  final String currency;
  final String? label;
  final VoidCallback onTap;

  const _QuickAmountButton({
    required this.amount,
    required this.currency,
    this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
          ),
          child: Text(
            label ?? '$amount',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 20),
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
                      fontSize: 14,
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
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 24)
            else
              Icon(
                Icons.radio_button_unchecked,
                color: AppColors.textSecondary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
