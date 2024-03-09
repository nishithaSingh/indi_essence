import '../modules/news_channels_headlines_model.dart';
import '../repository/news_repository.dart';

class NewsViewModel{

  final _rep = NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async{
    final response = _rep.fetchNewsChannelHeadlinesApi();
    return response;
  }

}