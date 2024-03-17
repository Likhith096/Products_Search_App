import 'package:likhith_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:likhith_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

class ScannerPageScreen extends StatelessWidget {
  const ScannerPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 15.h, top: 74.v, right: 15.h),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: Text("Hello , Username!",
                              style: CustomTextStyles.titleLargeBold23))),
                  SizedBox(height: 45.v),
                  _buildSearchScanner(context),
                  SizedBox(height: 38.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgScanner,
                      height: 164.v,
                      width: 159.h),
                  SizedBox(height: 38.v),
                  CustomElevatedButton(
                      text: "SCAN",
                      margin: EdgeInsets.only(left: 10.h, right: 3.h),
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      buttonTextStyle: CustomTextStyles.titleLargeBold23,
                      onPressed: () {
                        onTapSCAN(context);
                      }),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 92.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgIcon,
            margin: EdgeInsets.only(left: 19.h, top: 1.v)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgLock,
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              onTap: () {
                onTapLock(context);
              })
        ]);
  }

  /// Section Widget
  Widget _buildSearchScanner(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 7.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(top: 6.v, bottom: 7.v),
              child:
                  Text("Search Product ", style: theme.textTheme.titleMedium)),
          CustomImageView(
              imagePath: ImageConstant.imgTelevision, height: 37.v, width: 35.h)
        ]));
  }

  /// Navigates to the profilePageScreen when the action is triggered.
  onTapLock(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profilePageScreen);
  }

  /// Navigates to the goForItPageTabContainerScreen when the action is triggered.
  onTapSCAN(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.goForItPageTabContainerScreen);
  }
}
