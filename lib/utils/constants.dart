import 'package:flutter/material.dart';
import '../services/uploadImages.dart';
import '../utils/curve_containe.dart';
Widget imageContainer(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(Icons.image),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: 120.0,
            child: Text(
              title,
              overflow: TextOverflow.clip,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
      ],
    ),
  );
}

void createSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
  final snackBar =
      new SnackBar( duration: const Duration(seconds: 800), content: new Text(message), backgroundColor: Colors.red);

  scaffoldKey.currentState?.showSnackBar(snackBar);
}

Widget CardHeading(Icon icon, String title, double wheight) {
  return SizedBox(
    height: wheight,
    width: double.infinity,
    child: Card(
        elevation: 5,
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.all(12.0), child: icon),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        )),
  );
}

Widget appDrawer(BuildContext context, Function logoutUser, String title) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      padding: EdgeInsets.all(10),

      child: ListView(
        children: [
          ListTile(
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 2,
            color: Colors.black,),
          ListTile(
            tileColor: Colors.black38,
            leading: Icon(
              Icons.person_pin,
              color: Colors.white,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(title == "Home"?"/home":"/profile");
            },
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 0.5,
            color: Colors.black,),
          SizedBox(
            height: 20,
          ),
          ListTile(
            tileColor: Colors.black26,
            leading: Icon(
              Icons.post_add_rounded,
              color: Colors.white,
            ),
            title: Text(
              "My Posters",
              style: TextStyle(
                fontSize: 19.1,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/poster");
            },
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 0.5,
            color: Colors.black,),
          SizedBox(
            height: 20,
          ),
          ListTile(
            tileColor: Colors.black38,
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            title: Text(
              "Log out",
              style: TextStyle(fontSize: 19.1, color: Colors.white),
            ),
            onTap: () {
              logoutUser();
            },
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 0.5,
            color: Colors.black,),
          SizedBox(
            height: 235,
          ),
          Container(
            child: Center(
              child: Text("Aqaar App",
                  style: TextStyle(fontSize: 30, color: Colors.lime)),
            ),
          )
        ],
      ),
    ),
  );
}
