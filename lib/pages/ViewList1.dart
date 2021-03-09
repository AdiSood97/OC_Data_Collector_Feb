import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList2.dart';
import 'package:kapp/pages/editpage.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/appformcards.dart';
import '../widgets/appformcards.dart';
import '../widgets/appformcards.dart';
import 'editpage.dart';
class ViewList1 extends StatefulWidget {
  @override
  _ViewList1State createState() => _ViewList1State();
}

class _ViewList1State extends State<ViewList1> {
  LocalPropertySurvey localdata;
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }
  Widget wrapContaint({String titel, String subtitel}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(titel),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(
            subtitel,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  String getSubjectConflict(String id)
  {
    var result="";
    switch(id){
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_yes_sir');
        break;
      case "2":
        result = setapptext(key: 'key_no');
        break;
    }
    return result;
  }
  String getPersionId(String id)
  {
    var result="";
    switch(id){
      case "0":
        result =setapptext(key: 'key_none_selected');
        break;
      case "1":
        result =setapptext(key: 'key_present');
        break;
      case "2":
        result= setapptext(key: 'key_absence');
        break;
      case "3":
        result = setapptext(key: 'key_died');
        break;
    }
    return result;

  }
  Widget completedcheckbox({bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(
              color: isCompleted ? Colors.lightGreen : Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted ? Colors.lightGreen : Colors.black,
            ),
          ),
        ),
      ),
    );

  }
  Widget formheader({String headerlablekey}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(177, 201, 224, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            setapptext(key: headerlablekey),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: ViewPage2(
                  //localdata: localdata,
                ),
                type: PageTransitionType.rightToLeft));
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              setapptext(key: 'key_next'),
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: EditPage(
                  //localdata: localdata,
                ),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        padding: EdgeInsets.only(right: 250),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.arrow_back_ios, color: Colors.white),
            Text(
              setapptext(key: 'key_back'),
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
  String property="",person_id="",cityzenship_notice="";
  Future getData() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
   setState(() {
     property=preferences.get('property_dispte_subject_to');
     person_id=preferences.get('real_person_status');
     cityzenship_notice=preferences.get('cityzenship_notice');
     print("uewuiftfg+++++++++++++++++++++++++++++++");
     print(cityzenship_notice);
   });

  }
  @override
  void initState() {
    // TODO: implement initState
   getData();
  //localdata = new LocalPropertySurvey();
   //print("Property is=${localdata.real_person_status}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_property_survey'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
        body:SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formheader(headerlablekey: 'key_general_info1'),
               Expanded(
                   child: ListView(
                     children: [
                       Wrap(
                         runAlignment: WrapAlignment.spaceBetween,
                         runSpacing: 5,
                         spacing: 20,
                         children: <Widget>[
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                             child: Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Container(
                                   width: 400,
                                   //padding: EdgeInsets.only(left: 20),
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         textDirection: locator<LanguageService>().currentlanguage == 0
                                             ? TextDirection.ltr
                                             : TextDirection.rtl,
                                         children: <Widget>[
                                           completedcheckbox(isCompleted: true),
                                           Text(
                                             '*',
                                             style: TextStyle(color: Colors.red, fontSize: 18),
                                           ),
                                           Flexible(
                                             child: Container(
                                               child: Text(setapptext(key: 'key_property_disputes'),
                                                 overflow: TextOverflow.visible,
                                                 softWrap: true,
                                                 style: TextStyle(),
                                                 textDirection:
                                                 locator<LanguageService>().currentlanguage == 0
                                                     ? TextDirection.ltr
                                                     : TextDirection.rtl,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 5,),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 40),
                                         child: Text(getSubjectConflict(property ??''),style: TextStyle(fontSize: 20,color: Colors.black),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                         child: Divider(
                                           height: 2,
                                           color: Colors.grey,
                                         ),
                                       ),
                                       SizedBox(height: 10,)
                                     ],
                                   )
                               ),
                             ),
                           ),
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                             child: Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Container(
                                   width: 400,
                                   //padding: EdgeInsets.only(left: 20),
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         textDirection: locator<LanguageService>().currentlanguage == 0
                                             ? TextDirection.ltr
                                             : TextDirection.rtl,
                                         children: <Widget>[
                                           completedcheckbox(isCompleted: true),
                                           Text(
                                             '*',
                                             style: TextStyle(color: Colors.red, fontSize: 18),
                                           ),
                                           Flexible(
                                             child: Container(
                                               child: Text(setapptext(key: 'key_real_person'),
                                                 overflow: TextOverflow.visible,
                                                 softWrap: true,
                                                 style: TextStyle(),
                                                 textDirection:
                                                 locator<LanguageService>().currentlanguage == 0
                                                     ? TextDirection.ltr
                                                     : TextDirection.rtl,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 5,),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 40),
                                         child: Text(getPersionId(person_id),style: TextStyle(fontSize: 20,color: Colors.black),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                         child: Divider(
                                           height: 2,
                                           color: Colors.grey,
                                         ),
                                       ),
                                       SizedBox(height: 10,)
                                     ],
                                   )
                               ),
                             ),
                           ),
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                             child: Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Container(
                                   width: 400,
                                   //padding: EdgeInsets.only(left: 20),
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         textDirection: locator<LanguageService>().currentlanguage == 0
                                             ? TextDirection.ltr
                                             : TextDirection.rtl,
                                         children: <Widget>[
                                           completedcheckbox(isCompleted: true),
                                           Text(
                                             '*',
                                             style: TextStyle(color: Colors.red, fontSize: 18),
                                           ),
                                           Flexible(
                                             child: Container(
                                               child: Text(setapptext(key: 'key_is_citizenship'),
                                                 overflow: TextOverflow.visible,
                                                 softWrap: true,
                                                 style: TextStyle(),
                                                 textDirection:
                                                 locator<LanguageService>().currentlanguage == 0
                                                     ? TextDirection.ltr
                                                     : TextDirection.rtl,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 5,),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 40),
                                         child: Text(getSubjectConflict(cityzenship_notice),style: TextStyle(fontSize: 20,color: Colors.black),),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                         child: Divider(
                                           height: 2,
                                           color: Colors.grey,
                                         ),
                                       ),
                                       SizedBox(height: 10,)
                                     ],
                                   )
                               ),
                             ),
                           ),
                          // SizedBox(height: 100,),

                         ],
                       ),
                     ],
                   )),
                Container(
                  child: Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.blueAccent,
                      ),
                      Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //back button
                              SizedBox(),
                              //next button
                              backbutton(),
                              nextbutton()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
