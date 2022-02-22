import 'package:azkar1/cubit/cubit.dart';
import 'package:azkar1/models/section_model.dart';
import 'package:azkar1/screens/section_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SectionModel> sections = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.6),
                      Colors.black.withOpacity(.3),
                    ]
                )
            ),
            child: Center(child:
            Text("أذكار المسلم")
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async{

                AzkarCubit.get(context).changeMode();

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.brightness_4_outlined,
                size: 30,

              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12.0, right: 12.0,bottom: 12.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildSectionItem(model: sections[index]),
          itemCount: sections.length,
        ),
      ),
    );
  }

  Widget buildSectionItem({required SectionModel model}) {
    return InkWell(
      onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => SectionDetailScreen(id: model.id!,title: model.name!,)));
      },
      child: Container(
        margin: const EdgeInsets.all( 5.0),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            gradient:LinearGradient(

                begin: Alignment.bottomRight,

                colors: [
                  Theme.of(context).accentColor,

                  Theme.of(context).primaryColor,

                ])),
        child: Center(
            child: Text(
          "${model.name}",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
        )),
      ),
    );
  }

  loadSections() async {
    DefaultAssetBundle.of(context)
        .loadString("assets/database/sections_db.json")
        .then((data) {
      var response = json.decode(data);
      response.forEach((section) {
        SectionModel _section = SectionModel.fromJson(section);
        sections.add(_section);
      });
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }
}
