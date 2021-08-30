import 'package:code_edu/Screens/learn_course/components/build_card_item.dart';
import 'package:code_edu/Screens/learn_detail/learn_detail.dart';
import 'package:code_edu/components/custom_app_bar.dart';
import 'package:code_edu/notifier/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final String urlImage;

  const Body({
    Key key,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context, listen: false);
    return Container(
      child: Column(
        children: [
          CustomAppBar(
            urlImage: widget.urlImage,
            nameScreen: "Learn",
            iconScreen: Icons.help_outline,
            onTap: (){},
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${categoryNotifier.categoryList.length} lesson results are in the software",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: categoryNotifier.categoryList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                      return LearnDetail(
                                        nameText: categoryNotifier.categoryList[index].fullNameCourses,
                                        courseID: categoryNotifier.categoryList[index].courseID,
                                      );
                                    }));
                                  });
                                },
                                child: BuildCardItem(
                                  urlImage: categoryNotifier.categoryList[index].images,
                                  nameCourse: categoryNotifier.categoryList[index].fullNameCourses,
                                  numberRating: categoryNotifier.categoryList[index].rating,
                                  numberView: categoryNotifier.categoryList[index].numberVisitors,
                                  urlAvatar: widget.urlImage,
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 90),
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}