import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:code_edu/AllWidgets/error_internet_msg.dart';
import 'package:code_edu/AllWidgets/refresh_widget.dart';
import 'package:code_edu/Screens/home/components/app_bar.dart';
import 'package:code_edu/Screens/home/components/delayed_category_list.dart';
import 'package:code_edu/Screens/home/components/delayed_swiper_image.dart';
import 'package:code_edu/Screens/home/components/search_mic.dart';
import 'package:code_edu/Screens/home/components/utils.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:code_edu/requestAPI/category_api.dart';
import 'package:code_edu/requestAPI/speech_api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Body extends StatefulWidget {
  final String showBottomBar;
  final String urlAvatar;
  final String nameTextAppBar;

  const Body({
    Key key,
    @required this.showBottomBar,
    @required this.urlAvatar,
    @required this.nameTextAppBar,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin{
  String text = 'Press the button and start speaking';
  bool isListening = false;
  bool showMicSearch = false;
  bool _folded = true;
  AnimationController _animationController;
  TextEditingController _textEditingController = TextEditingController();
  int _current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  StreamSubscription internetconnection;
  bool isoffline = false;

  @override
  void initState() {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    getCategory(categoryNotifier);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 375,
      )
    );
    super.initState();
    isInternet();
  }

  Future<bool> isInternet() async {
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
            isoffline = true;
        }); 
      }else if(result == ConnectivityResult.mobile){
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        setState(() {
            isoffline = false;
        });
      }
    });
    return isoffline;
  }

  @override
  void dispose() {
    internetconnection.cancel();
    super.dispose();
  }

  String getTimeNow() {
    var timeNow = DateTime.now().hour;

    if ((timeNow >= 5) && (timeNow < 12)) {
      return AppLocalizations.of(context).goodMorning;
    } else if ((timeNow >= 12) && (timeNow < 17)) {
      return AppLocalizations.of(context).goodAfternoon;
    } else if (timeNow >= 17 && timeNow < 5) {
      return AppLocalizations.of(context).goodEvening;
    } else {
      return AppLocalizations.of(context).goodEvening;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context);
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              AppBarHomeCustom(
                urlAvatar: widget.urlAvatar,
                folded: _folded,
                nameTextAppBar: widget.nameTextAppBar,
                isDarkMode: isDarkMode,
                animationController: _animationController,
                angle: _animationController.value * 2.0 * pi,
                onTap: (){
                  setState(() {
                    showMicSearch = true;
                  });
                },
                textEditingController: _textEditingController,
                onTapTextField: (){},
                onPressed: (){
                  if(_folded == true) {
                    setState(() {
                      _folded = false;
                      _animationController.forward();
                    });
                  } else {
                    setState(() {
                      _folded = true;
                      _animationController.reverse();
                      _textEditingController.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  }
                },
              ),
              Expanded(
                child: RefreshWidget(
                  onRefresh: isInternet,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ErrorMsg(
                            text: AppLocalizations.of(context).errorConnectMsg,
                            show: isoffline,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              getTimeNow(),
                              style: TextStyle(
                                fontSize: 28,
                                color: isDarkMode ? Colors.blue : Color(0xFF0D1333),
                                fontWeight: FontWeight.w600,
                              )
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context).findACourse,
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode ? Colors.grey : Color(0xFF61688B),
                              height: 2,
                            ),
                          ),
                          SizedBox(height: 15),
                          DelayedSwiperImage(
                            current: _current,
                            categoryNotifier: categoryNotifier,
                            map: map,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 25,
                              color: isDarkMode ? Colors.blue : Color(0xFF0D1333),
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          SizedBox(height: 35),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 90
                            ),
                            child: DelayedCategoryList(
                              categoryNotifier: categoryNotifier,
                              isoffline: isoffline,
                              showBottomBar: widget.showBottomBar,
                              urlAvatar: widget.urlAvatar,
                              isDarkMode: isDarkMode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ),
            ],
          ),
          showMicSearch == true ? SlidingUpPanel(
            maxHeight: 761,
            minHeight: 761,
            panelBuilder: (scrollController) => AddMicDialog(
              flatButtonSearch: (){
                setState(() {
                  _textEditingController.text = text;
                  showMicSearch = false;
                });
              },
              text: text,
              closeOnPressed: (){
                setState(() {
                  showMicSearch = false;
                });
              },
              isListening: isListening,
              micOnPressed: toggleRecording,
            )
          ) : Container(
            height: 0,
            width: 0,
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
          ),
        ],
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
    onResult: (text) => setState(() => this.text = text),
    onListening: (isListening) {
      setState(() => this.isListening = isListening);

      if(!isListening) {
        Future.delayed(Duration(seconds: 1), () {
          Utils.scanText(text);
        });
      }
    }
  );

  // showOverlay(BuildContext context) async {
  //   OverlayState overlayState = Overlay.of(context);
  //   OverlayEntry overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: 90,
  //       child: Card(
  //         elevation: 1,
  //         color: Colors.grey,
  //         child: Container(
  //           width: MediaQuery.of(context).size.width - 20,
  //           height: 200,
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   Icon(
  //                     FontAwesomeIcons.history
  //                   ),
  //                   Text(
  //                     "Iot",
  //                   ),
  //                   GestureDetector(
  //                     onTap: (){
  //                       setState(() {
  //                         _showOverlay = false;
  //                       });
  //                     },
  //                     child: Icon(
  //                       Icons.close
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       )
  //     )
  //   );
  //   overlayState.insert(overlayEntry);
  //   await Future.delayed(Duration(seconds: 5));
  //   overlayEntry.remove();
  //}
}