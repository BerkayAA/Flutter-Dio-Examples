import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_response_mode.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late APIResponseModel apiResponseModel;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text("Networking Example"),
          ),
          body: Container(child: Center(child: buildDataWidget())),
          floatingActionButton: FloatingActionButton(
            child: isLoading
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
                : Icon(Icons.cloud_download),
            tooltip: "Get Data from API",
            onPressed: () => getDataFromAPI(),
          ),
        )));
  }

  void getDataFromAPI() async {
    setState(() {
      isLoading = true;
    });

    // post isteği oluşturmak istediğimde
    //* string url'yi parse edip bu url'den bir post isteği göndermek gerekli
    //* post içinde göndermek istediğimiz data'nın olmasını söylemeye gerek yok heralde
    Uri myUrl = Uri.parse('hhtps://google.com');
    var response = await http.post(myUrl, body: {'hello world': 'hello world'});

    // client oluşturarak api'ye istek atmak istersek

    var client = http.Client();

    try {
      Uri url = Uri.parse('http:/google.com');
      http.Response responseClient =
          await http.post(url, body: {'something': 'new'});

      var decodedResponse =
          jsonDecode(utf8.decode(responseClient.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    } catch (e) {
      print('something went wrong ');
    } finally {
      client.close();
    }

    // Bu yöntemde tek seferlik bir bağlantı açılır ve otomatik olarak kapatılır
    const String API_URL = "https://corona.lmao.ninja/v2/all";
    var response21 = await http.get(Uri.parse(API_URL));
    var parsedJson = await json.decode(response.body);

    // Map data = await jsonDecode(response.body);
    // print(data);
    // print(data['name']);
    setState(() {
      apiResponseModel = APIResponseModel.fromJson(parsedJson);
      isLoading = false;
    });
  }

  buildDataWidget() {
    if (apiResponseModel == null)
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Press the floating action button to get data",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      );
    else {
      return Text(
        "Total Cases : ${apiResponseModel.cases}\n"
        "Today's Cases : ${apiResponseModel.todayCases}\n"
        "Total Deaths : ${apiResponseModel.deaths}\n"
        "Today's Deaths : ${apiResponseModel.todayDeaths}\n"
        "Total Recovered : ${apiResponseModel.recovered}\n"
        "Active Cases : ${apiResponseModel.active}\n"
        "Critical Cases : ${apiResponseModel.critical}\n"
        "Cases per million: ${apiResponseModel.casesPerOneMillion}\n"
        "Deaths per million: ${apiResponseModel.deathsPerOneMillion}\n"
        "Total Tests Done: ${apiResponseModel.tests}\n"
        "Tests per million: ${apiResponseModel.testsPerOneMillion}\n"
        "Affected countires : ${apiResponseModel.affectedCountries}\n",
        style: TextStyle(fontSize: 18),
      );
    }
  }
}
