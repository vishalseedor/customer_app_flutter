import 'package:flutter/material.dart';

class DotDivider extends StatelessWidget {
  final double width;
  final double height;
  final double gap;
  final Color color;
  final double lineHeight;

  const DotDivider(
      {Key key,
      this.height = 1.0,
      this.color = Colors.black,
      this.width = 2.0,
      this.gap = 2.0,
      this.lineHeight = 10.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / dashWidth).floor();
        return Container(
          height: (lineHeight * 2) + height,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: dashCount,
            itemBuilder: (BuildContext context, int index) => Center(
              child: Container(
                width: dashWidth,
                height: dashHeight,
                margin:
                    EdgeInsets.symmetric(vertical: lineHeight, horizontal: gap),
                decoration: BoxDecoration(color: color),
              ),
            ),
          ),
        );
      },
    );
  }
}
