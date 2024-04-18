import 'package:likhith_s_application2/widgets/custom_text_form_field.dart';
import 'package:likhith_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController editTextController = TextEditingController();
  TextEditingController otpController = TextEditingController(); // Controller for OTP input
  String? _verificationId; // To store Firebase verification ID

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity, 
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 56.v),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgIcon,
                height: 168.v,
                width: 158.h,
              ),
              SizedBox(height: 22.v),
              _buildFormBlock(context), 
              SizedBox(height: 8.v),
              _buildSubmit(context), 
              SizedBox(height: 20.v),
            ],
          ),
        ),
      ),
    ),
  );
}

  /// Section Widget
  Widget _buildGetOTP(BuildContext context) {
    var countryCode = '+91';
    return CustomElevatedButton(     
      onPressed: () async {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + editTextController.text.trim(), 

        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verification Failed. Please try again later.")));
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId; // Store the verification ID
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    },
        height: 38.v,
        width: 103.h,
        text: "Get OTP",
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleLargeBold);
  }

  /// Section Widget
Widget _buildOtpView(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24), // Adjust padding as needed
    child: PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveColor: Colors.grey,
        selectedColor: Colors.blue,
        activeColor: Colors.blue,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: otpController,
      keyboardType: TextInputType.phone,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
      beforeTextPaste: (text) {
        // If you want to allow paste functionality, return true
        return true;
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  );
}


  /// Section Widget
  Widget _buildFormBlock(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 34.v),
        decoration: AppDecoration.fillBlueGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Mobile number", style: theme.textTheme.titleMedium),
          SizedBox(height: 20.v),
          CustomTextFormField(controller: editTextController,textInputType: TextInputType.phone),
          SizedBox(height: 53.v),
          _buildGetOTP(context),
          SizedBox(height: 54.v),
          Text("Enter OTP to login", style: theme.textTheme.titleMedium),
          SizedBox(height: 18.v),
          _buildOtpView(context)
        ]));
  }

  /// Section Widget
  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
        height: 38.v,
        width: 103.h,
        text: "Submit",
        buttonStyle: CustomButtonStyles.fillPrimary,
         onPressed: () async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpController.text.trim(),
      );

    try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  log("User Created");
  String? phoneNumber = userCredential.user?.phoneNumber;

// Check if phoneNumber is not null
if (phoneNumber != null) {
  // Query Firestore to check if the phone number already exists
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('phoneNumber', isEqualTo: phoneNumber)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    // Phone number already exists, do not create a new document
    log("Phone number already exists in Firestore");
  } else {
    await FirebaseFirestore.instance.collection('users').add({
      'phoneNumber': phoneNumber
    });
    log("User phone number added to Firestore");
  }
} else {
  log("Phone number is null");
}
  // Navigate if OTP is correct
  Navigator.pushNamed(context, AppRoutes.choicesPageScreen);
} catch (e) {
  log("Authentication failed: $e");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP. Please try again.")));
}

    },
  );
  }

  /// Navigates to the choicesPageScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.choicesPageScreen);
  }
}