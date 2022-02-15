import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?format=json&key=9eb55aa5";

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dolar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Carregando dados ...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregar dados :(',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Reais',
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "R\$ ",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Dólares',
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "US\$ ",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Euros',
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "€ ",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
