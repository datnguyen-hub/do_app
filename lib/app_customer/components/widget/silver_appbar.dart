import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 150.0,
        maxHeight: 150.0,
        child: Container(
            color: Colors.lightBlue, child: Center(child: Text(headerText))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Header Section 1",
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        makeHeader('Header Section 2'),
        SliverFixedExtentList(
            itemExtent: 50.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return new Container(
                alignment: Alignment.center,
                child: new Text('List item $index'),
              );
            }, childCount: 100)),
      ],
    );
  }
}
