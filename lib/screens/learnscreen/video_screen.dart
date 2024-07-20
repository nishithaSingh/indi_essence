import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({required this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class Comment {
  final String userName;
  final String text;

  Comment(this.userName, this.text);
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [];

  // Banned phrases for comment moderation
  final List<String> bannedPhrases = ["so ugly", "so cheap", "I hate you.",
    "I wish you were never part of my life",
    "you always do this",
    "I don’t think your passions are worthwhile",
    "We should break up","that looks like shit","your content is waste"];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  void _postComment() {
    final String newComment = _commentController.text;

    // Check if the comment contains any banned phrases
    if (!_isCommentAllowed(newComment)) {
      // Comment is not allowed, do not add to the list
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Comment Moderation'),
            content: Text('This comment is not allowed.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Comment is allowed, add to the list
      setState(() {
        _comments.add(Comment('User', newComment));
        _commentController.clear();
      });
    }
  }

  // Function to check if a comment is allowed
  bool _isCommentAllowed(String comment) {
    // Convert comment to lowercase for case-insensitive comparison
    final lowerCaseComment = comment.toLowerCase().trim();

    // Check if the comment contains any banned phrases
    return !bannedPhrases.any((phrase) => lowerCaseComment.contains(phrase.toLowerCase().trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _postComment,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_comments[index].userName),
                  subtitle: Text(_comments[index].text),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
