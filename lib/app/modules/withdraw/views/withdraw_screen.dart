import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/controller/wallet_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
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
        title: const Text(
          'Withdraw Funds',
          style: TextStyle(color: AppColors.textPrimary),
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
                    'Available Balance',
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
              'Withdrawal Amount',
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
                hintText: 'Enter amount',
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
                  label: 'All',
                  onTap: () => _amountController.text = balance.toString(),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Payment Method Selection
            Text(
              'Withdrawal Method',
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
                title: 'Bank Transfer',
                subtitle: paymentInfo!.bankTransfer!.accountNumber ?? 'Not set',
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
                        'No payment methods available. Please add one first.',
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
                      'Withdrawals typically process within 3-5 business days',
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
      bottomNavigationBar: buildContinueButton(balance),
    );
  }

  SafeArea buildContinueButton(int balance) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          ontap: () => _handleWithdraw(balance),
          isLoading: false.obs,
          child: Text(
            'Withdraw',
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

  void _handleWithdraw(int balance) {
    final amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      Get.snackbar(
        'Error',
        'Please enter a valid amount',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (amount > balance) {
      Get.snackbar(
        'Error',
        'Insufficient balance',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedMethod == null) {
      Get.snackbar(
        'Error',
        'Please select a withdrawal method',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.cardColor,
        title: const Text(
          'Confirm Withdrawal',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Withdraw $amount to your $selectedMethod account?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
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
                'Confirm',
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
