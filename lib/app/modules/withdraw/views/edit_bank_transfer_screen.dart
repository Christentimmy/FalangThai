import 'package:falangthai/app/controller/wallet_controller.dart';
import 'package:falangthai/app/modules/withdraw/widgets/input_field_widget.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBankTransferScreen extends StatefulWidget {
  const EditBankTransferScreen({super.key});

  @override
  State<EditBankTransferScreen> createState() => _EditBankTransferScreenState();
}

class _EditBankTransferScreenState extends State<EditBankTransferScreen> {
  final _holderController = TextEditingController();
  final _accountController = TextEditingController();
  final _bankController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          l10n.withdrawBankTransfer,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                controller: _holderController,
                label: l10n.bankTransferAccountHolderLabel,
                hint: l10n.bankTransferAccountHolderHint,
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _accountController,
                label: l10n.bankTransferAccountNumberLabel,
                hint: l10n.bankTransferAccountNumberHint,
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _bankController,
                label: l10n.bankTransferBankNameLabel,
                hint: l10n.bankTransferBankNameHint,
                icon: Icons.account_balance,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: continueButton(),
    );
  }

  SafeArea continueButton() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          ontap: () async {
            if (!formKey.currentState!.validate()) return;
            final paymentDetails = {
              'accountHolderName': _holderController.text,
              'accountNumber': _accountController.text,
              'bankName': _bankController.text,
            };
            await walletController.updatePayment(
              paymentMethod: PaymentMethod.bankTransfer,
              paymentDetails: paymentDetails,
            );
          },
          isLoading: walletController.isloading,
          child: Text(
            l10n.bankTransferSaveChanges,
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
}
