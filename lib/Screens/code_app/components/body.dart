import 'package:code_edu/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  final String urlImage;

  const Body({
    Key key,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  AnimationController _wrongController;

  @override
  void initState() {
    _wrongController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _wrongController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomAppBar(
            urlImage: widget.urlImage,
            nameScreen: "Code",
            iconScreen: Icons.settings,
            onTap: (){},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_sdd6siet.json",
              height: MediaQuery.of(context).size.height * 0.30,
              controller: _wrongController,
              onLoaded: (animation) {
                _wrongController..duration = animation.duration..repeat(
                  reverse: true
                );
              },
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: Padding(
          //       padding: const EdgeInsets.all(15),
          //       child: Column(
          //         children: [
          //           Container(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               "Choose a language",
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.bold
          //               ),
          //             ),
          //           ),
          //         ],
          //       )
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}