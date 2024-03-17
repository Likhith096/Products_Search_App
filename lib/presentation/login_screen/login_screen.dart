import 'package:likhith_s_application2/widgets/custom_text_form_field.dart';
import 'package:likhith_s_application2/widgets/custom_elevated_button.dart';
import 'package:likhith_s_application2/widgets/custom_pin_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity, // Setting width to maximum available width
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 56.v),
        child: SingleChildScrollView(
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSubmit(context),
    ),
  );
}

  /// Section Widget
  Widget _buildEditText(BuildContext context) {
    return CustomTextFormField(controller: editTextController);
  }

  /// Section Widget
  Widget _buildGetOTP(BuildContext context) {
    return CustomElevatedButton(
        height: 38.v,
        width: 103.h,
        text: "Get OTP",
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleLargeBold);
  }

  /// Section Widget
  Widget _buildOtpView(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.h),
        child: CustomPinCodeTextField(context: context, onChanged: (value) {}));
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
          _buildEditText(context),
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
        width: 106.h,
        text: "Submit",
        margin: EdgeInsets.only(left: 126.h, right: 128.h, bottom: 51.v),
        buttonStyle: CustomButtonStyles.fillPrimary,
        onPressed: () {
          onTapSubmit(context);
        });
  }

  /// Navigates to the choicesPageScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.choicesPageScreen);
  }
}
