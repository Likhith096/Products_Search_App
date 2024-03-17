import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class HealthinfopageItemWidget extends StatelessWidget {
  const HealthinfopageItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.v),
            child: Text(
              "Gluten",
              style: theme.textTheme.labelMedium,
            ),
          ),
          Container(
            width: 42.h,
            margin: EdgeInsets.only(left: 10.h),
            padding: EdgeInsets.symmetric(
              horizontal: 5.h,
              vertical: 2.v,
            ),
            decoration: AppDecoration.fillGreenA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Text(
              "Add  +",
              style: CustomTextStyles.labelMediumOnPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
