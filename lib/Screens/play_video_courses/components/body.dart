import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Body extends StatefulWidget {
  final bool isDarkMode;
  final String url;
  final String nameLesson;
  final String urlAvatar;

  const Body({
    Key key,
    @required this.isDarkMode,
    @required this.url,
    @required this.nameLesson,
    @required this.urlAvatar,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  YoutubePlayerController _controller;

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
    return Container(
      decoration: BoxDecoration(
        gradient: widget.isDarkMode ? LinearGradient(
          colors: [
            Color(0xFF181818).withOpacity(0.9),
            Color(0xFF3C4043),
          ],
          begin: const FractionalOffset(0.0, 0.4),
          end: Alignment.topRight,
        ) : LinearGradient(
          colors: [
            Color(0xFF0F17AD).withOpacity(0.9),
            Color(0xFF6985E8),
          ],
          begin: const FractionalOffset(0.0, 0.4),
          end: Alignment.topRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 30),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Color(0xFFFAFAFE),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: (){},
                    child: Icon(
                      Icons.info_outline,
                      size: 25,
                      color: Color(0xFFFAFAFE),
                    ),
                  )
                ],
              ),
            ),
            YoutubePlayerBuilder(
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
                return player;
              }
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      widget.nameLesson,
                      style: TextStyle(
                        fontSize: 18,
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
                          //showInfoFromBottom = true;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: widget.isDarkMode ? Color(0xFF909090) : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey[400]),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
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
                    width: MediaQuery.of(context).size.width - 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "giáo.làng",
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.isDarkMode ? Colors.grey[200] : Colors.black,
                            fontWeight: FontWeight.w500,
                            height: 1.3
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "PRO",
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.isDarkMode ? Color(0xFF909090) : Colors.black,
                            fontWeight: FontWeight.w500,
                            height: 1.3
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey[400]),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 20
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.urlAvatar),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 316,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: Color(0xFF313131),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngân Nguyễn",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Hello thầy Hoàng nha. Lâu ngày không gặp thầy, dạo này thầy có khỏe không thầy",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF313131),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey
                        ),
                        child: Icon(
                          FontAwesomeIcons.ellipsisH,
                          size: 20,
                          color: Colors.blueGrey[50],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Write your message",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0
                            )
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0
                            )
                          )
                        ),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xFF6B5ECD),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.send_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}