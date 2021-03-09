import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList4.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList2.dart';

class ViewList3 extends StatefulWidget {
  @override
  _ViewList3State createState() => _ViewList3State();
}

class _ViewList3State extends State<ViewList3> {
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
                child: ViewList4(
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
                child: ViewPage2(
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
  String getPropertyStatus(String id)
  {
    var result="";
    switch(id){
      case "0":
        result =setapptext(key: 'key_none_selected');
        break;
      case "1":
        result =setapptext(key: 'key_plan');
        break;
      case "2":
        result= setapptext(key: 'key_unplan');
        break;
    }
    return result;

  }
  String getPropertyRightStatus(String id)
  {
    var result="";
    switch(id){
      case "0":
        result =setapptext(key: 'key_none_selected');
        break;
      case "1":
        result =setapptext(key: 'key_official');
        break;
      case "2":
        result= setapptext(key: 'key_unofficial');
        break;
    }
    return result;

  }
  String getPropertyTypeStatus(String id)
  {
    var result="";
    switch(id){
      case "0":
        result =setapptext(key: 'key_none_selected');
        break;
      case "1":
        result =setapptext(key: 'key_regular');
        break;
      case "2":
        result= setapptext(key: 'key_Disorganized');
        break;
    }
    return result;

  }
  String getPropertySlopeStatus(String id)
  {
    var result="";
    switch(id){
      case "0":
        result =setapptext(key: 'key_none_selected');
        break;
      case "1":
        result =setapptext(key: 'key_Smooth');
        break;
      case "2":
        result= setapptext(key: 'key_slope_30');
        break;
      case "3":
        result =setapptext(key:'key_slope_above_30');
    }
    return result;

  }

  String status_of_area_plan="",status_of_area_official="",status_of_area_regular="",slope_of_area="";
  Future getData() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      status_of_area_plan=preferences.get('status_of_area_plan');
      status_of_area_official=preferences.get('status_of_area_official');
      status_of_area_regular=preferences.get('status_of_area_regular');
      slope_of_area=preferences.get('slope_of_area');

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
                formheader(headerlablekey: 'key_physical_state'),
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
                                            completedcheckbox(isCompleted: getPropertyStatus(status_of_area_plan)==''?false:true),
                                            Text(
                                              '*',
                                              style: TextStyle(color: Colors.red, fontSize: 18),
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Text(setapptext(key: 'key_specify_the'),
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
                                          child: Text(getPropertyStatus(status_of_area_plan),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                            completedcheckbox(isCompleted: getPropertyRightStatus(status_of_area_official)==''?false:true),
                                            Text(
                                              '*',
                                              style: TextStyle(color: Colors.red, fontSize: 18),
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Text(setapptext(key: 'key_Property_Rights'),
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
                                          child: Text(getPropertyRightStatus(status_of_area_official),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                            completedcheckbox(isCompleted: getPropertyTypeStatus(status_of_area_regular)==''?false:true),
                                            Text(
                                              '*',
                                              style: TextStyle(color: Colors.red, fontSize: 18),
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Text(setapptext(key: 'key_Property_Type'),
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
                                          child: Text(getPropertyTypeStatus(status_of_area_regular),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                            completedcheckbox(isCompleted: getPropertySlopeStatus(slope_of_area)==''?false:true),
                                            Text(
                                              '*',
                                              style: TextStyle(color: Colors.red, fontSize: 18),
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Text(setapptext(key: 'key_specify_slope'),
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
                                          child: Text(getPropertySlopeStatus(slope_of_area),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                           // SizedBox(height: 50,),

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
