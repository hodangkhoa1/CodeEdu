import 'package:code_edu/Screens/play_video_courses/play_video_courses.dart';
import 'package:code_edu/Screens/read_pdf/read_pdf_screen.dart';
import 'package:code_edu/components/custom_page_route.dart';
import 'package:code_edu/components/show_dialog_error.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

void showDialogChooseOptions(BuildContext context, String urlVideo, String urlPDF, String urlAvatar, String title, bool isDarkMode) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF181818) : Colors.white,
            border: Border.all(
              color: isDarkMode ? Colors.grey : Colors.black,
              width: 1
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                  height: 50,
                  onPressed: (){
                    Navigator.of(context).pop();
                    if(urlPDF.isEmpty) {
                      showDialogError(
                        context,
                        AppLocalizations.of(context).errorSupportTitle,
                        AppLocalizations.of(context).errorNoFilePDFMsg,
                        "Okay",
                        isDarkMode,
                        "assets/images/8750-alert.json",
                        18,
                        () {
                          Navigator.of(context).pop();
                        }
                      );
                    } else {
                      Get.to(ReadPDFScreen(urlPDF: urlPDF));
                      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReadPDFScreen(
                      //   urlPDF: urlPDF,
                      // )));
                    }
                  },
                  color: isDarkMode ? Color(0xFF313131) : Color(0xFFD0D0D0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.filePdf,
                        size: 25,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Slide PDF",
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  )
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  height: 50,
                  onPressed: (){
                    Navigator.of(context).pop();
                    if(urlVideo.isEmpty) {
                      showDialogError(
                        context,
                        AppLocalizations.of(context).errorSupportTitle,
                        AppLocalizations.of(context).errorNoVideoMsg,
                        "Okay",
                        isDarkMode,
                        "assets/images/8750-alert.json",
                        18,
                        () {
                          Navigator.of(context).pop();
                        }
                      );
                    } else {
                      Get.to(PlayVideoCourses(
                        url: urlVideo,
                        nameLesson: title,
                        urlAvatar: urlAvatar,
                      ));
                      // Navigator.of(context).push(
                      //   CustomPageRoute(
                      //     direction: AxisDirection.up,
                      //     child: PlayVideoCourses(
                      //       url: urlVideo,
                      //       urlAvatar: urlAvatar,
                      //       nameLesson: title,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  color: isDarkMode ? Color(0xFF313131) : Color(0xFFD0D0D0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.youtube,
                        size: 25,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context).playVideoLesson,
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}