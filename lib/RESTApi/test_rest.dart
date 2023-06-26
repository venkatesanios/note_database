import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_database/RESTApi/test_restmodel.dart';

class TestApi extends StatefulWidget {
  const TestApi({Key? key}) : super(key: key);

  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
    fetchData();
    print('init satte \n\n');
    Post post22 = Post();
    print(post22.title);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST API Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter REST API Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, abc) {
              if (abc.hasData) {
                return Text(abc.data?.title ?? '');
              } else if (abc.hasError) {
                return Text("${abc.error}");
              }

              // By default, it show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

void fetchData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    for (var i = 0; i < jsonResponse.length; i++) {
      //  print(jsonResponse);
      var latitude = jsonResponse[i]['address']['geo']['lat'];
      var longitude = jsonResponse[i]['address']['geo']['lng'];

      print('Latitude: $latitude');
      print('Longitude: $longitude');
    }

    var data = response.body;
    // print(data);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<Post> fetchPost() async {
  var url = Uri.parse(
      'http://3.1.62.165:8080/api/v1/controller/user/153/cluster'); // Replace with your API endpoint

  var response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}
