import 'package:flutter/material.dart';
import 'package:chat_snap/ui/widgets/snap_bar.dart';
import 'package:chat_snap/utils/data.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var boxHeight = 95.0;
    userlist.shuffle();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SnapBar(title: 'Chat'),
      // backgroundColor: Colors.cyan,
      body: Stack(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: userlist.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < userlist.length) {
                var user = userlist[index];
                var color = (index % 3 == 0) ? Colors.red : Colors.blue;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(user.dp),
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      Text('  New snap - 2 min',
                          style: TextStyle(color: color)),
                    ],
                  ),
                  trailing: (index % 3 == 0)
                      ? Text(
                          '😊',
                          textScaleFactor: 1.4,
                        )
                      : SizedBox(),
                );
              } else {
                return Container(
                  height: boxHeight,
                );
              }
            },
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
              height: boxHeight,
            ),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
