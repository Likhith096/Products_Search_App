import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> selectedHealthConcerns = [];
  String? _dietaryPreference;

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
    decoration: AppDecoration.outlineBlack.copyWith(
      borderRadius: BorderRadiusStyle.roundedBorder15,
    ),
    child: Column(
      children: dietaryPref.map((preference) {
        return RadioListTile<String>(
          title: Text(preference),
          value: preference,
          groupValue: _dietaryPreference,
          onChanged: (value) {
            setState(() {
              _dietaryPreference = value!;
            });
          },
        );
      }).toList(),
    ),
  );
}

  /// Section Widget
   Widget _buildHealthConcerns() {
    return Container(
      width: 332.h,
      padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 16.v),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        children: healthConcerns.map((concern) {
          bool isChecked = selectedHealthConcerns.contains(concern);
          return CheckboxListTile(
            title: Text(concern),
            value: isChecked,
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  if (newValue) {
                    selectedHealthConcerns.add(concern);
                  } else {
                    selectedHealthConcerns.remove(concern);
                  }
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
  /// Navigates to the healthInfoPageScreen when the action is triggered.
void onTapNext() {
  if (_dietaryPreference != null && selectedHealthConcerns.isNotEmpty) {
    print('Selected Dietary Preferences: $_dietaryPreference');
    print('Selected Health Concerns: $selectedHealthConcerns');
     Map<String, dynamic> data = {
      'DietaryPreference': _dietaryPreference,
      'HealthConcerns': selectedHealthConcerns,
    };

    // Add data to Firestore
    FirebaseFirestore.instance.collection('HealthInfo').add(data)
      .then((value) {
        print('Data saved to Firestore with document ID: ${value.id}');
        Navigator.pushNamed(context, AppRoutes.healthInfoPageScreen);
      })
      .catchError((error) {
        // Handle errors
        print('Failed to save data: $error');
        });
      } 
      else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selection Required'),
          content: Text('Please select at least one dietary preference and one health concern.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

}
