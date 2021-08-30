import 'package:flutter/material.dart';

class Body extends StatefulWidget {

  Body({
    Key key
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 124,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Color(0xFF313131),
            ),
            child: Material(
              type: MaterialType.transparency,
              shadowColor: Colors.grey[50],
              child: InkWell(
                onTap: (){},
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Download the latest update",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Last checked on: August 15, 2021",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFD0D0D0),
                        ),
                      ),
                      Text(
                        "Downloading via mobile networks may result in additional charges. If possible, download via a Wifi-Fi network instead.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFD0D0D0),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 89,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Color(0xFF313131),
            ),
            child: Material(
              type: MaterialType.transparency,
              shadowColor: Colors.grey[50],
              child: InkWell(
                onTap: (){
                  if(isSwitched == false) {
                    setState(() {
                      isSwitched = true;
                    });
                  } else {
                    setState(() {
                      isSwitched = false;
                    });
                  }
                },
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5
                        )
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Auto download over Wi-Fi",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "Download software updates automatically when connected to a Wi-Fi network."
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Switch(
                              value: isSwitched,
                              onChanged: (bool value) {
                                if(isSwitched == false) {
                                  setState(() {
                                    isSwitched = true;
                                  });
                                } else {
                                  setState(() {
                                    isSwitched = false;
                                  });
                                }
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.blue,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}