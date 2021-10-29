import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_edu/data/question_category.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lottie/lottie.dart';

class Body extends StatefulWidget {
  final String courseID;
  
  const Body({
    Key key,
    @required this.courseID,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  SwiperController _controller = SwiperController();
  final db = FirebaseFirestore.instance;
  List<QuestionCategory> _questionCategoryList = [];
  AnimationController _notFoundController;

  @override
  void initState() {
    _notFoundController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _notFoundController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: db.collection('Courses').doc(widget.courseID).collection('QNA').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var doc = snapshot.data.docs;
            doc.forEach((element) {
              QuestionCategory questionCategory = QuestionCategory.fromMap(element.data());
              _questionCategoryList.add(questionCategory);
            });
            return Container(
              child: _questionCategoryList.isNotEmpty ? Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 38),
                    child: Swiper(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Card(
                            shadowColor: Colors.grey,
                            elevation: 1.5,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 50
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _questionCategoryList[index].question.replaceAll(r'\n', '\n'),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: _questionCategoryList[index].options.length,
                                      itemBuilder: (context, optionsIndex) {
                                        OptionsCategory optionsCategory = OptionsCategory.fromJson(_questionCategoryList[index].options[optionsIndex]);
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${optionsCategory.nameOption}. "
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    optionsCategory.detailOption
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          back: Card(
                            shadowColor: Colors.grey,
                            elevation: 1.5,
                            child: Center(
                              child: Text("Hello"),
                            ),
                          )
                        );
                      },
                      viewportFraction: 0.8,
                      scale: 0.9,
                      layout: SwiperLayout.STACK,
                      itemWidth: MediaQuery.of(context).size.width - 40,
                      itemHeight: MediaQuery.of(context).size.height - 200,
                      physics: NeverScrollableScrollPhysics(),
                      controller: _controller,
                      pagination: SwiperPagination(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.grey,
                          activeColor: Colors.blue
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 24,
                    right: 24,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            child: FloatingActionButton(
                              heroTag: "arrowBack",
                              onPressed: (){
                                setState(() {
                                  _controller.previous();
                                });
                              },
                              child: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            child: FloatingActionButton(
                              heroTag: "arrowForward",
                              onPressed: (){
                                setState(() {
                                  _controller.next();
                                });
                              },
                              child: Icon(
                                Icons.arrow_forward,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ) : Lottie.asset(
                "assets/images/38061-search.json",
                height: MediaQuery.of(context).size.height * 0.30,
                controller: _notFoundController,
                onLoaded: (animation) {
                  _notFoundController..duration = animation.duration..repeat(
                    reverse: true
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}