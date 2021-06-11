import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp1/models/GovModel.dart';
import 'package:myapp1/widgets/InstitutionPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class Institution extends StatefulWidget {
  const Institution({Key? key}) : super(key: key);

  @override
  _InstitutionState createState() => _InstitutionState();
}

class _InstitutionState extends State<Institution> {
  List<GovModel> govModel = [];

  bool isGovLoaded = false;

  List<GovModel> tempgovsModel = [];
  fetchGovs() async {
    // var queryParameters = {'apikey': 'utyqe54xqnb7v5gju7x1'};
    var uri = Uri.parse(
        "https://dummy-wireframe.iecsemanipal.com/institutions?apikey=utyqe54xqnb7v5gju7x1");
    // uri.replace(queryParameters: queryParameters);
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    var data = responseData['data'];
    try {
      for (var d in data) {
        GovModel p = GovModel(
            areaName: d['area_name'],
            id: d['_id'],
            type: d['type'],
            value: d['value'],
            variable: d['variable'],
            year: d['year']);
        // p.display();
        govModel.add(p);
      }
      setState(() {
        isGovLoaded = true;
        tempgovsModel = govModel;
      });
      return govModel;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGovs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
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
                  'Institution',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ];
          },
          body: isGovLoaded == true
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
                            tempgovsModel =
                                relevantResultsGovs(value, govModel);
                            // (tempuserModel);
                          });
                        },
                      ),
                    ),
                    ...tempgovsModel.map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  PageTransition(
                                    child: InstitutionPage(
                                      govModel: e,
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
                                  ListTile(
                                    title: Text(
                                      '${e.areaName}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${e.type}',
                                      style: TextStyle(),
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
                        )),
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

  List<GovModel> relevantResultsGovs(searchTerm, List<GovModel> govs) {
    if (searchTerm.length < 0) {
      return govs;
    }

    return govs
        .where((item) =>
            item.areaName.toLowerCase().contains(searchTerm.toLowerCase()) ||
            item.type.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }
}
