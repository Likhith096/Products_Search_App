import 'package:likhith_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:likhith_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:likhith_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';
import 'package:camera/camera.dart';

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




class ScannerPageScreen extends StatefulWidget {
  const ScannerPageScreen({Key? key}) : super(key: key);

  @override
  _ScannerPageScreenState createState() => _ScannerPageScreenState();
}

class _ScannerPageScreenState extends State<ScannerPageScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller!.initialize().then((_) {
      // Ensure that the camera is initialized.
      if (!mounted) {
        return;
      }
      setState(() {}); // Rebuild the UI.
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }


// Inside your _ScannerPageScreenState class

Widget _cameraPreviewWidget() {
  if (_controller == null || !_controller!.value.isInitialized) {
    return const Text(
      'Loading...',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  // Return the CameraPreview widget.
  return AspectRatio(
    aspectRatio: _controller!.value.aspectRatio,
    child: CameraPreview(_controller!), // Camera preview
  );
}

// Modify your onTapSCAN method to show/hide the camera
bool isCameraVisible = false; // Add this line to your class

void onTapSCAN(BuildContext context) {
  setState(() {
    isCameraVisible = !isCameraVisible; // Toggle camera visibility
  });
}

@override
@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: <Widget>[
          // Include this as the base layer if you want it always visible
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 15.h, top: 74.v, right: 15.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h),
                    child: Text(
                      "Hello , Username!",
                      style: CustomTextStyles.titleLargeBold23,
                    ),
                  ),
                ),
                SizedBox(height: 45.v),
                _buildSearchScanner(context),
                SizedBox(height: 38.v),
                if (!isCameraVisible) ...[ // Conditionally show this if the camera is not visible
                  CustomImageView(
                    imagePath: ImageConstant.imgScanner,
                    height: 164.v,
                    width: 159.h,
                  ),
                  SizedBox(height: 38.v),
                ],
                CustomElevatedButton(
                  text: "SCAN",
                  margin: EdgeInsets.only(left: 10.h, right: 3.h),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  buttonTextStyle: CustomTextStyles.titleLargeBold23,
                  onPressed: () {
                    onTapSCAN(context);
                  },
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
          // Camera preview overlay, it will cover the UI when visible
          if (isCameraVisible) ...[
            Positioned.fill(child: _cameraPreviewWidget()),
            // Add a close button or similar to hide the camera preview again
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => setState(() => isCameraVisible = false),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

}

