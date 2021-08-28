import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallPaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';

class Category extends StatefulWidget {
  final String categoryName;

  const Category({required this.categoryName});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String apiKey = "563492ad6f91700001000001fc04099fed724bae96f76141d32c97a6";
  List<WallPaperModel> wallPaper = [];
  getSearch(String query) async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query"),
        headers: {
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

  @override
  void initState() {
    getSearch(widget.categoryName);
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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              wallPaperList(wallPaper, context),
            ],
          ),
        ),
      ),
    );
  }
}
