import 'widgets/goforitpage_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';
import 'package:likhith_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_trailing_image.dart';

// ignore_for_file: must_be_immutable
class GoForItPage extends StatefulWidget {
  final String productName;

  const GoForItPage({Key? key, required this.productName}) : super(key: key);

  @override
  GoForItPageState createState() => GoForItPageState();
}


class GoForItPageState extends State<GoForItPage>{
  @override 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 17.v),
              _buildFrameTwentyThree(context),
              SizedBox(height: 17.v),
              _buildTwentySix(context),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildFrameTwentyThree(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.h),
      padding: EdgeInsets.symmetric(
        horizontal: 39.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 238.h,
            padding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 2.v,
            ),
            decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Text(
              "Ingredient alert",
              style: CustomTextStyles.titleMediumOnPrimary.copyWith(color:Colors.green),
            ),
          ),
          SizedBox(height: 10.v),
          Text(
            widget.productName,
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 3.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Text(
                "Brand: xxx",
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(height: 8.v),
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 82.v,
            width: 147.h,
          )
        ],
      ),
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 92.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgIcon,
            margin: EdgeInsets.only(left: 19.h, top: 1.v)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgLock,
              margin: EdgeInsets.symmetric(horizontal: 20.h),)
        ]);
  }

  /// Section Widget
  Widget _buildFrameTwentyFive(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 21.h),
            child: Text(
              "Buy it at a store near you!",
              style: CustomTextStyles.titleMedium16,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: _buildFrameTwelve(
              context,
              storeTwo: "Store 1 ",
            ),
          ),
          SizedBox(height: 16.v),
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: _buildFrameTwelve(
              context,
              storeTwo: "Store 2 ",
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameTwentySix(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7.h),
      padding: EdgeInsets.symmetric(
        horizontal: 3.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Best buying options curated for you!",
            style: CustomTextStyles.titleMedium16,
          ),
          SizedBox(height: 11.v),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 38.v,
              crossAxisCount: 1,
              mainAxisSpacing: 1.h,
              crossAxisSpacing: 1.h,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return GoforitpageItemWidget();
            },
          ),
          SizedBox(height: 8.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTwentySix(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        children: [
          _buildFrameTwentyFive(context),
          SizedBox(height: 17.v),
          _buildFrameTwentySix(context),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFrameTwelve(
    BuildContext context, {
    required String storeTwo,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.v),
            child: Text(
              storeTwo,
              style: CustomTextStyles.bodyLarge18.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
          Spacer(
            flex: 45,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgLinkedin,
            height: 35.v,
            width: 21.h,
          ),
          Spacer(
            flex: 54,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 22.v,
            width: 15.h,
            margin: EdgeInsets.symmetric(vertical: 7.v),
          ),
        ],
      ),
    );
  }
}
