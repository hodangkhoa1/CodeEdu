import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final Function onTap;
  final Color backgroundColor;
  final Color borderColor;
  final String imageUrl;
  final String textTitle;
  final String textDetail;
  
  const CategoryDetails({
    Key key,
    @required this.onTap,
    @required this.backgroundColor,
    @required this.borderColor,
    @required this.imageUrl,
    @required this.textTitle,
    @required this.textDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width * 0.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: borderColor
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                )
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                textTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                textDetail,
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}