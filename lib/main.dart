import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:apiproject/userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserData> userList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    var client = http.Client();
    var url = "https://dhasagam.com/api/allBusinesses";
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    
    Map<String, dynamic> uMap = jsonDecode(response.body);
    if (uMap["status"]) {
      List<dynamic> uList = uMap["data"];

      for (int i = 0; i < uList.length; i++) {
        Map<String, dynamic> userMap = uList[i];
        UserData userData = UserData.fromJson(userMap);
        userList.add(userData);
      }
      setState(() {

      });
    }
  }
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.brown.shade100,
                child: const Text("Bussiness",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Expanded(child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _containerData(index);
                  }
              ))
            ],
          )
        ));
  }
  Widget _containerData(int index){
    UserData userData = userList[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown.shade100,
          border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Column(
        children: [
          CarouselSlider(

            items: [ListView.builder(
              scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: userData.image.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.network(userData.image[index]),
                      ));
                }
            )],

            carouselController: buttonCarouselController,
            options: CarouselOptions(
              aspectRatio: 16/9,
              viewportFraction: 1,
              initialPage: 5,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Icon(Icons.account_balance_rounded,color: Colors.red[900],),
                const SizedBox(width: 10,),
                Expanded(child: _commonWidget(text: userData.businessName.toUpperCase())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                 Icon(Icons.person,color: Colors.red[900]),
                const SizedBox(width: 10,),
                Expanded(child: _commonWidget(text: userData.ownerName)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                 Icon(Icons.add_ic_call_sharp,color: Colors.red[900]),
                const SizedBox(width: 10,),
                Expanded(child: _commonWidget(text: userData.mobileNo)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Icon(Icons.location_on_sharp,color: Colors.red[900]),
                const SizedBox(width: 10,),
                Expanded(child: _commonWidget(text: userData.address)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _commonWidget({String? text}){
    return Text(text!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.black),);

  }

}
