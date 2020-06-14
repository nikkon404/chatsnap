import 'package:flutter/material.dart';
import 'package:chat_snap/ui/widgets/snap_bar.dart';
import 'package:chat_snap/utils/data.dart';

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget storyWidget() {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Friends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.142,
              // color: Colors.green,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: userlist.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 75.0,
                          height: 75.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2.5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userlist[index].dp)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.0)),
                            color: Colors.black12,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.004,
                        ),
                        Text('username')
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget subscriptionWidget() {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Subscriptions ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.24,
              // color: Colors.green,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: subs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.25,
                          height: size.height * 0.24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(subs[index].image)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                width: size.width * 0.25,
                                // height: 100,
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    subs[index].text,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ),
                          bottom: 2,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget forYouWidget() {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'For you',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: forYou.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 9 / 14),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.6,
                          height: size.height * 0.45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(forYou[index].image)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                width: size.width * 0.5,
                                // height: 100,
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    forYou[index].text,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                          bottom: 6,
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SnapBar(title: 'Community'),
        body: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                storyWidget(),
                subscriptionWidget(),
                forYouWidget(),
                SizedBox(
                  height: 70,
                )
              ],
            ),
            Positioned(
              child: Container(
                // color: Colors.black.withAlpha(45),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.black38, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: size.width,
                height: 70,
              ),
              bottom: 0,
            )
          ],
        ));
  }
}
