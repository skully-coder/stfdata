import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/PostModel.dart';
import 'models/UserModel.dart';
import 'widgets/PostPage.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'widgets/UserPage.dart';
import 'package:page_transition/page_transition.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  var currentIndex = 0;
  List<PostModel> postModel = [];
  List<UserModel> userModel = [];
  List<String> userNames = [];
  bool isPostLoaded = false;
  bool isUserLoaded = false;

  List<UserModel> tempuserModel = [];

  List<PostModel> temppostModel = [];

  String searchTerm = '';

  // var res = {
  //   "data": [
  //     {
  //       "location": {
  //         "state": "Rheinland-Pfalz",
  //         "street": "4118, Schulstraße",
  //         "city": "Fellbach",
  //         "timezone": "-7:00",
  //         "country": "Germany"
  //       },
  //       "_id": "60a883fbba5fc728ad27da58",
  //       "id": "0F8JIqi4zwvb77FGz6Wt",
  //       "lastName": "Fiedler",
  //       "firstName": "Heinz-Georg",
  //       "email": "heinz-georg.fiedler@example.com",
  //       "title": "mr",
  //       "picture": "https://randomuser.me/api/portraits/men/81.jpg",
  //       "__v": 0,
  //       "dateOfBirth": "1974-03-12T21:15:08.878Z",
  //       "gender": "male",
  //       "phone": "0700-3090279",
  //       "registerDate": "2020-03-07T00:42:32.221Z"
  //     },
  //     {
  //       "location": {
  //         "state": "Otago",
  //         "street": "7459, New North Road",
  //         "country": "New Zealand",
  //         "timezone": "+1:00",
  //         "city": "Napier"
  //       },
  //       "_id": "60a883fbba5fc728ad27da59",
  //       "id": "0P6E1d4nr0L1ntW8cjGU",
  //       "picture": "https://randomuser.me/api/portraits/women/74.jpg",
  //       "lastName": "Hughes",
  //       "email": "katie.hughes@example.com",
  //       "title": "miss",
  //       "firstName": "Katie",
  //       "__v": 0,
  //       "dateOfBirth": "1945-08-26T00:33:32.936Z",
  //       "gender": "female",
  //       "phone": "(931)-868-5781",
  //       "registerDate": "2020-05-04T20:18:35.224Z"
  //     },
  //     {
  //       "location": {
  //         "street": "906, Risstubben",
  //         "city": "Kaland",
  //         "state": "Vest-Agder",
  //         "country": "Norway",
  //         "timezone": "0:00"
  //       },
  //       "_id": "60a883fbba5fc728ad27da5a",
  //       "id": "1Lkk06cOUCkiAsUXFLMN",
  //       "title": "mr",
  //       "lastName": "Aasland",
  //       "firstName": "Vetle",
  //       "picture": "https://randomuser.me/api/portraits/men/97.jpg",
  //       "email": "vetle.aasland@example.com",
  //       "__v": 0,
  //       "dateOfBirth": "1949-09-09T06:22:16.422Z",
  //       "gender": "male",
  //       "phone": "81142945",
  //       "registerDate": "2020-01-24T04:21:04.576Z"
  //     },
  //     {
  //       "location": {
  //         "street": "218, The Crescent",
  //         "country": "United Kingdom",
  //         "state": "Rutland",
  //         "city": "Sunderland",
  //         "timezone": "-1:00"
  //       },
  //       "_id": "60a883fbba5fc728ad27da5b",
  //       "id": "1OuR3CWOEsfISTpFxsG7",
  //       "picture": "https://randomuser.me/api/portraits/men/66.jpg",
  //       "lastName": "Vasquez",
  //       "email": "dylan.vasquez@example.com",
  //       "title": "mr",
  //       "firstName": "Dylan",
  //       "__v": 0,
  //       "dateOfBirth": "1996-01-25T23:16:26.578Z",
  //       "gender": "male",
  //       "phone": "017684 69068",
  //       "registerDate": "2019-12-11T20:06:40.522Z"
  //     },
  //     {
  //       "location": {
  //         "state": "Andalucía",
  //         "timezone": "-1:00",
  //         "street": "4944, Calle de Atocha",
  //         "city": "Las Palmas de Gran Canaria",
  //         "country": "Spain"
  //       },
  //       "_id": "60a883fbba5fc728ad27da5c",
  //       "id": "1pRsh5nXDIH3pjEOZ17A",
  //       "lastName": "Vicente",
  //       "title": "miss",
  //       "firstName": "Margarita",
  //       "email": "margarita.vicente@example.com",
  //       "picture": "https://randomuser.me/api/portraits/women/5.jpg",
  //       "__v": 0,
  //       "dateOfBirth": "1950-07-20T11:47:20.779Z",
  //       "gender": "female",
  //       "phone": "902-482-251",
  //       "registerDate": "2019-12-04T01:21:50.022Z"
  //     },
  //   ]
  // };

  fetchPosts() async {
    // var queryParameters = {'apikey': 'utyqe54xqnb7v5gju7x1'};
    var uri = Uri.parse(
        "https://dummy-wireframe.iecsemanipal.com/social-media/posts?apikey=utyqe54xqnb7v5gju7x1");
    // uri.replace(queryParameters: queryParameters);
    var response = await http.get(uri);
    var responseData = json.decode(response.body);

    var data = responseData['data'];
    try {
      for (var d in data) {
        PostModel p = PostModel(
          id: d["_id"],
          image: d['image'],
          likes: d['likes'],
          link: d['link'],
          tags: d['tags'],
          text: d['text'],
          userId: d['id'],
        );
        // p.display();
        postModel.add(p);
      }
      setState(() {
        isPostLoaded = true;
        temppostModel = postModel;
      });
      return postModel;
    } catch (e) {
      print(e);
    }
  }

  fetchUsers() async {
    var queryParameters = {'apikey': 'utyqe54xqnb7v5gju7x1'};
    var uri = Uri.parse(
        "https://dummy-wireframe.iecsemanipal.com/social-media/users?apikey=utyqe54xqnb7v5gju7x1");
    uri.replace(queryParameters: queryParameters);
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    // var responseData = res;
    var data = responseData['data'];

    //
    try {
      for (var d in data!) {
        userNames.add("${d['firstName']} ${d['lastName']}");
        UserModel p = UserModel(
          id: d["_id"],
          userId: d['id'],
          dateofBirth: d['dateOfBirth'] != null
              ? DateTime.parse(d['dateOfBirth'].toString())
              : d['dateOfBirth'],
          email: d['email'],
          firstName: d['firstName'],
          gender: d['gender'],
          lastName: d['lastName'],
          phone: d['phone'],
          picture: d['picture'],
          registerDate: DateTime.parse(d['registerDate'].toString()),
          title: d['title'],
          location: d['location'],
        );
        //
        userModel.add(p);
      }
      setState(() {
        isUserLoaded = true;
        tempuserModel = userModel;
      });
      return userModel;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
    fetchUsers();
  }

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
              //
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
              ? isPostLoaded == true && mounted
                  ? Container(
                      child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.white),
                              // fillColor: DataHolder.of(context).theme.networkDrawerBg,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchTerm = value;
                                temppostModel =
                                    relevantResultsPosts(value, postModel);
                                // print(value + ": $temppostModel");
                              });
                            },
                          ),
                        ),
                        ...temppostModel.map((post) => Container(
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
                                        reverseDuration:
                                            Duration(milliseconds: 300),
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
                            ))),
                      ],
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
              : isUserLoaded == true
                  ? Container(
                      child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.white),
                              // fillColor: DataHolder.of(context).theme.networkDrawerBg,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                tempuserModel =
                                    relevantResultsUsers(value, userModel);
                              });
                            },
                          ),
                        ),
                        Column(
                          children: [
                            ...tempuserModel.map((user) => Container(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          PageTransition(
                                            child: UserPage(
                                              user: user,
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 300),
                                            reverseDuration:
                                                Duration(milliseconds: 300),
                                          ));
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image.network(
                                            user.picture,
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.40,
                                            fit: BoxFit.cover,
                                          ),
                                          ListTile(
                                            title: Text(
                                              '${user.firstName} ${user.lastName}',
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
                                ))),
                          ],
                        ),
                      ],
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
        ));
  }

  List<UserModel> relevantResultsUsers(searchTerm, List<UserModel> users) {
    if (searchTerm.length < 0) {
      return users;
    }
    return users
        .where((item) =>
            item.firstName.toLowerCase().contains(searchTerm.toLowerCase()) ||
            item.lastName.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }

  List<PostModel> relevantResultsPosts(searchTerm, List<PostModel> posts) {
    if (searchTerm.length < 0) {
      return posts;
    }

    return posts
        .where((item) => item.text
            .toString()
            .toLowerCase()
            .contains(searchTerm.toLowerCase()))
        .toList();
  }
}
