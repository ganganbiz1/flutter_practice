import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CatApiApp extends StatelessWidget {
  const CatApiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CatApiPage(),
    );
  }
}

class CatApiPage extends StatefulWidget {
  const CatApiPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CatApiPageState createState() => _CatApiPageState();
}

class _CatApiPageState extends State<CatApiPage> {
  late Future<Response> data;

  @override
  void initState() {
    data = http.get(Uri.parse('https://aws.random.cat/meow'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Hello Cats',
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: data,
          builder: (context, AsyncSnapshot<Response?> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                height: 300,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            } else {
              final response = snapshot.data;
              final url = jsonDecode(response!.body)['file'];
              return Container(
                child: GestureDetector(
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                          child: Image.network(
                            url,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                          child: Text(
                            'Hello World',
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {
                              setState(() {
                                data = http.get(
                                    Uri.parse('https://aws.random.cat/meow'));
                              });
                            },
                            child: const Text('PUSH !!'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
