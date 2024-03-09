import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:indi_essence/screens/stories/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

import 'modules/news_channels_headlines_model.dart';



class StoriesMain extends StatefulWidget {
  const StoriesMain({Key? key}) : super(key: key);

  @override
  State<StoriesMain> createState() => _StoriesMainState();
}

enum FilterList { bbcNews, aryNews, independentNews, routers, cnn, alJazeera }

class _StoriesMainState extends State<StoriesMain> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Image.asset(
        //     'images/category_icon.jpg',
        //     height: 30,
        //     width: 30,
        //   ),
        // ),
        foregroundColor: Colors.black,
        title: Text(
          'Narrative',
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (FilterList item) {
              if (item == FilterList.bbcNews) {
                // Handle BBC News selection
              } else if (item == FilterList.aryNews) {
                // Handle ARY News selection
              }
              // Add more cases for other options if needed

              setState(() {
                selectedMenu = item; // Update selectedMenu
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text('ARY News'),
              ),
              // Add more menu items as needed
            ],
          ),
        ],
      ),
      body: FutureBuilder<NewsChannelHeadlinesModel>(
        future: newsViewModel.fetchNewsChannelHeadlinesApi(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCircle(
                size: 50,
                color: Colors.blue,
              ),
            );
          } else {
            if (snapshot.data != null && snapshot.data!.articles != null) {
              return ListView.builder(
                itemCount: snapshot.data!.articles!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                  return SizedBox(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: height * 0.6,
                          width: width * 0.9,
                          padding: EdgeInsets.symmetric(
                            horizontal: height * 0.02,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(child: spinkit2),
                              errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(15),
                              height: height * .22,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.7,
                                    child: Text(
                                      snapshot.data!.articles![index].title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      // style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: width * 0.7,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].source!.name.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          // style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          format.format(dateTime),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          // style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No articles available'),
              );
            }
          }
        },
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);