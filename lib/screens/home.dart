import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/categories_model.dart';
import 'package:wallpaper_app/models/wallPaper_model.dart';
import 'package:wallpaper_app/screens/search.dart';
import 'package:wallpaper_app/widget/categoryRow.dart';
import 'package:wallpaper_app/widget/widget.dart';

class Home extends StatefulWidget {
  // Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// ignore: deprecated_member_use
  String apiKey = "563492ad6f91700001000001fc04099fed724bae96f76141d32c97a6";
  List<Categories> categories = [
    Categories(
      name: 'Graffiti',
      img: 'asset/image/graffiti.jpeg',
    ),
    Categories(
      name: 'Wild Life',
      img: 'asset/image/wild.jpeg',
    ),
    Categories(
      name: 'Nature',
      img: 'asset/image/nature.jpeg',
    ),
    Categories(
      name: 'City',
      img: 'asset/image/city.jpeg',
    ),
    Categories(
      name: 'Motivation',
      img: 'asset/image/motivation.jpeg',
    ),
    Categories(
      name: 'Outer Space',
      img: 'asset/image/space.jpg',
    ),
  ];

  List<WallPaperModel> wallPaper = [];

  getTrending() async {
    var response = await http
        .get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization": apiKey,
    });
    // print(response.body.toString());
    Map<String, dynamic> hasData = jsonDecode(response.body);
    hasData["photos"].forEach((element) {
      WallPaperModel wallpaperModel;
      wallpaperModel = WallPaperModel.fromMap(element);
      wallPaper.add(wallpaperModel);
    });

    setState(() {});
  }

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // categories = getCategories();
    getTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: appbar(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          suffixIcon: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SearchBar(
                                              searchQuery:
                                                  searchController.text,
                                            )));
                              },
                              child: Icon(Icons.search, color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CategoryRow(
                        title: categories[index].name,
                        imgUrl: categories[index].img,
                      );
                    }),
              ),
              wallPaperList(wallPaper, context),
            ],
          ),
        ),
      ),
    );
  }
}
