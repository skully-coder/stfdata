import 'package:flutter/material.dart';
import 'package:myapp1/models/GovModel.dart';

class InstitutionPage extends StatefulWidget {
  final GovModel govModel;
  InstitutionPage({required this.govModel});

  @override
  _InstitutionPageState createState() =>
      _InstitutionPageState(govModel: govModel);
}

class _InstitutionPageState extends State<InstitutionPage> {
  final GovModel govModel;
  _InstitutionPageState({required this.govModel});
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
                'Institution',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  govModel.areaName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  govModel.type,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Variable',
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${govModel.variable}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Year',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${govModel.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Value',
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${govModel.value}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
