import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;

  Skeleton({Key key, this.height, this.width }) : super(key: key);

  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width:  widget.width,
        height: widget.height, 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(gradientPosition.value, 0),
            end: Alignment(-1, 0),
            colors: [Colors.white12, Colors.black38, Colors.white12]
          )
        ),
    );
  }
}