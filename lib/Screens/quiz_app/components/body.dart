import 'dart:async';

import 'package:code_edu/Screens/create_quiz/create_quiz.dart';
import 'package:code_edu/Screens/quiz_app/components/delayed_category_details_list.dart';
import 'package:code_edu/Screens/quiz_app/components/delayed_category_list.dart';
import 'package:code_edu/components/custom_app_bar.dart';
import 'package:code_edu/components/error_internet_msg.dart';
import 'package:code_edu/components/refresh_widget.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatefulWidget {
  final CategoryNotifier category;
  final String urlImage;

  const Body({
    Key key,
    @required this.category,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  StreamSubscription internetconnection;
  bool isoffline = false;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(
                urlImage: widget.urlImage,
                nameScreen: "Quiz",
                iconScreen: Icons.help_outline,
                onTap: (){},
              ),
              Expanded(
                child: RefreshWidget(
                  onRefresh: isInternet,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ErrorMsg(
                            text: AppLocalizations.of(context).errorConnectMsg,
                            show: isoffline,
                          ),
                          DelayedCategoryList(
                            category: widget.category,
                            isoffline: isoffline,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Popular",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          DelayedCategoryDetailsList(
                            category: widget.category,
                            isoffline: isoffline,
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "History",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          DataTable(
                            sortColumnIndex: 0,
                            sortAscending: true,
                            columnSpacing: 35,
                            horizontalMargin: 5,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "Attempt",
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                                numeric: true
                              ),
                              DataColumn(
                                label: Text(
                                  "Course",
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              ),
                              DataColumn(
                                label: Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              ),
                              DataColumn(
                                label: Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              )
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 15
                                        ),
                                      ),
                                    )
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Java",
                                        style: TextStyle(
                                          fontSize: 15
                                        ),
                                      ),
                                    )
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "09/08/2021",
                                        style: TextStyle(
                                          fontSize: 15
                                        ),
                                      ),
                                    )
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Finished",
                                        style: TextStyle(
                                          fontSize: 15
                                        ),
                                      ),
                                    )
                                  ),
                                ]
                              )
                            ]
                          ),
                          SizedBox(height: 75),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 110,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateQuiz()));
                  });
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}