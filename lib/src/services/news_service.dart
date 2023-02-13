import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '041fff39bf8f4541b225e0c8f56cc090';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    const url = '${_urlNews}/top-headlines?apiKey=${_apiKey}&country=us';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);

    final newsResponse = newsResponseFromMap(resp.body);

    headLines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
