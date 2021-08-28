import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallPaper_model.dart';
import 'package:wallpaper_app/screens/imageView.dart';

Widget appbar() {
  return RichText(
    text: TextSpan(
      text: 'Pics',
      style: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          fontSize: 30),
      children: [
        TextSpan(
          text: 'Station',
          style: TextStyle(color: Colors.amber.shade900),
        ),
      ],
    ),
  );
}

Widget wallPaperList(List<WallPaperModel> wallpaper, context) {
  return Container(
    height: 630,
    padding: EdgeInsets.symmetric(
      horizontal: 16,
    ),
    child: GridView.count(
        //  physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        children: wallpaper.map((wallPaper) {
          return GridTile(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ImageView(
                              imageUrl: wallPaper.src.portrait,
                            )));
              },
              child: Hero(
                tag: wallPaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      wallPaper.src.portrait,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList()),
  );
}
