import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class GoforitpageItemWidget extends StatelessWidget {
  const GoforitpageItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 3.v,
      ),
      decoration: AppDecoration.fillOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 6.v,
              bottom: 4.v,
            ),
            child: Text(
              "Big basket",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 5.v,
              bottom: 5.v,
              right:20.h
            ),
            child: Text(
              "Price",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Container(
            width: 94.h,
            margin: EdgeInsets.only(left: 10.h),
            padding: EdgeInsets.symmetric(
              horizontal: 2.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.fillRedA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Text(
              "  Add to cart",
              style: theme.textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
