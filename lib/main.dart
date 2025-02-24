import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<String> futureHello;

  @override
  void initState() {
    super.initState();
    futureHello = fetchHello();
  }

  Future<String> fetchHello() async {
    final response = await http.get(Uri.parse('https://yeohaeng-ttukttak.com/api/v3/hello'));
    
    if (response.statusCode != 200) {
      throw Exception('Failed to connect server');
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('여행뚝딱'),
          ),
          body: Center(
            child: FutureBuilder(
                future: futureHello,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }),
          )),
    );
  }
}
