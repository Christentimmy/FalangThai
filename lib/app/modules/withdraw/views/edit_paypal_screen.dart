import 'package:falangthai/app/controller/wallet_controller.dart';
import 'package:falangthai/app/modules/withdraw/widgets/input_field_widget.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPayPalScreen extends StatefulWidget {
  const EditPayPalScreen({super.key});

  @override
  State<EditPayPalScreen> createState() => _EditPayPalScreenState();
}

class _EditPayPalScreenState extends State<EditPayPalScreen> {
  final _emailController = TextEditingController();
  final walletController = Get.find<WalletController>();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formkey,
              child: InputField(
                controller: _emailController,
                label: l10n.paypalEmailLabel,
                hint: l10n.paypalEmailHint,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.paypalInfoVerified,
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
      bottomNavigationBar: buildContinueButton(),
    );
  }

  SafeArea buildContinueButton() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          ontap: () async {
            if (!formkey.currentState!.validate()) return;
            await walletController.updatePayment(
              paymentMethod: PaymentMethod.paypal,
              paymentDetails: {"email": _emailController.text},
            );
          },
          isLoading: walletController.isloading,
          child: Text(
            l10n.paypalSaveChanges,
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
        l10n.paypalAccountTitle,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
    );
  }
}
