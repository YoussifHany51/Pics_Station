import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallPaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  String searchQuery = '';
  SearchBar({required this.searchQuery});

  @override
  _SearchBarState createState() => _SearchBarState();
}

TextEditingController searchController = TextEditingController();

class _SearchBarState extends State<SearchBar> {
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
    getSearch(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
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
                                getSearch(searchController.text);
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
              wallPaperList(wallPaper, context),
            ],
          ),
        ),
      ),
    );
  }
}
