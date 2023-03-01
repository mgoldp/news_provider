import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '041fff39bf8f4541b225e0c8f56cc090';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCatyegory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    categories.forEach((element) {
      categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => _selectedCatyegory;
  set selectedCategory(String valor) {
    _selectedCatyegory = valor;

    getArticlesByCategory(valor);
    notifyListeners();
  }

  getTopHeadlines() async {
    const url = '$_urlNews/top-headlines?apiKey=$_apiKey&country=us';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);

    final newsResponse = newsResponseFromMap(resp.body);

    headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url =
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=us&category=$category';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);

    final newsResponse = newsResponseFromMap(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }
}
