import 'package:likhith_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ChoicesPageScreen extends StatefulWidget {
  ChoicesPageScreen({Key? key}) : super(key: key);

  @override
  _ChoicesPageScreenState createState() => _ChoicesPageScreenState();
}

class _ChoicesPageScreenState extends State<ChoicesPageScreen> {
  String _dietaryPreference = "";
  String _healthConcern = "";

  List<String> healthConcerns = [
    "High cholesterol",
    "Diabetes",
    "Blood Pressure"
  ];

    List<String> dietaryPref = [
    "Vegetarian (No Egg)",
    "Vegan",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              _buildDietaryPreferences(),
              SizedBox(height: 42),
              _buildHealthConcerns(),
              SizedBox(height: 42),
             ElevatedButton(
              onPressed: () => onTapNext(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
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
              margin: EdgeInsets.symmetric(horizontal: 20.h),)
        ]);
  }

  /// Section Widget
   Widget _buildDietaryPreferences() {
  return Container(
            width: 332.h,
        padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 16.v),
        decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
  child : Column(
      children: dietaryPref.map((concern) {
        return RadioListTile<String>(
          title: Text(concern),
          value: concern,
          groupValue: _dietaryPreference,
          onChanged: (value) {
            setState(() {
             _dietaryPreference = value!;
            });
          },
        );
      }).toList(),
    ));
  }
  /// Section Widget
   Widget _buildHealthConcerns() {
    return Container(
            width: 332.h,
        padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 16.v),
        decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
    child : Column(
      children: healthConcerns.map((concern) {
        return RadioListTile<String>(
          title: Text(concern),
          value: concern,
          groupValue: _healthConcern,
          onChanged: (value) {
            setState(() {
              _healthConcern = value!;
            });
          },
        );
      }).toList(),
    ));
  }

  /// Navigates to the healthInfoPageScreen when the action is triggered.
void onTapNext() {
    // Perform navigation or state management as needed
    print('Dietary Preference: $_dietaryPreference');
    print('Health Concern: $_healthConcern');
    // Navigate to the next screen or save the data
    Navigator.pushNamed(context, AppRoutes.healthInfoPageScreen);
  }
}
