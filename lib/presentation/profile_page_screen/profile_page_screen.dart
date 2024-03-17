import 'package:likhith_s_application2/widgets/custom_icon_button.dart';
import 'package:likhith_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:likhith_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 28.v),
        child: Column(
          children: [
            CustomImageView(
                imagePath: ImageConstant.imgVector,
                height: 112.v,
                width: 103.h),
            SizedBox(height: 15.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 78.h),
                child: Text("USER NAME",
                    style: CustomTextStyles.titleLargePrimary),
              ),
            ),
            SizedBox(height: 28.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 114.h),
                child: Text("Edit profile", style: theme.textTheme.labelLarge),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(
              width: 201.h,
              child: Divider(),
            ),
            Expanded(
              // Wrap the part of the layout that needs to be scrollable with a SingleChildScrollView
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 35.v),
                    _buildFrame(context, childCounter: "Spouse"),
                    SizedBox(height: 16.v),
                    _buildFrame(context, childCounter: "Child 1"),
                    SizedBox(height: 16.v),
                    _buildFrame(context, childCounter: "Child 2"),
                    SizedBox(height: 16.v),
                    _buildFrame(context, childCounter: "Parent 1"),
                    SizedBox(height: 16.v),
                    _buildFrame(context, childCounter: "Parent 2"),
                    SizedBox(height: 6.v),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSave(context),
    ),
  );
}


  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 78.v,
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgIcon,
            margin: EdgeInsets.only(left: 10.h, right: 277.h)));
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return CustomElevatedButton(
        width: 80.h,
        text: "Save",
        margin: EdgeInsets.only(left: 140.h, right: 140.h, bottom: 31.v),
        buttonStyle: CustomButtonStyles.fillPrimary,
        onPressed: () {
          onTapSave(context);
        });
  }

  /// Common widget
  Widget _buildFrame(
    BuildContext context, {
    required String childCounter,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 4.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomIconButton(
              height: 45.adaptSize,
              width: 45.adaptSize,
              padding: EdgeInsets.all(3.h),
              child: CustomImageView(imagePath: ImageConstant.imgLockBlack900)),
          Padding(
              padding: EdgeInsets.only(left: 28.h, top: 8.v, bottom: 9.v),
              child: Text(childCounter,
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: appTheme.black900))),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 19.v,
              width: 12.h,
              margin: EdgeInsets.symmetric(vertical: 12.v))
        ]));
  }

  /// Navigates to the scannerPageScreen when the action is triggered.
  onTapSave(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.scannerPageScreen);
  }
}
