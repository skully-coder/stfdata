import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/PostModel.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  final PostModel post;
  PostPage({required this.post});

  @override
  _PostPageState createState() => _PostPageState(post: post);
}

class _PostPageState extends State<PostPage> {
  final PostModel post;
  var months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  bool isUserLoaded = false;

  bool liked = false;
  _PostPageState({required this.post});
  fetchPost(postId) async {
    // var queryParameters = {'apikey': 'utyqe54xqnb7v5gju7x1'};
    var uri = Uri.parse(
        "https://dummy-wireframe.iecsemanipal.com/social-media/post/$postId?apikey=utyqe54xqnb7v5gju7x1");
    // uri.replace(queryParameters: queryParameters);
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    var d = responseData['data'];
    post.ownerId = d['owner']['_id'];
    post.ownerFName = d['owner']['firstName'];
    post.ownerLName = d['owner']['lastName'];
    post.publishDate = DateTime.parse(d['publishDate']);
    //
    setState(() {
      isUserLoaded = true;
    });
    return post;
  }

  @override
  void initState() {
    super.initState();
    fetchPost(post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool hasScrolled) {
        return <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left_sharp,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: Container(
                height: 2.0,
              ),
            ),
            elevation: 20.0,
            title: Text(
              'Post',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ];
      },
      body: isUserLoaded == true
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Positioned(
                        child: InkWell(
                          onDoubleTap: () {
                            setState(() {
                              liked = !liked;
                              if (liked == true) {
                                post.likes = post.likes + 1;
                              } else {
                                post.likes = post.likes - 1;
                              }
                            });
                          },
                          child: Image.network(
                            post.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        child: SizedBox(
                          height: 100.0,
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ...post.tags.map((e) => Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      height: 40.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          ' #$e\t\t',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0175,
                                          ),
                                        ),
                                      ),
                                    )))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: liked == false
                                ? Icon(
                                    FontAwesomeIcons.heart,
                                  )
                                : Icon(
                                    FontAwesomeIcons.solidHeart,
                                  ),
                            onPressed: () {
                              setState(() {
                                liked = !liked;
                                if (liked == true) {
                                  post.likes = post.likes + 1;
                                } else {
                                  post.likes = post.likes - 1;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${post.likes}',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                    child: Container(
                      child: Text(
                        '${post.ownerFName.toString().toLowerCase()}.${post.ownerLName.toString().toLowerCase()}: ${post.text.toString().toLowerCase()}',
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                    child: Container(
                      child: Text(
                        '${post.publishDate.day} ${months[post.publishDate.month - 1]}, ${post.publishDate.year}',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.0115,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              ],
            ),
    ));
  }
}
