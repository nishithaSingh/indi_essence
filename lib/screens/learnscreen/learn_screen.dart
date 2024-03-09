import 'package:flutter/material.dart';
import 'api_services.dart';
import 'channel_models.dart';
import 'channelvideo_screen.dart';
import 'video_model.dart';
import 'video_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  List<Channel> _channels = [];
  List<Channel> _filteredChannels = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initChannels();
  }

  _initChannels() async {
    List<String> channelIds = [
      'UCjqCOLOIp8HKkBxBuiQFTdw',
      'UCWzx32hea916nZPtNMGmjsw',
      'UC5CQalEis9ATX-eAqFJ1Tmw',
      'UC62AhAC25Ukuscqux_f1rjA'
      // Add more channel IDs as needed
    ];

    for (String channelId in channelIds) {
      Channel channel = await APIService.instance.fetchChannel(
        channelId: channelId,
      );
      setState(() {
        _channels.add(channel);
        _filteredChannels = _channels;
      });
    }
  }

  _buildProfileInfo(Channel channel) {
    return GestureDetector(
      onTap: () => _navigateToChannelVideos(channel),
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        height: 100.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35.0,
              backgroundImage: NetworkImage(channel.profilePictureUrl ?? ''),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    channel.title ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${channel.subscriberCount ?? 0} subscribers',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildVideo(Channel channel, Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        height: 140.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos(Channel channel) async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance.fetchVideosFromPlaylist(
      playlistId: channel.uploadPlaylistId ?? '',
    );
    List<Video> allVideos = channel.videos ?? []..addAll(moreVideos);
    setState(() {
      channel.videos = allVideos;
    });
    _isLoading = false;
  }

  _onSearchTextChanged(String text) async {
    List<Channel> filteredChannels = _channels
        .where((channel) =>
        channel.title.toLowerCase().contains(text.toLowerCase()))
        .toList();

    setState(() {
      _filteredChannels = filteredChannels;
    });
  }

  _navigateToChannelVideos(Channel channel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChannelVideosScreen(channel: channel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Add an icon (e.g., book icon) to the left of the title
            Icon(Icons.book, color: Colors.black),
            const SizedBox(width: 8.0),
            Text('Learn', style: TextStyle(color: Colors.black)),
          ],
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 250.0,
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchTextChanged,
                decoration: InputDecoration(
                  hintText: 'Search for channels',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(

        children: [
          // Button1 at the beginning of the list
          // Button1 at the beginning of the list
          ElevatedButton(
            onPressed: () {
              // Handle button1 click
              launch("mailto:fusionflourishhub6724@gmail.com?subject=Join as Creator");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black, // Change this color to your desired color
            ),
            child: Text('Become a creator'),
          ),

          Expanded(
            child: _filteredChannels.isNotEmpty
                ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _filteredChannels.any((channel) =>
                    channel.videos.length !=
                        int.parse(channel.videoCount) &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent)) {
                  for (Channel channel in _filteredChannels) {
                    _loadMoreVideos(channel);
                  }
                }
                return false;
              },
              child: ListView.builder(
                itemCount: _filteredChannels.length * 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index.isEven) {
                    int channelIndex = index ~/ 2;
                    if (channelIndex < _filteredChannels.length) {
                      return _buildProfileInfo(
                          _filteredChannels[channelIndex]);
                    }
                  } else {
                    int channelIndex = (index - 1) ~/ 2;
                    if (channelIndex < _filteredChannels.length) {
                      int videoIndex = (index - 1) %
                          _filteredChannels[channelIndex].videos.length;
                      Video video = _filteredChannels[channelIndex]
                          .videos[videoIndex];
                      return _buildVideo(
                          _filteredChannels[channelIndex], video);
                    }
                  }
                  return SizedBox();
                },
              ),
            )
                : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
