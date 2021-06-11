import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/PostPage.dart';
import 'package:page_transition/page_transition.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                  context,
                  PageTransition(
                    child: PostPage(),
                    type: PageTransitionType.leftToRight,
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
                    'https://picsum.photos/seed/337/600',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(
                      'Social Media',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
        ),
      ],
    ));
  }
}
