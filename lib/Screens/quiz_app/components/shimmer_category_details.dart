import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryDetails extends StatelessWidget {
  const ShimmerCategoryDetails({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      period: Duration(
        milliseconds: 850,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 180,
          color: Colors.grey,
        ),
      ),
    );
  }
}