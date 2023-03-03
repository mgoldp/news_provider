import 'package:flutter/material.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:news_provider/src/theme/tema.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(child: _ListaCategoria()),
          ],
        ),
      ),
    );
  }
}

class _ListaCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final categoryName = categories[index].name;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _CategoryButton(
                category: categories[index],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${categoryName[0].toUpperCase()}${categoryName.substring(1)}',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      }, //print('${category.name}'),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? miTema.colorScheme.secondary
              : Colors.black54,
        ),
      ),
    );
  }
}
