import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shimmer",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your List"),
      ),
      body: Center(
        child: DelayedList(),
      ),
    );
  }
}

class DelayedList extends StatefulWidget {
  @override
  _DelayedListState createState() => _DelayedListState();
}

class _DelayedListState extends State<DelayedList> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    return isLoading ? ShimmerList() : DataList(timer);
  }
}

class DataList extends StatelessWidget {
  final Timer timer;

  DataList(this.timer);

  @override
  Widget build(BuildContext context) {
    timer.cancel();
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Text(i.toString()),
        );
      },
    );
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          print(time);

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 280;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: 500,
        child: Shimmer.fromColors(
          baseColor: Colors.black,
          highlightColor: Colors.white,
          child: Image.asset("thecsguy.PNG"),
          period: Duration(seconds: 3),
        ),
      ),
    );
  }
}

class WallpaperImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        wallpaper(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 25),
            child: shimmerText(),
          ),
        )
      ],
    );
  }

  Widget shimmerText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500],
      highlightColor: Colors.white,
      child: Text(
        "> Slide to unlock",
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  wallpaper(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Image.asset(
        "wallpaper.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
