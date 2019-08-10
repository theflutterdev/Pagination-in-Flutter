/*
Aim : Paginating the data while
loading from a database or from an API

Pros : Reduces the Database maintainence
and pricing of the database

Imagine you are having an app which is having
about 100K+ downloads and 10K+ daily users everyday
and users perform read operations in order to 
load data. when an app having 10K+ daily users
will perform 100K+ to 1Million reads per day
and it again deponds on how optimally you have 
developed the app.

So, in order to reduce the database maintainence, 
Developers can use pagination in your app
which reduces the reads and loading the amount of data
which is required for the user.

So, Enough intro, let's start coding

*/

/*

In this context we are not actually loading the
data from database or API but we actually performed
a pagination example.

*/

import 'package:flutter/material.dart';

int count = 15;
void main() {
  runApp(MaterialApp(
    title: 'Pagination in Flutter',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  bool getmoreflag = false;
  void getMoreData() {
    print(count);
    print("Loading.. more data");
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        count = count + 15;
        getmoreflag = false;
      });
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.70;
      if (maxScroll - currentScroll <= delta) {
        //Load data more data
        if (!getmoreflag) {
          setState(() {
            getmoreflag = true;
          });
          getMoreData();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination in Flutter"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: count,
          itemBuilder: (context, i) {
            if (i == count - 1) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListTile(
              title: Text(i.toString()),
            );
          },
        ),
      ),
    );
  }
}
