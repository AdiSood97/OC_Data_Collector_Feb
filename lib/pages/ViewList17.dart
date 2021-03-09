import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/surveyor_list.dart';
import 'package:kapp/utils/backgroundfetch.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList16.dart';
class ViewList17 extends StatefulWidget {
  @override
  _ViewList17State createState() => _ViewList17State();
}

class _ViewList17State extends State<ViewList17> {
  LocalPropertySurvey localdata= LocalPropertySurvey();
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
  String getProvincename(String id) {
    var result = "";
    switch (id) {
      case "01-01":
        result = setapptext(key: 'key_kabul');
        break;
      case "06-01":
        result = setapptext(key: 'key_nangarhar');
        break;
      case "33-01":
        result = setapptext(key: 'key_Kandahar');
        break;
      case "10-01":
        result = setapptext(key: 'key_Bamyan');
        break;
      case "22-01":
        result = setapptext(key: 'key_Daikundi');
        break;
      case "17-01":
        result = setapptext(key: 'key_Kundoz');
        break;
      case "18-01":
        result = setapptext(key: 'key_Balkh');
        break;
      case "30-01":
        result = setapptext(key: 'key_Herat');
        break;
      case "03-01":
        result = setapptext(key: 'key_Parwan');
        break;
      case "04-01":
        result = setapptext(key: 'key_Farah');
        break;
      default:
        result = id;
    }
    return result;
  }
  String getCity(String id) {
    var result = "";
    switch (id) {
      case "1":
        result = setapptext(key: 'key_kabul');
        break;
      case "2":
        result = setapptext(key: 'key_Jalalabad');
        break;
      case "3":
        result = setapptext(key: 'key_Kandahar');
        break;
      case "4":
        result = setapptext(key: 'key_Bamyan');
        break;
      case "5":
        result = setapptext(key: 'key_Nili');
        break;
      case "6":
        result = setapptext(key: 'key_Kundoz');
        break;
      case "7":
        result = setapptext(key: 'key_Sharif');
        break;
      case "8":
        result = setapptext(key: 'key_Herat');
        break;
      case "9":
        result = setapptext(key: 'key_Charikar');
        break;
      case "10":
        result = setapptext(key: 'key_Farah');
        break;
      default:
        result = id;
    }
    return result;
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
  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: ViewList16(
                  //localdata: localdata,
                ),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        //padding: EdgeInsets.only(right: 250),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
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
  String area_unit_release_area="",area_unit_business_area="",area_unit_total_no_unit="",area_unit_business_units="";
  Future getData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      area_unit_release_area=preferences.getString('area_unit_release_area');
      area_unit_business_area=preferences.getString('area_unit_business_area');
      area_unit_total_no_unit=preferences.getString('area_unit_total_no_unit');
      area_unit_business_units=preferences.getString('area_unit_business_units');

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                  formheader(headerlablekey: 'key_final_details'),
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
                                              completedcheckbox(isCompleted: (area_unit_release_area??"")==""?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_release_area'),
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
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(area_unit_release_area,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (area_unit_business_area??"")==""?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_business_area'),
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
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(area_unit_business_area,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (area_unit_total_no_unit??"")==""?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_total_release_units'),
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
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(area_unit_total_no_unit,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (area_unit_business_units??"")==""?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_total_business_unit'),
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
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(area_unit_business_units,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              localdata.isdrafted == 2
                                  ? SizedBox()
                                  : GestureDetector(
                                onTap: () async {
                                  print(
                                      "final data submit ===============${localdata.taskid},${localdata.senond_surveyor_name}");
                                 // localdata.isdrafted = 1;
                                 // localdata.surveyenddate =
                                    //  DateTime.now().toString();
                                  //updatePhotoStatus();
                                  /*await DBHelper()
                                      .updatePropertySurvey(localdata,
                                      localdata.local_property_key)
                                      .then((_) {
                                    DBHelper().updateTaskCompleteStatus(
                                        taskid: localdata.taskid);
                                  });*/
                                 // await BackGroundSync().startSync();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyoerList(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5.0,
                                              color: Colors.black)
                                        ],
                                        color: Colors.blue),
                                    margin: EdgeInsets.only(
                                      left: MediaQuery.of(context)
                                          .size
                                          .width /
                                          5,
                                      right: MediaQuery.of(context)
                                          .size
                                          .width /
                                          5,
                                    ),
                                    child: Center(
                                      child: Text(
                                        setapptext(key: 'key_submit'),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //SizedBox(height: 50,),
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
                              MainAxisAlignment.start,
                              children: <Widget>[
                                //back button
                                SizedBox(),
                                //next button
                                backbutton(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        )
    );
  }
}
