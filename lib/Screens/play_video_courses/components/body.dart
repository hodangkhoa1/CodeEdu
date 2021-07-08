import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Body extends StatefulWidget {
  final url;

  const Body({
    Key key,
    @required this.url
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
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome to programming C",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}