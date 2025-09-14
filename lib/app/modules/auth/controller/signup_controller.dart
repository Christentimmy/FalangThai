import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupController extends GetxController with GetTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;
  late AnimationController logoAnimationController;
  
  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;
  
  // Form Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Observable States
  final RxString nameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool acceptTerms = false.obs;
  final RxBool isLoading = false.obs;
  
  // Form Validation
  final RxBool isNameValid = false.obs;
  final RxBool isEmailValid = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool isConfirmPasswordValid = false.obs;
  
  bool get isFormValid => 
      isNameValid.value && 
      isEmailValid.value && 
      isPasswordValid.value && 
      isConfirmPasswordValid.value;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _setupFormListeners();
  }

  void _initializeAnimations() {
    // Background animations
    backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    
    floatAnimation1 = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: Curves.easeInOut,
    ));
    
    floatAnimation2 = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
    ));
    
    rotationAnimation = Tween<double>(
      begin: 0,
      end: 6.28318530718, // 2π
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: Curves.linear,
    ));
    
    backgroundAnimationController.repeat();
    
    // Logo animation
    logoAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: logoAnimationController,
      curve: Curves.easeInOut,
    ));
    
    logoAnimationController.repeat(reverse: true);
  }

  void _setupFormListeners() {
    // Real-time validation
    nameController.addListener(() => validateName(nameController.text));
    emailController.addListener(() => validateEmail(emailController.text));
    passwordController.addListener(() => validatePassword(passwordController.text));
    confirmPasswordController.addListener(() => validateConfirmPassword(confirmPasswordController.text));
  }

  // Validation Methods
  void validateName(String value) {
    if (value.isEmpty) {
      nameError.value = 'Name is required';
      isNameValid.value = false;
    } else if (value.length < 2) {
      nameError.value = 'Name must be at least 2 characters';
      isNameValid.value = false;
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      nameError.value = 'Name can only contain letters and spaces';
      isNameValid.value = false;
    } else {
      nameError.value = '';
      isNameValid.value = true;
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Email is required';
      isEmailValid.value = false;
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Please enter a valid email address';
      isEmailValid.value = false;
    } else {
      emailError.value = '';
      isEmailValid.value = true;
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Password is required';
      isPasswordValid.value = false;
    } else if (value.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      isPasswordValid.value = false;
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      passwordError.value = 'Password must contain at least one uppercase letter';
      isPasswordValid.value = false;
    } else if (!value.contains(RegExp(r'[a-z]'))) {
      passwordError.value = 'Password must contain at least one lowercase letter';
      isPasswordValid.value = false;
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      passwordError.value = 'Password must contain at least one number';
      isPasswordValid.value = false;
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      passwordError.value = 'Password must contain at least one special character';
      isPasswordValid.value = false;
    } else {
      passwordError.value = '';
      isPasswordValid.value = true;
      // Re-validate confirm password if it exists
      if (confirmPasswordController.text.isNotEmpty) {
        validateConfirmPassword(confirmPasswordController.text);
      }
    }
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      isConfirmPasswordValid.value = false;
    } else if (value != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isConfirmPasswordValid.value = false;
    } else {
      confirmPasswordError.value = '';
      isConfirmPasswordValid.value = true;
    }
  }

  // Toggle Methods
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleTermsAcceptance() {
    acceptTerms.value = !acceptTerms.value;
  }

  // Authentication Methods
  Future<void> signup() async {
    if (!isFormValid || !acceptTerms.value) {
      Get.snackbar(
        'Error',
        'Please fill all fields correctly and accept the terms',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Here you would typically make an API call to register the user
      final userData = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };
      
      // Simulate success response
      final success = await _registerUser(userData);
      
      if (success) {
        Get.snackbar(
          'Success!',
          'Account created successfully! Welcome aboard!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        
        // Navigate to verification screen or main app
        // Get.offNamed('/verification');
        // Or for demo purposes:
        Get.offNamed('/welcome');
        
      } else {
        throw Exception('Registration failed');
      }
      
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString().contains('email') 
            ? 'This email is already registered'
            : 'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _registerUser(Map<String, String> userData) async {
    // This is where you'd make your actual API call
    // For demo purposes, we'll simulate different scenarios
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Simulate email already exists scenario (5% chance)
    if (DateTime.now().millisecond % 20 == 0) {
      throw Exception('email already exists');
    }
    
    // Simulate network error scenario (3% chance)
    if (DateTime.now().millisecond % 33 == 0) {
      throw Exception('network error');
    }
    
    // Simulate success (92% chance)
    return true;
  }

  Future<void> signupWithGoogle() async {
    try {
      isLoading.value = true;
      
      // Simulate Google Sign-In
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would integrate with Google Sign-In
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // if (googleUser != null) {
      //   // Process Google user data
      // }
      
      Get.snackbar(
        'Google Sign-Up',
        'Google sign-up integration coming soon!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.9),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign-up failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signupWithFacebook() async {
    try {
      isLoading.value = true;
      
      // Simulate Facebook Sign-In
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would integrate with Facebook Login
      // final LoginResult result = await FacebookAuth.instance.login();
      // if (result.status == LoginStatus.success) {
      //   // Process Facebook user data
      // }
      
      Get.snackbar(
        'Facebook Sign-Up',
        'Facebook sign-up integration coming soon!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigo.withOpacity(0.9),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Facebook sign-up failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Utility Methods
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    
    isNameValid.value = false;
    isEmailValid.value = false;
    isPasswordValid.value = false;
    isConfirmPasswordValid.value = false;
    
    acceptTerms.value = false;
  }

  void focusNextField(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(Get.context!).requestFocus(nextFocus);
  }

  // Password Strength Indicator
  int getPasswordStrength(String password) {
    int strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;
    
    return strength;
  }

  String getPasswordStrengthText(String password) {
    int strength = getPasswordStrength(password);
    switch (strength) {
      case 0:
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Fair';
      case 4:
        return 'Good';
      case 5:
        return 'Strong';
      default:
        return 'Very Weak';
    }
  }

  Color getPasswordStrengthColor(String password) {
    int strength = getPasswordStrength(password);
    switch (strength) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    
    // Dispose animation controllers
    backgroundAnimationController.dispose();
    logoAnimationController.dispose();
    
    super.onClose();
  }
}