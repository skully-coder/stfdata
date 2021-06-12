import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/StockModel.dart';
import 'package:http/http.dart' as http;

class StockPage extends StatefulWidget {
  final StockModel stockModel;
  StockPage({required this.stockModel});
  @override
  _StockPageState createState() => _StockPageState(stockModel: stockModel);
}

class _StockPageState extends State<StockPage> {
  var parameters = [
    "Symbol",
    "AssetType",
    "CIK",
    "Exchange",
    "Currency",
    "Country",
    "Sector",
    "Industry",
    "Address",
    "FullTimeEmployees",
    "FiscalYearEnd",
    "LatestQuarter",
    "MarketCapitalization",
    "EBITDA",
    "PERatio",
    "PEGRatio",
    "BookValue",
    "DividendPerShare",
    "DividendYield",
    "EPS",
    "RevenuePerShareTTM",
    "ProfitMargin",
    "OperatingMarginTTM",
    "ReturnOnAssetsTTM",
    "ReturnOnEquityTTM",
    "RevenueTTM",
    "GrossProfitTTM",
    "DilutedEPSTTM",
    "QuarterlyEarningsGrowthYOY",
    "QuarterlyRevenueGrowthYOY",
    "AnalystTargetPrice",
    "TrailingPE",
    "ForwardPE",
    "PriceToSalesRatioTTM",
    "PriceToBookRatio",
    "EVToRevenue",
    "EVToEBITDA",
    "Beta",
    "SharesOutstanding",
    "SharesFloat",
    "SharesShort",
    "SharesShortPriorMonth",
    "ShortRatio",
    "ShortPercentOutstanding",
    "ShortPercentFloat",
    "PercentInsiders",
    "PercentInstitutions",
    "ForwardAnnualDividendRate",
    "ForwardAnnualDividendYield",
    "PayoutRatio",
    "DividendDate",
    "ExDividendDate",
    "LastSplitFactor",
    "LastSplitDate",
  ];
  StockModel stockModel;
  var d;
  _StockPageState({required this.stockModel});
  @override
  void initState() {
    super.initState();
    fetchStonks(stockModel.id);
  }

  bool isStockFetched = false;
  fetchStonks(stockId) async {
    var url =
        "https://dummy-wireframe.iecsemanipal.com/stock/$stockId?apikey=utyqe54xqnb7v5gju7x1";

    var uri = Uri.parse(url);

    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    d = responseData['data'];
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
    setState(() {
      stockModel = p;
      isStockFetched = true;
    });
    return stockModel;
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
                // color: DataHolder.of(context).theme.homepageAppBarBottomBorder,
              ),
            ),
            elevation: 20.0,
            title: Text(
              '${stockModel.name}',
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ];
      },
      body: isStockFetched == true
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                  child: Text(
                    stockModel.name,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.030,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    stockModel.description,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                ),
                ...parameters.map(
                  (e) => ListTile(
                    title: Text(
                      '$e',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '${d[e]}',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
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
