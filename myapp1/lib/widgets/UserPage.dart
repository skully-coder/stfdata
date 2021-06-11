import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp1/models/UserModel.dart';

class UserPage extends StatefulWidget {
  final UserModel user;
  UserPage({required this.user});

  @override
  _UserPageState createState() => _UserPageState(user: user);
}

class _UserPageState extends State<UserPage> {
  final UserModel user;
  _UserPageState({required this.user});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          // Container(
          //   child: CircleAvatar(
          //     radius: 100.0,
          //     backgroundImage: NetworkImage(user.picture),
          //   ),
          // ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                width: double.infinity,
                child: Image.network(
                  user.picture,
                  fit: BoxFit.fill,
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
                bottom: 30.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${user.firstName} ${user.lastName}",
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${user.location['city']}, ${user.location['country']}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ListTile(
            leading: Icon(
              FontAwesomeIcons.phone,
              color: Colors.black54,
            ),
            title: Text(
              'Phone',
              style: TextStyle(),
            ),
            subtitle: Text(
              '${user.phone}',
              style: TextStyle(),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.user,
              color: Colors.black54,
            ),
            subtitle: Text(
              '${user.gender.toString().toUpperCase()}',
              style: TextStyle(),
            ),
            title: Text(
              'Gender',
              style: TextStyle(),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.mailBulk,
              color: Colors.black54,
            ),
            subtitle: Text(
              '${user.email.toString()}',
              softWrap: true,
              style: TextStyle(),
            ),
            title: Text(
              'Email',
              softWrap: true,
              style: TextStyle(),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.birthdayCake,
              color: Colors.black54,
            ),
            subtitle: user.dateofBirth != null
                ? Text(
                    '${user.dateofBirth.day} ${months[user.dateofBirth.month - 1]}, ${user.dateofBirth.year}',
                    softWrap: true,
                    style: TextStyle(),
                  )
                : Text(
                    'NA',
                    softWrap: true,
                    style: TextStyle(),
                  ),
            title: Text(
              'Date Of Birth',
              softWrap: true,
              style: TextStyle(),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.calendar,
              color: Colors.black54,
            ),
            subtitle: user.registerDate != null
                ? Text(
                    '${user.registerDate.day} ${months[user.registerDate.month - 1]}, ${user.registerDate.year}',
                    softWrap: true,
                    style: TextStyle(),
                  )
                : Text(
                    'NA',
                    softWrap: true,
                    style: TextStyle(),
                  ),
            title: Text(
              'Register Date',
              softWrap: true,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
