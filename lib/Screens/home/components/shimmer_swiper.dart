import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSwiper extends StatelessWidget {
  const ShimmerSwiper({
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
        width: MediaQuery.of(context).size.width,
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey
        ),
      ),
    );
  }
}