import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:falangthai/app/resources/colors.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.primaryColor,
        title: Text(
          "Terms and Condition",
          style: GoogleFonts.fredoka(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          """ 
# Terms and Conditions for FalangThai

**Effective Date:** [Insert Date]  
**Last Updated:** [Insert Date]

## 1. Acceptance of Terms

Welcome to FalangThai ("we," "our," "us," or the "App"). These Terms and Conditions ("Terms") constitute a legally binding agreement between you and FalangThai governing your access to and use of our dating application and services.

By creating an account, accessing, or using FalangThai, you agree to be bound by these Terms and our Privacy Policy. If you do not agree to these Terms, you may not use the App.

**Contact Information:**  
FalangThai  
Michigan, USA  
Email: example@gmail.com

## 2. Eligibility

To use FalangThai, you must:
- Be at least 18 years of age
- Be legally capable of entering into binding contracts
- Not be prohibited from using the service under the laws of the United States, Thailand, or any other applicable jurisdiction
- Not have been previously banned or removed from FalangThai

By using the App, you represent and warrant that you meet all eligibility requirements. We reserve the right to verify your age and may request identification.

## 3. Account Registration and Security

### 3.1 Account Creation
- You may register using your email address or through Google Sign-In
- You must provide accurate, current, and complete information
- You are responsible for maintaining the confidentiality of your account credentials
- You must notify us immediately of any unauthorized access or security breach

### 3.2 Account Responsibility
- You are solely responsible for all activity on your account
- You may not share, sell, or transfer your account to another person
- You may only maintain one active account at a time
- We reserve the right to suspend or terminate accounts that violate these Terms

## 4. User Conduct and Prohibited Activities

### 4.1 Acceptable Use
You agree to use FalangThai in a respectful, lawful manner. You will not:

**Illegal Activities:**
- Use the App for any illegal purpose or violation of local, state, national, or international laws
- Solicit money or engage in financial scams
- Promote or facilitate prostitution, human trafficking, or sexual exploitation
- Engage in any form of harassment, stalking, or threatening behavior

**Harmful Content:**
- Post content that is hateful, discriminatory, or promotes violence
- Share sexually explicit content without consent
- Impersonate any person or entity
- Post false, misleading, or fraudulent information

**Platform Integrity:**
- Create fake or duplicate accounts
- Use automated systems, bots, or scripts to access the App
- Attempt to hack, disrupt, or compromise the security of the App
- Scrape, collect, or harvest user data
- Reverse engineer or attempt to extract source code

**Commercial Misuse:**
- Use the App for commercial solicitation or advertising without permission
- Promote third-party services, websites, or applications
- Recruit users for other platforms or services

### 4.2 Content Standards
All content you post must:
- Comply with applicable laws and regulations
- Be your own original content or content you have permission to use
- Not infringe on any third-party intellectual property rights
- Be appropriate and not contain nudity, violence, or offensive material
- Be truthful and accurately represent yourself

## 5. User Content and Intellectual Property

### 5.1 Your Content
- You retain ownership of content you post (photos, messages, profile information)
- By posting content, you grant FalangThai a worldwide, non-exclusive, royalty-free license to use, display, reproduce, and distribute your content for the purpose of operating and promoting the service
- You represent that you have all necessary rights to grant this license
- You are solely responsible for your content

### 5.2 Our Intellectual Property
- FalangThai and all related trademarks, logos, and service marks are owned by us
- The App's design, functionality, and code are protected by copyright and other intellectual property laws
- You may not copy, modify, distribute, or create derivative works without our written permission

### 5.3 Content Removal
- We reserve the right to remove any content that violates these Terms or is otherwise objectionable
- We are not obligated to monitor user content but may do so at our discretion

## 6. Subscriptions and Payments

### 6.1 Subscription Plans
- FalangThai offers premium subscription features
- Subscription details, pricing, and features are described within the App
- All payments are processed through Stripe, our third-party payment processor

### 6.2 Billing and Charges
- Subscriptions automatically renew unless canceled before the renewal date
- You authorize us to charge your payment method for recurring subscription fees
- Prices are subject to change with advance notice
- All fees are non-refundable except as required by law

### 6.3 Cancellation
- You may cancel your subscription at any time through the App settings
- Cancellation takes effect at the end of the current billing period
- No refunds will be provided for partial subscription periods
- Free trial periods, if offered, may be canceled before billing begins

### 6.4 Refund Policy
- All sales are final
- Refunds may be provided at our sole discretion in exceptional circumstances
- To request a refund, contact us at example@gmail.com with your order details

## 7. Location-Based Services

- FalangThai uses location data to provide location-based matching
- You can control location permissions through your device settings
- Disabling location services may limit app functionality
- Your approximate location may be visible to other users
- See our Privacy Policy for more information on location data

## 8. Safety and Interactions

### 8.1 Meeting Other Users
- Exercise caution when meeting people from the App in person
- Meet in public places and inform friends or family of your plans
- We are not responsible for interactions between users, whether online or offline
- Trust your instincts and report suspicious behavior

### 8.2 User Verification
- We do not conduct criminal background checks on users
- We do not verify the accuracy of user-provided information
- Users are responsible for their own safety and due diligence

### 8.3 Reporting and Blocking
- You can report users who violate these Terms or engage in inappropriate behavior
- You can block users to prevent them from contacting you
- We investigate reports but are not obligated to take action

## 9. Disclaimers and Limitations of Liability

### 9.1 Service "As Is"
- FalangThai is provided on an "as is" and "as available" basis
- We make no warranties, express or implied, regarding the App's operation, availability, or accuracy
- We do not guarantee you will find a match or achieve any specific results

### 9.2 No Relationship Guarantee
- We do not guarantee the behavior, identity, or intentions of users
- We are not responsible for user conduct or content
- Interactions with other users are at your own risk

### 9.3 Limitation of Liability
TO THE FULLEST EXTENT PERMITTED BY LAW:
- We are not liable for any indirect, incidental, consequential, or punitive damages
- Our total liability shall not exceed the amount you paid to us in the 12 months preceding the claim, or \$100, whichever is greater
- We are not liable for losses resulting from user conduct, content, or interactions
- We are not responsible for service interruptions, data loss, or technical issues

### 9.4 Third-Party Services
- We are not responsible for third-party services (Google Sign-In, Stripe)
- Your use of third-party services is governed by their terms and policies

## 10. Indemnification

You agree to indemnify, defend, and hold harmless FalangThai, its officers, directors, employees, and agents from any claims, damages, losses, liabilities, and expenses (including legal fees) arising from:
- Your use of the App
- Your violation of these Terms
- Your violation of any third-party rights
- Content you post on the App
- Your interactions with other users

## 11. Termination

### 11.1 Termination by You
- You may delete your account at any time through the App settings
- Subscription fees are non-refundable upon termination

### 11.2 Termination by Us
We may suspend or terminate your account immediately without notice if:
- You violate these Terms or our policies
- You engage in fraudulent or illegal activities
- Your account is inactive for an extended period
- We discontinue the service

### 11.3 Effect of Termination
- Upon termination, your right to use the App ceases immediately
- We may delete your account and content
- Provisions that should survive termination (indemnification, disclaimers, limitations of liability) will remain in effect

## 12. Dispute Resolution and Governing Law

### 12.1 Governing Law
These Terms are governed by the laws of the State of Michigan and the United States, without regard to conflict of law principles.

### 12.2 Arbitration Agreement
Any dispute arising from these Terms or your use of FalangThai shall be resolved through binding arbitration, except:
- Small claims court matters
- Injunctive or equitable relief for intellectual property infringement

By using FalangThai, you waive your right to a jury trial and class action lawsuits.

### 12.3 Informal Resolution
Before initiating arbitration, you agree to contact us at example@gmail.com to attempt to resolve the dispute informally for at least 30 days.

### 12.4 Jurisdiction
For matters not subject to arbitration, you consent to the exclusive jurisdiction of courts located in Michigan, USA.

## 13. General Provisions

### 13.1 Entire Agreement
These Terms, together with our Privacy Policy, constitute the entire agreement between you and FalangThai.

### 13.2 Amendments
We may modify these Terms at any time by:
- Posting the updated Terms in the App
- Updating the "Last Updated" date
- Notifying you of material changes

Your continued use after changes constitutes acceptance of the modified Terms.

### 13.3 Severability
If any provision of these Terms is found unenforceable, the remaining provisions shall remain in effect.

### 13.4 Waiver
Our failure to enforce any provision does not constitute a waiver of that provision.

### 13.5 Assignment
You may not assign or transfer these Terms. We may assign our rights and obligations without restriction.

### 13.6 Force Majeure
We are not liable for delays or failures caused by circumstances beyond our reasonable control.

## 14. Contact Us

If you have questions about these Terms, please contact us:

**Email:** example@gmail.com  
**Company:** FalangThai  
**Location:** Michigan, USA

---

**By using FalangThai, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.**

**Note:** These Terms should be reviewed by a qualified attorney to ensure compliance with applicable laws and to address your specific business needs.
        """,
          style: GoogleFonts.fredoka(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
