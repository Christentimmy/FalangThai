import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/modules/auth/controller/timer_controller.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String email;
  VoidCallback? onVerifiedCallBack;
  bool? showEditDetails;
  OtpScreen({
    super.key,
    required this.email,
    this.showEditDetails = true,
    this.onVerifiedCallBack,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _timerController.startTimer();
  }

  Future<void> changeAuthDetails(String? email) async {
    if (email != null) {
      ContactUpdateBottomSheet.show(
        context: context,
        type: ContactType.email,
        initialValue: email,
        onSave: (newEmail) async {
          await _authController.changeAuthDetails(email: newEmail);
          setState(() {
            widget.email = newEmail;
          });
        },
      );
    }
  }

  final _timerController = Get.put(TimerController());
  final _authController = Get.find<AuthController>();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: AuthWidgets().buildBackgroundDecoration(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.18),
                  Text(
                    AppLocalizations.of(context)!.verificationTitle,
                    style: GoogleFonts.fredoka(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.07),
              richTextWidget(),
              const SizedBox(height: 15),
              Text(
                "${AppLocalizations.of(context)!.otpSentTo}\n${widget.email}",
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  height: 1.1,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              widget.showEditDetails == true
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.wrongDetails,
                          style: GoogleFonts.fredoka(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await changeAuthDetails(widget.email);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.change,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(height: Get.height * 0.0375),
              Center(
                child: Pinput(
                  controller: _otpController,
                  closeKeyboardWhenCompleted: true,
                  defaultPinTheme: PinTheme(
                    width: 65,
                    height: 65,
                    textStyle: GoogleFonts.fredoka(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 65,
                    height: 65,
                    textStyle: GoogleFonts.fredoka(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.0375),
              CustomButton(
                isLoading: _authController.isOtpVerifyLoading,
                child: Text(
                  AppLocalizations.of(context)!.continueText,
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                ontap: () async {
                  await _authController.verifyOtp(
                    otpCode: _otpController.text,
                    email: widget.email,
                    whatNext: widget.onVerifiedCallBack,
                  );
                },
              ),
              SizedBox(height: Get.height * 0.028),
              resendOtpRow(),
            ],
          ),
        ),
      ),
    );
  }

  Row resendOtpRow() {
    final text = AppLocalizations.of(Get.context!)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text.didntReceiveCode,
          style: GoogleFonts.fredoka(fontSize: 16, color: Colors.white),
        ),
        Obx(
          () => InkWell(
            onTap: () async {
              _timerController.startTimer();
              await _authController.sendOtp(email: widget.email);
              _otpController.clear();
            },
            child: _timerController.secondsRemaining.value == 0
                ? Text(
                    text.resend,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "(${_timerController.secondsRemaining.value.toString()})",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  RichText richTextWidget() {
    final text = AppLocalizations.of(Get.context!)!;
    return RichText(
      text: TextSpan(
        style: GoogleFonts.roboto(fontSize: 24),
        children: [
          TextSpan(
            text: text.otpHeadingPrefix,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: text.otpHeadingOtp,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
