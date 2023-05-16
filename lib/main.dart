import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          var dt = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023, 3, 2),
              lastDate: DateTime(2023, 12, 31));
          String date = dt.toString().split(' ')[0].replaceAll('-', '');
          //2023-01-01 0:00:00 -> 2023-01-01 -> 20230101
          String site =
              'https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530167&MLSV_YMD=$date';
          var response = await http.get(Uri.parse(site));
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            print(data['mealServiceDietInfo'][1]['row'][0]['DDISH_NM']);
          } else {
            print('error');
          }
        },
        icon: Icon(Icons.add),
      ),
    );
  }
}
