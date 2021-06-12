import 'package:flutter/material.dart';
import '../models/PostModel.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'PostPage.dart';
import 'package:page_transition/page_transition.dart';

class Post extends StatefulWidget {
  final PostModel post;
  Post({required this.post});
  @override
  _PostState createState() => _PostState(post);
}

class _PostState extends State<Post> {
  PostModel post;
  _PostState(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              PageTransition(
                child: PostPage(
                  post: post,
                ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
              ));
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                post.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                gaplessPlayback: false,
              ),
              ListTile(
                title: Text(
                  post.text.toString().toLowerCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                tileColor: Color(0xFFF5F5F5),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
