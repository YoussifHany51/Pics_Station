class WallPaperModel {
  String photographer = '';
  String photographerUrl = '';
  int photographerId = 0;
  SrcModel src;
  WallPaperModel({
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.src,
  });
  factory WallPaperModel.fromMap(Map<String, dynamic> hasData) {
    return WallPaperModel(
        photographer: hasData["photographer"],
        photographerUrl: hasData["photographer_url"],
        photographerId: hasData["photographer_id"],
        src: SrcModel.fromMap(hasData["src"]));
  }
}

class SrcModel {
  String original = '';
  String small = '';
  String portrait = '';
  SrcModel({
    required this.original,
    required this.small,
    required this.portrait,
  });

  factory SrcModel.fromMap(Map<String, dynamic> hasData) {
    return SrcModel(
        original: hasData["original"],
        small: hasData["small"],
        portrait: hasData["portrait"]);
  }
}
