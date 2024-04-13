import 'widgets/nogopage_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

// ignore_for_file: must_be_immutable
class NoGoPage extends StatefulWidget {
  const NoGoPage({Key? key})
      : super(
          key: key,
        );

  @override
  NoGoPageState createState() => NoGoPageState();
}

class NoGoPageState extends State<NoGoPage>
    with AutomaticKeepAliveClientMixin<NoGoPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 17.v),
              _buildThirtyThree(context),
            ],
          ),
        ),
      ),
    );
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
              return NogopageItemWidget();
            },
          ),
          SizedBox(height: 8.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyThree(BuildContext context) {
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
