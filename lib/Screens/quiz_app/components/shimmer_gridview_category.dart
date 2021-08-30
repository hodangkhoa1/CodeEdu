import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridViewCategory extends StatelessWidget {
  const ShimmerGridViewCategory({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      period: Duration(
        milliseconds: 850,
      ),
      child: Container(
        height: 320,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 4,
          itemBuilder: (_, index) => Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
          )
        ),
      ),
    );
  }
}