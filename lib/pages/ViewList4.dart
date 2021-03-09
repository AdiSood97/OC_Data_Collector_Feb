import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList5.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList3.dart';
class ViewList4 extends StatefulWidget {
  @override
  _ViewList4State createState() => _ViewList4State();
}

class _ViewList4State extends State<ViewList4> {
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
  String getOwnerType(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_solo');
        break;
      case "2":
        result = setapptext(key: 'key_collective');
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
                child: ViewList5(
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
                child: ViewList3(
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
  String province="",city="",area="",pass="",block="",part_number="",unit_number="",unit_in_parcel="",street_name="",historic_site_area="",land_area="",property_type="";
  Future getData() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      province=preferences.get('province');
      city=preferences.get('city');
      area=preferences.get('area');
      pass=preferences.get('pass');
      block=preferences.get('block');
      part_number=preferences.get('part_number');
      unit_number=preferences.get('unit_number');
      unit_in_parcel=preferences.get('unit_in_parcel');
      street_name=preferences.get('street_name');
      historic_site_area=preferences.get('historic_site_area');
      land_area=preferences.get('land_area');
      property_type=preferences.get('property_type');

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
                formheader(headerlablekey: 'key_property_location'),
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
                                          completedcheckbox(isCompleted: getProvincename(province)==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_select_province'),
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
                                        child: Text(getProvincename(province),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: getCity(city)==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_select_city'),
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
                                        child: Text(getCity(city),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: area==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_area'),
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
                                        child: Text(area,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: pass==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_pass'),
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
                                        child: Text(pass,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: block==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_block'),
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
                                        child: Text(block,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: part_number==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_part_number'),
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
                                        child: Text(part_number,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: unit_number==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_unit_number'),
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
                                        child: Text(unit_number,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: unit_in_parcel==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_number_of_unit'),
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
                                        child: Text(unit_in_parcel,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: street_name==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_state_name'),
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
                                        child: Text(street_name,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: historic_site_area==''?false:true),
                                         /* Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_historycal_site'),
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
                                        child: Text(historic_site_area,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: land_area==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_land_area'),
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
                                        child: Text(land_area,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: getOwnerType(property_type)==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_type_ownership'),
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
                                        child: Text(getOwnerType(property_type),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          //SizedBox(height: 50,),

                        ],
                      ),
                    ],
                  ),
                ),
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
          ),)
    );
  }
}
