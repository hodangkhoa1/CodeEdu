import 'package:code_edu/Screens/play_video_courses/components/build_sliding_panel.dart';
import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/data/drop_down_menu.dart';
import 'package:code_edu/model/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Body extends StatefulWidget {
  final url;
  final String urlAvatar;
  final String nameLesson;

  const Body({
    Key key,
    @required this.url,
    this.urlAvatar,
    this.nameLesson,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  YoutubePlayerController _controller;
  bool fullScreen = false;
  bool showInfoFromBottom = false;
  bool _comment = false;
  bool _disable = true;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        isLive: false,
      )
    );
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    return SafeArea(
      child: SizedBox(
        child: Stack(
          children: [
            Column(
              children: [
                _controller.initialVideoId.isNotEmpty ? YoutubePlayerBuilder(
                  onEnterFullScreen: () {
                    setState(() {
                      this.fullScreen = true;
                    });
                  },
                  onExitFullScreen: (){
                    setState(() {
                      this.fullScreen = false;
                    });
                  },
                  player: YoutubePlayer(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                    showVideoProgressIndicator: true,
                    onReady: (){},
                    progressColors: ProgressBarColors(
                      playedColor: Colors.red,
                      handleColor: Colors.redAccent,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  builder: (context, player) {
                    return Stack(
                      children: [
                        player,
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.angleDown,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                ) : Container(
                  width: size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/robot.jpg"),
                      fit: BoxFit.cover
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 15,
                        child: Icon(
                          FontAwesomeIcons.angleDown
                        )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 20
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size.width - 80,
                                      child: Text(
                                        widget.nameLesson,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: isDarkMode ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            showInfoFromBottom = true;
                                          });
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.angleDown,
                                          color: isDarkMode ? Color(0xFF909090) : Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/hoang-giao-lang.jpg"),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: size.width - 180,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "giáo.làng",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isDarkMode ? Colors.grey[200] : Colors.black,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "PRO",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isDarkMode ? Color(0xFF909090) : Colors.black,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      bool isPlaying = true;
                                      Navigator.pop(context, isPlaying);
                                    });
                                  },
                                  child: Text(
                                    "UnEnroll",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey[400],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(widget.urlAvatar),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Bạn có thắc mắc gì trong bài học này?"
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(widget.urlAvatar),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 18
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: isDarkMode ? Color(0xFF121212) : Colors.grey[300],
                                            border: Border.all(
                                              color: isDarkMode ? Colors.white : Colors.transparent
                                            )
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Hồ Đăng Khoa",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "6 tháng trước",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[400]
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "Rất trân trọng những gì anh đang làm, hi vọng anh luôn giữ được nhiệt huyết để cho ra những video hay như em đang xem ạ. Chúc F8 ngày càng thành công ạ",
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 80,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: (){},
                                      child: Text(
                                        "Like",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue
                                        ),
                                      )
                                    ),
                                    SizedBox(width: 52),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          _comment = true;
                                        });
                                      },
                                      child: Text(
                                        "Comment",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue
                                        ),
                                      )
                                    ),
                                    SizedBox(width: 68),
                                    PopupMenuButton<MenuItem>(
                                      iconSize: 30,
                                      onSelected: (item) => onSelected(context, item),
                                      itemBuilder: (context) => [
                                        ...MenuItems.itemsFirst.map(buildItem).toList(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              _comment == true ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 92
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(widget.urlAvatar),
                                        ),
                                        SizedBox(width: 20),
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              if(value.isNotEmpty) {
                                                setState(() {
                                                  _disable = false;
                                                });
                                              }
                                              if(value.isEmpty) {
                                                setState(() {
                                                  _disable = true;
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Public response..."
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 197,
                                      top: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: (){
                                            setState(() {
                                              _comment = false;
                                            });
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.grey
                                            ),
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                            onPressed: _disable == true ? null : (){},
                                            disabledColor: isDarkMode ? Color(0xFF303030) : Colors.grey,
                                            child: Text("Reply"),
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ) : Container(
                                height: 0,
                                decoration: BoxDecoration(
                                  color: Colors.transparent
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            showInfoFromBottom == true ? SlidingUpPanel(
              maxHeight: 589,
              minHeight: 589,
              panelBuilder: (scrollController) => BuildSlidingPanel(
                onTap: (){
                  setState(() {
                    showInfoFromBottom = false;
                  });
                }
              ),
            ) : Container(
              height: 0,
              width: 0,
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
      children: [
        Icon(
          item.icon,
          color: item.color,
          size: 25,
        ),
        const SizedBox(width: 12),
        Text(
          item.text,
        )
      ],
    )
  );

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemFeedback:
        
        break;
    }
  }
}

// class Body extends StatefulWidget {
//   final url;

//   const Body({
//     Key key,
//     @required this.url
//   }) : super(key: key);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   YoutubePlayerController _controller;
//   bool fullScreen = false;

//   void runYoutubePlayer() {
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         enableCaption: false,
//         isLive: false,
//       )
//     );
//   }
  
//   @override
//   void initState() {
//     runYoutubePlayer();
//     super.initState();
//   }

//   @override
//   void deactivate() {
//     _controller.pause();
//     super.deactivate();
//   }
  
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
      // onEnterFullScreen: () {
      //   setState(() {
      //     this.fullScreen = true;
      //   });
      // },
//       onExitFullScreen: () {
//         setState(() {
//           this.fullScreen = false;
//         });
//       },
//       player: YoutubePlayer(
//         controller: _controller,
//         aspectRatio: 16 / 9,
//         showVideoProgressIndicator: true,
//         onReady: (){},
//         progressColors: ProgressBarColors(
//           playedColor: Colors.red,
//           handleColor: Colors.redAccent,
//           backgroundColor: Colors.white,
//         ),
//       ),
//       builder: (context, player) {
//         return Column(
//           children: [
//             player,
//             Padding(
//               padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20
//               ),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Welcome to programming C",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }