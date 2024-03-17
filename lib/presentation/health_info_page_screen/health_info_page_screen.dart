import 'package:likhith_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/healthinfopage_item_widget.dart';
import 'package:likhith_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

class HealthInfoPageScreen extends StatefulWidget {
  const HealthInfoPageScreen({Key? key}) : super(key: key);
  
  _HealthInfoPageScreen createState() => _HealthInfoPageScreen();
}

class _HealthInfoPageScreen extends State<HealthInfoPageScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 23.v),
                child: Column(children: [
                  Text("Add Health Info ", style: theme.textTheme.displaySmall),
                  SizedBox(height: 2.v),
                  Text("Allergies and aversions",
                      style: CustomTextStyles.titleSmallBlack900),
                  SizedBox(height: 18.v),
                  _buildHealthInfoPage(context),
                  SizedBox(height: 77.v),
                  _buildSearchRect(context),
                  SizedBox(height: 67.v),
                  CustomElevatedButton(
                      height: 37.v,
                      width: 73.h,
                      text: "SAVE",
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      buttonTextStyle: theme.textTheme.titleMedium!,
                      onPressed: () {
                        onTapSAVE(context);
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
  Widget _buildHealthInfoPage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 40.v,
                crossAxisCount: 3,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 12,
            itemBuilder: (context, index) {
              return HealthinfopageItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildSearchRect(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 11.h),
        padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 6.v),
        decoration: AppDecoration.fillRedA
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child: Text(
            "ADD                                                       +",
            style: theme.textTheme.titleMedium));
  }

  /// Navigates to the profilePageScreen when the action is triggered.
  onTapLock(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profilePageScreen);
  }

  /// Navigates to the profilePageScreen when the action is triggered.
  onTapSAVE(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profilePageScreen);
  }
}
