import 'package:flutter/material.dart';
import '../utils/uploadImages.dart';

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
      new SnackBar(content: new Text(message), backgroundColor: Colors.red);

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
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          ListTile(
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.arrow_back,
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
          ListTile(
            tileColor: Colors.black38,
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 19.1,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(title == "Home"?"/home":"/profile");
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            tileColor: Colors.black26,
            leading: Icon(
              Icons.create,
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
          SizedBox(
            height: 20,
          ),
          ListTile(
            tileColor: Colors.black38,
            leading: Icon(
              Icons.person,
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
          SizedBox(
            height: 300,
          ),
          Container(
            child: Center(
              child: Text("My Real Estate App",
                  style: TextStyle(fontSize: 20, color: Colors.black38)),
            ),
          )
        ],
      ),
    ),
  );
}
