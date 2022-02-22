import 'package:azkar1/models/section_detail_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../cubit/cubit.dart';

class SectionDetailScreen extends StatefulWidget {
  final int id;
  final String title;
  const SectionDetailScreen({Key? key , required this.id , required this.title}) : super(key: key);

  @override
  _SectionDetailScreenState createState() => _SectionDetailScreenState();
}

class _SectionDetailScreenState extends State<SectionDetailScreen> {

  List<SectionDetailModel> sectionDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSectionDetail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) {
              return Container(
                decoration: BoxDecoration(
                    color: AzkarCubit.get(context).isDarkMode ? Colors.white:Colors.brown[800],
                  boxShadow: [
                    BoxShadow(
                      color:Colors.grey.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0 , 3),
                    )
                  ]
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 40,
                          width: 40,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            // color: Colors.black,
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).accentColor,
                                Theme.of(context).primaryColor,
                              ]
                            ),

                          ),
                          child: Center(child: Text("${sectionDetails[index].count}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).canvasColor,
                          ),
                          )),
                        ),
                      ),
                      Spacer(),

                      Text("${sectionDetails[index].reference}", textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),

                    ],
                  ),
                  subtitle: Text("${sectionDetails[index].content}" , textDirection: TextDirection.rtl,style: TextStyle(
                    fontSize: 20 ,
                        color: AzkarCubit.get(context).isDarkMode ? Colors.grey[700] :Colors.grey[400] ,
                  ),),
                  // leading: Icon(Icons.ac_unit),
                ),
              );
            },
            separatorBuilder: (context , index) => Divider(height: 1,color: Colors.grey.withOpacity(.8),),
            itemCount: sectionDetails.length
        ),
      ),
    );
  }

  loadSectionDetail() async {
    sectionDetails = [];
    DefaultAssetBundle.of(context)
        .loadString("assets/database/section_details_db.json")
        .then((data) {
      var response = json.decode(data);
      response.forEach((section) {
        SectionDetailModel _sectionDetail = SectionDetailModel.fromJson(section);

        if(_sectionDetail.sectionId == widget.id) {
          sectionDetails.add(_sectionDetail);
        }

      });
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }

}
