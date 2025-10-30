import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProject03 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject03State();
}

class _MyProject03State extends State<MyProject03> {

  Future<List<dynamic>> fetchNews() async {
    const apiKey = 'xxx';
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey');
    final res = await http.get(url);
    final data = jsonDecode(res.body);
    return data['articles'];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Top News')),
      body: FutureBuilder(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) return const Text('No news available.');
          final news = snapshot.data!;
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, i) => ListTile(
              leading: news[i]['urlToImage'] != null
                  ? Image.network(news[i]['urlToImage'], width: 80, fit: BoxFit.cover)
                  : const Icon(Icons.image_not_supported),
              title: Text(news[i]['title'] ?? ''),
              subtitle: Text(news[i]['source']['name'] ?? ''),
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(news[i]['title']),
                  content: Text(news[i]['description'] ?? 'No details'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
