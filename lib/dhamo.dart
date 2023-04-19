// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signboard/models/get_signboard_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<GetSignboardModel> futureAlbum;
  List<GetSignboardModel> listModel = <GetSignboardModel>[];

  @override
  void initState() {
    super.initState();
    futureAlbum = getData();
  }

  Future<GetSignboardModel> getData() async {
    Dio dio = Dio();
    var parms = {"t": "4a995e079e213ec3f264bffb54c4c02d"};
    final responseData = await http.post(
        Uri.parse(
            "https://signboard.trsm.in/api/v1/v2/getsignboards?pageno=1&data_per_page=10&filters=0"),
        body: jsonEncode(parms));
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
    if (responseData.statusCode == 200) {
      print(responseData.statusCode.toString());
      final data = jsonDecode(responseData.body);
      print("data = ${data}");
      return GetSignboardModel.fromJson(data);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 2 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return
                        /*
                    Center(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            child: VimeoPlayer(
                              videoId: snapshot
                                  .data!.data![index].signboardImageId
                                  .toString(),
                            ),
                          ),
                        ],
                      ),
                    );
                    */
                        Image(
                            image: NetworkImage(snapshot
                                .data!.data![index].signboardImageId
                                .toString()));
                  },
                );
                // ListView.builder(
                //     itemCount: snapshot.data!.data!.length,
                //     itemBuilder: (BuildContext context, index) {
                // return Image(
                //     image: NetworkImage(snapshot
                //         .data!.data![index].signboardImageId
                //         .toString()));
                //       // Text(
                //       //   snapshot.data!.data![index].signboardImageId.toString(),
                //       // );
                //     });
              }
              return const Center(child: CircularProgressIndicator());
            })));
  }
}
