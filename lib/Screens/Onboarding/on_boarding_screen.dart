import 'dart:io';

import 'package:code_edu/Screens/Onboarding/components/slider_tile.dart';
import 'package:code_edu/Screens/Welcome/welcome_screen.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/data/data_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // ignore: deprecated_member_use
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slides = getSlides();
    requestPermission();
  }

  void requestPermission() async {
    PermissionStatus permissionMicrophone = await Permission.microphone.status;
    PermissionStatus permissionCamera = await Permission.camera.status;

    if (permissionMicrophone != PermissionStatus.granted) {
      await Permission.microphone.request();
    }
    if(permissionCamera != PermissionStatus.granted) {
      await Permission.camera.request();
    }
  }

  // ignore: missing_return
  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
              controller: pageController,
              itemCount: slides.length,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return SliderTile(
                  imageAssetPath: slides[index].getImageAssetPath(),
                  title: slides[index].getTitle(),
                  desc: slides[index].getDesc(),
                );
              }),
        ),
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1.0
                )
              ),
            ),
              height: Platform.isAndroid ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(slides.length - 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).skip,
                    )
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slides.length; i++)
                        currentIndex == i ? pageIndexIndicator(true) : pageIndexIndicator(false),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(currentIndex + 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).next,
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: Platform.isAndroid ? 70 : 60,
              color: isDarkMode ? Color(0xFF4D4D4D) : Colors.blue,
              child: GestureDetector(
                onTap: () => Get.to(WelcomeScreen()),
                child: Text(
                  AppLocalizations.of(context).getStartedNow,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.8
                  ),
                ),
              ),
            ),
    );
  }
}
