// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromMap(jsonString);

import 'dart:convert';

NewsResponse newsResponseFromMap(String str) =>
    NewsResponse.fromMap(json.decode(str));

String newsResponseToMap(NewsResponse data) => json.encode(data.toMap());

class NewsResponse {
  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory NewsResponse.fromMap(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles:
            List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
      };
}

class Article {
  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: Source.fromMap(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "source": source.toMap(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    this.id,
    required this.name,
  });

  final String? id;
  final String name;

  factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
