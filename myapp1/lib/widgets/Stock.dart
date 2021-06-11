import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp1/models/StockModel.dart';
import 'package:http/http.dart' as http;
import 'package:myapp1/widgets/StockPage.dart';
import 'package:page_transition/page_transition.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  List<StockModel> stockModel = [];

  bool isStockLoaded = false;

  List<StockModel> tempstockModel = [];

  fetchStonks() async {
    var queryParameters = {'apikey': 'utyqe54xqnb7v5gju7x1'};
    var uri = Uri.parse(
        "https://dummy-wireframe.iecsemanipal.com/stocks?apikey=utyqe54xqnb7v5gju7x1");
    uri.replace(queryParameters: queryParameters);
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    var data = responseData['data'];
    // print(data);
    try {
      for (var d in data) {
        StockModel p = StockModel(
          id: d["_id"],
          symbol: d["Symbol"],
          assetType: d["AssetType"],
          name: d["Name"],
          description: d["Description"],
          cik: d["CIK"],
          exchanges: d["Exchange"],
          currency: d["Currency"],
          country: d["Country"],
          sector: d["Sector"],
          industry: d["Industry"],
          address: d["Address"],
          fullTimeEmployees: d["FullTimeEmployees"],
          fiscalYearEnd: d["FiscalYearEnd"],
          latestQuarter: d["LatestQuarter"],
          marketCapitalisation: d["MarketCapitalization"],
          ebitda: d["EBITDA"],
          peRatio: d["PERatio"],
          pegRatio: d["PEGRatio"],
          bookValue: d["BookValue"],
          dividendPerShare: d["DividendPerShare"],
          dividendYield: d["DividendYield"],
          eps: d["EPS"],
          revenuePerShareTTM: d["RevenuePerShareTTM"],
          profitMargin: d["ProfitMargin"],
          operatingMargin: d["OperatingMarginTTM"],
          returnOnAssetsTTM: d["ReturnOnAssetsTTM"],
          returnOnEquityTTM: d["ReturnOnEquityTTM"],
          revenueTTM: d["RevenueTTM"],
          grossProfitTTM: d["GrossProfitTTM"],
          dilutedEPSTTM: d["DilutedEPSTTM"],
          quarterlyEarningsGrowthYOY: d["QuarterlyEarningsGrowthYOY"],
          quarterlyRevenueGrowthYOY: d["QuarterlyRevenueGrowthYOY"],
          analystTargetPrice: d["AnalystTargetPrice"],
          trailingPE: d["TrailingPE"],
          forwardPE: d["ForwardPE"],
          priceToSalesRatioTTM: d["PriceToSalesRatioTTM"],
          priceToBookRatio: d["PriceToBookRatio"],
          eVToRevenue: d["EVToRevenue"],
          eVToEBITDA: d["EVToEBITDA"],
          beta: d["Beta"],
          sharesOutstanding: d["SharesOutstanding"],
          sharesFloat: d["SharesFloat"],
          sharesShort: d["SharesShort"],
          sharesShortPriorMonth: d["SharesShortPriorMonth"],
          shortRatio: d["ShortRatio"],
          shortPercentOutstanding: d["ShortPercentOutstanding"],
          shortPercentFloat: d["ShortPercentFloat"],
          percentInsiders: d["PercentInsiders"],
          percentInstitutions: d["PercentInstitutions"],
          forwardAnnualDividendRate: d["ForwardAnnualDividendRate"],
          forwardAnnualDividendYield: d["ForwardAnnualDividendYield"],
          payoutRatio: d["PayoutRatio"],
          dividendDate: d["DividendDate"],
          exDividendDate: d["ExDividendDate"],
          lastSplitFactor: d["LastSplitFactor"],
          lastSplitDate: d["LastSplitDate"],
        );
        // p.display();
        print(p);
        stockModel.add(p);
      }
      setState(() {
        isStockLoaded = true;
        tempstockModel = stockModel;
      });
      return stockModel;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStonks();
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
                  'Stocks',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ];
          },
          body: isStockLoaded
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
                            tempstockModel =
                                relevantResultsStocks(value, stockModel);
                            // print(tempuserModel);
                          });
                        },
                      ),
                    ),
                    ...tempstockModel.map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  PageTransition(
                                    child: StockPage(
                                      stockModel: e,
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
                                      '${e.name}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${e.assetType}',
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

  List<StockModel> relevantResultsStocks(searchTerm, List<StockModel> stocks) {
    if (searchTerm.length < 0) {
      return stocks;
    }

    return stocks
        .where((item) =>
            item.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
            item.assetType.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }
}
