import 'package:flutter/material.dart';
import '../models/UserModel.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'UserPage.dart';
import 'package:page_transition/page_transition.dart';

class User extends StatefulWidget {
  final UserModel user;
  User({required this.user});
  @override
  _UserState createState() => _UserState(user);
}

class _UserState extends State<User> {
  UserModel user;
  _UserState(this.user);

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
                child: UserPage(
                  user: user,
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
                user.picture,
                width: double.infinity,
                height: 200,
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
    ));
  }
}
