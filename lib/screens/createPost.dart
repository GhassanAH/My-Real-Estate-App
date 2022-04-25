import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestateapp/model/poster.dart';
import '../utils/constants.dart';
import '../services/uploadImages.dart';
import '../services/posterServices.dart';

class CreatePost extends StatefulWidget {
  String? uid;
  CreatePost({Key? key, this.uid}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var buildingName = TextEditingController();
  var buildingType = TextEditingController();
  var buildingPrice = TextEditingController();
  var buildingDescription = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String imgurl0 = "";
  String imgurl1 = "";
  String imgurl2 = "";
  String imgurl3 = "";
  String imgurl4 = "";
  String imgurl5 = "";
  String imgurl6 = "";
  String imgurl7 = "";
  bool loading = false;

  double lon = 58.3829;
  double lat = 23.5880;

  List<Marker> markers = [
    Marker(
      draggable: true,
      markerId: MarkerId('marker1'),
    ),
  ];
  String governorate = "Muscat";
  List<String> governorates = [
    "Muscat",
    "Ad Dhahirah",
    "Al Batinah North",
    "Al Batinah South",
    "Al Buraymi",
    "Al Wusta",
    "Ash Sharqiyah North",
    "Ash Sharqiyah South",
    "Dhofar",
    "Musandam",
  ];

  Future<Set<Marker>> addMarker(Position newMarkerPosition) async {
    markers.removeAt(0);
    markers.add(
      Marker(
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        markerId: MarkerId('marker1'),
        position:
            LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude),
      ),
    );
    return markers.toSet();
  }

  void _updatePosition(CameraPosition _position) {
    Position newMarkerPosition = Position(
      latitude: _position.target.latitude,
      longitude: _position.target.longitude,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      timestamp: null,
    );
    lat = newMarkerPosition.latitude;
    lon = newMarkerPosition.longitude;

    addMarker(newMarkerPosition);
  }

  Future<void> submitForm() async {
    setState(() {
      loading = true;
    });
    if (formGlobalKey.currentState!.validate() &&
        imgurl0.isNotEmpty &&
        imgurl1.isNotEmpty) {
      String img0 = "";
      String img1 = "";
      String img2 = "";
      String img3 = "";
      String img4 = "";
      String img5 = "";
      String img6 = "";
      String img7 = "";

      if (imgurl0.isNotEmpty) {
        img0 = await uploadUrlImage(imgurl0, 0, widget.uid);
      }
      if (imgurl1.isNotEmpty) {
        img1 = await uploadUrlImage(imgurl1, 1, widget.uid);
      }
      if (imgurl2.isNotEmpty) {
        img2 = await uploadUrlImage(imgurl2, 2, widget.uid);
      }
      if (imgurl3.isNotEmpty) {
        img3 = await uploadUrlImage(imgurl3, 3, widget.uid);
      }
      if (imgurl4.isNotEmpty) {
        img4 = await uploadUrlImage(imgurl4, 4, widget.uid);
      }
      if (imgurl5.isNotEmpty) {
        img5 = await uploadUrlImage(imgurl5, 5, widget.uid);
      }
      if (imgurl6.isNotEmpty) {
        img6 = await uploadUrlImage(imgurl6, 6, widget.uid);
      }
      if (imgurl7.isNotEmpty) {
        img7 = await uploadUrlImage(imgurl7, 7, widget.uid);
      }

      PosterInfo post = PosterInfo(
          buildingName.text,
          buildingType.text,
          buildingPrice.text,
          buildingDescription.text,
          lat,
          lon,
          img0,
          img1,
          img2,
          img3,
          img4,
          img5,
          img6,
          img7,
          "",
          widget.uid,
          governorate);
      await Poster().uploadPoster(post);
      Navigator.of(context).pushReplacementNamed("/poster");
    } else {
      setState(() {
        loading = false;
      });
      createSnackBar(_scaffoldKey,
          "You must provide poster image and one image or check input fields");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Post Creator"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/profile");
            },
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: loading
          ? SpinKitFadingCircle(
              color: Colors.blue,
              size: 100,
            )
          : ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(12.2),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                                child: Text(
                              "Create Post Now",
                              style: Theme.of(context).textTheme.headline1,
                            )),
                          ),
                          Form(
                           
                              key: formGlobalKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: TextFormField(
                                      validator: (buildingName) {
                                        if (buildingName!.isEmpty) {
                                          return "The building Name can not be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: buildingName,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Building Name",
                                          icon: Icon(Icons.home)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: TextFormField(
                                      validator: (buildingtype) {
                                        if (buildingtype!.isEmpty) {
                                          return "The building type can not be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: buildingType,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Building Type",
                                          icon: Icon(Icons.business_sharp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: TextFormField(
                                      validator: (price) {
                                        if (price!.isEmpty) {
                                          return "The price can not be empty";
                                        } else if (double.tryParse(price) ==
                                            null) {
                                          return "The price should be number";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: buildingPrice,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Price",
                                          icon: Icon(Icons.money)),
                                    ),
                                    
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Row(
                                      children:[
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(Icons.place),
                                        ),
                                        DropdownButton<String>(
                                          value: governorate,
                                          elevation: 16,
                                          underline: Container(
                                            height: 1,
                                            color: Colors.grey,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              governorate = newValue!;
                                            });
                                          },
                                          items: governorates
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }
                                        ).toList(),
                                        )
                                      ]
                                    )
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: TextFormField(
                                      validator: (description) {
                                        if (description!.isEmpty) {
                                          return "The description can not be empty";
                                        } else if (description.length < 10) {
                                          return "The description should be of more than 49 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: buildingDescription,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText:
                                              "Description of the price",
                                          icon: Icon(Icons.description)),
                                    ),
                                  ),
                                  Container(
                                      height: 450,
                                      width: double.infinity,
                                      padding: EdgeInsets.all(12.2),
                                      child: FutureBuilder(
                                          future: addMarker(Position(
                                            latitude: 23.5880,
                                            longitude: 58.3829,
                                            accuracy: 1,
                                            altitude: 1,
                                            heading: 1,
                                            speed: 1,
                                            speedAccuracy: 1,
                                            timestamp: null,
                                          )),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            return GoogleMap(
                                              mapType: MapType.normal,
                                              myLocationEnabled: false,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                      target: LatLng(
                                                          23.5880, 58.3829),
                                                      zoom: 13.5),
                                              markers: snapshot.data,
                                              onCameraMove: ((_position) =>
                                                  _updatePosition(_position)),
                                            );
                                          })),
                                  Container(
                                      padding: EdgeInsets.all(8.2),
                                      child: Column(
                                        children: [
                                          Text("Poster Image",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          Row(
                                            children: [
                                              imageContainer(imgurl0.isNotEmpty
                                                  ? imgurl0
                                                  : "poster image"),
                                              IconButton(
                                                  onPressed: () async {
                                                    imgurl0 =
                                                        await UploadImage()
                                                            .uploadPostImages();
                                                    ;
                                                    setState(() {
                                                      imgurl0 = imgurl0;
                                                    });
                                                  },
                                                  icon: Icon(Icons.upload_file))
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(2.2),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Building Images",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl1.isNotEmpty
                                                        ? imgurl1
                                                        : "image1"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl1 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl1 = imgurl1;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl2.isNotEmpty
                                                        ? imgurl2
                                                        : "image2"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl2 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl2 = imgurl2;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl3.isNotEmpty
                                                        ? imgurl3
                                                        : "image3"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl3 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl3 = imgurl3;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl4.isNotEmpty
                                                        ? imgurl4
                                                        : "image4"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl4 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl4 = imgurl4;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl5.isNotEmpty
                                                        ? imgurl5
                                                        : "image5"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl5 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl5 = imgurl5;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl6.isNotEmpty
                                                        ? imgurl6
                                                        : "image6"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl6 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl6 = imgurl6;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                imageContainer(
                                                    imgurl7.isNotEmpty
                                                        ? imgurl7
                                                        : "image7"),
                                                IconButton(
                                                    onPressed: () async {
                                                      imgurl7 =
                                                          await UploadImage()
                                                              .uploadPostImages();
                                                      setState(() {
                                                        imgurl7 = imgurl7;
                                                      });
                                                    },
                                                    icon:
                                                        Icon(Icons.upload_file))
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                  ElevatedButton(
                                    onPressed: () {
                                      submitForm();
                                    },
                                    child: Text("Create"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        fixedSize: Size(200, 30)),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
