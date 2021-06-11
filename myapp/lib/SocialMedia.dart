import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class SocialMedia extends StatefulWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  var currentIndex = 0;

  // fetchPosts() async {
  //   await http.get()
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.blue[900],
          elevation: 4,
          onTap: (value) {
            setState(() {
              currentIndex = value;
              print(currentIndex);
            });
          },
          // type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(
            color: Colors.white,
          ),
          selectedLabelStyle: TextStyle(
            color: Colors.white,
          ),
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.users),
              label: 'Users',
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool hasScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.chevron_left_sharp),
                  onPressed: () => Navigator.pop(context),
                ),
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blue[900],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(2.0),
                  child: Container(
                    height: 2.0,
                    // color: DataHolder.of(context).theme.homepageAppBarBottomBorder,
                  ),
                ),
                elevation: 20.0,
                title: Text(
                  'Social Media',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ];
          },
          body: currentIndex == 0
              ? Container(
                  child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              PageTransition(
                                child: SocialMedia(),
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
                ))
              : Container(
                  child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              PageTransition(
                                child: SocialMedia(),
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
                                  'Social M',
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
                )),
        ));
  }
}
