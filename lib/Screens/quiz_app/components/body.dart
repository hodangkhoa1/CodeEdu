import 'package:code_edu/Screens/questions_screen/questions_screen.dart';
import 'package:code_edu/Screens/quiz_app/components/category_details.dart';
import 'package:code_edu/Screens/quiz_app/components/category_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatelessWidget {
  const Body({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(15),
      children: [
        SizedBox(height: 20),
        Container(
          height: 350,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10, 
            ),
            children: [
              CategoryHeader(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsScreen()));
                },
                boxColor: Colors.blue,
                icon: FontAwesomeIcons.fileCode,
                text: "Programming C"
              ),
              CategoryHeader(
                onTap: (){},
                boxColor: Colors.red,
                icon: FontAwesomeIcons.java,
                text: "Java"
              ),
              CategoryHeader(
                onTap: (){},
                boxColor: Colors.purple,
                icon: FontAwesomeIcons.html5,
                text: "HTML",
              ),
              CategoryHeader(
                onTap: (){},
                boxColor: Colors.green,
                icon: FontAwesomeIcons.jsSquare,
                text: "JavaScript"
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Container(
          height: 240,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              CategoryDetails(
                onTap: () {},
                backgroundColor: Colors.white,
                borderColor: Colors.blue,
                imageUrl: "https://cdn.iconscout.com/icon/free/png-256/c-programming-569564.png",
                textTitle: "Programming C",
                textDetail: "Practice questions from various chapters in C",
              ),
              CategoryDetails(
                onTap: () {},
                backgroundColor: Colors.white,
                borderColor: Colors.red,
                imageUrl: "https://cdn.iconscout.com/icon/free/png-256/java-43-569305.png",
                textTitle: "Java",
                textDetail: "Practice questions from various chapters in Java",
              ),
              CategoryDetails(
                onTap: () {},
                backgroundColor: Colors.white,
                borderColor: Colors.purple,
                imageUrl: "https://cdn.iconscout.com/icon/free/png-256/html-2752158-2284975.png",
                textTitle: "HTML",
                textDetail: "Practice questions from various chapters in HTML",
              ),
              CategoryDetails(
                onTap: () {},
                backgroundColor: Colors.yellow,
                borderColor: Colors.green,
                imageUrl: "https://cdn.iconscout.com/icon/free/png-256/javascript-1-225993.png",
                textTitle: "JavaScript",
                textDetail: "Practice questions from various chapters in JavaScript",
              )
            ],
          ),
        )
      ],
    );
  }
}