import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modules/news_channels_headlines_model.dart';


class NewsRepository {


  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi()async{

    String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=ded0c5c1a02646039179fa98c89492c1';

    final response = await http.get(Uri.parse(url));
    if(kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);

    }
    throw Exception('Error');

  }

}