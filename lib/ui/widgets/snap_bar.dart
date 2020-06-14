import 'package:flutter/material.dart';
import 'package:chat_snap/utils/data.dart';

class SnapBar extends StatelessWidget implements PreferredSizeWidget {
  AppBar appBar = new AppBar();

  final String title;
  var circleColor = Colors.black12;
  SnapBar({@required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: circleColor,
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            backgroundColor: circleColor,
            backgroundImage: NetworkImage(
              userlist.first.dp,
            )),
      ),
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: circleColor,
          child: Icon(
            Icons.person_add,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        CircleAvatar(
          backgroundColor: circleColor,
          child: Icon(
            Icons.chat_bubble,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
