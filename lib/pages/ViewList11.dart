import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList12.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:kapp/widgets/appformcards.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';


import 'ViewList10.dart';
class ViewList11 extends StatefulWidget {
  @override
  _ViewList11State createState() => _ViewList11State();
}

class _ViewList11State extends State<ViewList11> {
  LocalPropertySurvey localdata= LocalPropertySurvey();
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }
  TextEditingController _regno;
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
  String getGender(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_male');
        break;
      case "2":
        result = setapptext(key: 'key_female');
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
  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: ViewList12(
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
                child: ViewList10(
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
  String second_partner_name="",second_partner_surname="",second_partner_boy="",second_partner_father="",second_partner_gender="",second_partner_phone="",second_partner_email="",
      second_partner_cover_note = '', second_partner_image = '', second_partner_machinegun_no = '', second_partner_note_page='', second_partner_reg_no='',second_partner_phote_note1='', second_partner_photo_tips1='', second_partner_photo_tips2 = '';
  String third_partner_name="",third_partner_surname="",third_partner_boy="",third_partner_father="",third_partner_gender="",third_partner_phone="",third_partner_email="",
      third_partner_cover_note = '', third_partner_image = '', third_partner_machinegun_no = '', third_partner_note_page='', third_partner_reg_no='',third_partner_phote_note1='', third_partner_photo_tips1='', third_partner_photo_tips2 = '';
  String fourth_partner_name="",fourth_partner_surname="",fourth_partner_boy="",fourth_partner_father="",fourth_partner_gender="",fourth_partner_phone="",fourth_partner_email="",
      fourth_partner_cover_note = '', fourth_partner_image = '', fourth_partner_machinegun_no = '', fourth_partner_note_page='', fourth_partner_reg_no='',fourth_partner_phote_note1='', fourth_partner_photo_tips1='', fourth_partner_photo_tips2 = '';
  String fifth_partner_name="",fifth_partner_surname="",fifth_partner_boy="",fifth_partner_father="",fifth_partner_gender="",fifth_partner_phone="",fifth_partner_email="",
      fifth_partner_cover_note = '', fifth_partner_image = '', fifth_partner_machinegun_no = '', fifth_partner_note_page='', fifth_partner_reg_no='',fifth_partner_phote_note1='', fifth_partner_photo_tips1='', fifth_partner_photo_tips2 = '';



  Future getData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      second_partner_name=preferences.getString('second_partner_name');
      second_partner_surname=preferences.getString('second_partner_surname');
      second_partner_boy=preferences.getString('second_partner_boy');
      second_partner_father=preferences.getString('second_partner_father');
      second_partner_gender=preferences.getString('second_partner_gender');
      second_partner_phone=preferences.getString('second_partner_phone');
      second_partner_phote_note1=preferences.getString('second_partner_phote_note1')??'';
      second_partner_cover_note=preferences.getString('second_partner_cover_note')??'';
      second_partner_image=preferences.getString('second_partner_image')??'';
      second_partner_machinegun_no=preferences.getString('second_partner_machinegun_no')??'';
      second_partner_note_page=preferences.getString('second_partner_note_page')??'';
      second_partner_reg_no=preferences.getString('second_partner_reg_no')??'';
      second_partner_photo_tips1=preferences.getString('second_partner_photo_tips1')??'';
      second_partner_photo_tips2=preferences.getString('second_partner_photo_tips2')??'';
      second_partner_email=preferences.getString('second_partner_email');

      third_partner_name=preferences.getString('third_partner_name');
      third_partner_surname=preferences.getString('third_partner_surname');
      third_partner_boy=preferences.getString('third_partner_boy');
      third_partner_father=preferences.getString('third_partner_father');
      third_partner_gender=preferences.getString('third_partner_gender');
      third_partner_phone=preferences.getString('third_partner_phone');
      third_partner_phote_note1=preferences.getString('third_partner_phote_note1')??'';
      third_partner_cover_note=preferences.getString('third_partner_cover_note')??'';
      third_partner_image=preferences.getString('third_partner_image')??'';
      third_partner_machinegun_no=preferences.getString('third_partner_machinegun_no')??'';
      third_partner_note_page=preferences.getString('third_partner_note_page')??'';
      third_partner_reg_no=preferences.getString('third_partner_reg_no')??'';
      third_partner_photo_tips1=preferences.getString('third_partner_photo_tips1')??'';
      third_partner_photo_tips2=preferences.getString('third_partner_photo_tips2')??'';
      third_partner_email=preferences.getString('third_partner_email');

      fourth_partner_name=preferences.getString('fourth_partner_name');
      fourth_partner_surname=preferences.getString('fourth_partner_surname');
      fourth_partner_boy=preferences.getString('fourth_partner_boy');
      fourth_partner_father=preferences.getString('fourth_partner_father');
      fourth_partner_gender=preferences.getString('fourth_partner_gender');
      fourth_partner_phone=preferences.getString('fourth_partner_phone');
      fourth_partner_phote_note1=preferences.getString('fourth_partner_phote_note1')??'';
      fourth_partner_cover_note=preferences.getString('fourth_partner_cover_note')??'';
      fourth_partner_image=preferences.getString('fourth_partner_image')??'';
      fourth_partner_machinegun_no=preferences.getString('fourth_partner_machinegun_no')??'';
      fourth_partner_note_page=preferences.getString('fourth_partner_note_page')??'';
      fourth_partner_reg_no=preferences.getString('fourth_partner_reg_no')??'';
      fourth_partner_photo_tips1=preferences.getString('fourth_partner_photo_tips1')??'';
      fourth_partner_photo_tips2=preferences.getString('fourth_partner_photo_tips2')??'';
      fourth_partner_email=preferences.getString('fourth_partner_email');

      fifth_partner_name=preferences.getString('fifth_partner_name');
      fifth_partner_surname=preferences.getString('fifth_partner_surname');
      fifth_partner_boy=preferences.getString('fifth_partner_boy');
      fifth_partner_father=preferences.getString('fifth_partner_father');
      fifth_partner_gender=preferences.getString('fifth_partner_gender');
      fifth_partner_phone=preferences.getString('fifth_partner_phone');
      fifth_partner_phote_note1=preferences.getString('fifth_partner_phote_note1')??'';
      fifth_partner_cover_note=preferences.getString('fifth_partner_cover_note')??'';
      fifth_partner_image=preferences.getString('fifth_partner_image')??'';
      fifth_partner_machinegun_no=preferences.getString('fifth_partner_machinegun_no')??'';
      fifth_partner_note_page=preferences.getString('fifth_partner_note_page')??'';
      fifth_partner_reg_no=preferences.getString('fifth_partner_reg_no')??'';
      fifth_partner_photo_tips1=preferences.getString('fifth_partner_photo_tips1')??'';
      fifth_partner_photo_tips2=preferences.getString('fifth_partner_photo_tips2')??'';
      fifth_partner_email=preferences.getString('fifth_partner_email');



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
                  formheader(headerlablekey: 'key_Characteristics_of_earth'),
                  Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                setapptext(key: 'key_second_partner_info'),
                              ),
                            ),
                          ),
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
                                              completedcheckbox(isCompleted: (second_partner_name ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_name'),
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
                                            child: Text(second_partner_name ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_surname ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_surname'),
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
                                            child: Text(second_partner_surname ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_boy ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_wold'),
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
                                            child: Text(second_partner_boy ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_father ?? "") ==''?false:true),
                                             /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_birth'),
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
                                            child: Text(second_partner_father ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (getGender(second_partner_gender) ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_gender'),
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
                                            child: Text(getGender(second_partner_gender) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_phone?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_phone'),
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
                                            child: Text(second_partner_phone?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_email?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_email'),
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
                                            child: Text(second_partner_email?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: second_partner_image==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_second_partner_photo'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_image= await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_image = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: localdata
                                                  .info_photo_hint_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(second_partner_image)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(second_partner_image),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
                                              completedcheckbox(isCompleted: (second_partner_machinegun_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_machine_gun'),
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
                                            child: Text(second_partner_machinegun_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_cover_note?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_cover_letter'),
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
                                            child: Text(second_partner_cover_note?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_note_page?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_notification_page'),
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
                                            child: Text(second_partner_note_page?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (second_partner_reg_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_reg_no'),
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
                                            child: Text(second_partner_reg_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: second_partner_phote_note1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child:second_partner_phote_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(second_partner_phote_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(second_partner_phote_note1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: second_partner_photo_tips1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: second_partner_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(second_partner_photo_tips1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(second_partner_photo_tips1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: second_partner_photo_tips2==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.second_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: second_partner_photo_tips2
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(second_partner_photo_tips2)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(second_partner_photo_tips2),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ), ///Second Partner
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                setapptext(key: 'key_third_partner_info'),
                              ),
                            ),
                          ),
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
                                              completedcheckbox(isCompleted: (third_partner_name ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_name'),
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
                                            child: Text(third_partner_name ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_surname ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_surname'),
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
                                            child: Text(third_partner_surname ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_boy ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_wold'),
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
                                            child: Text(third_partner_boy ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_father ?? "") ==''?false:true),
                                              /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_birth'),
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
                                            child: Text(third_partner_father ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (getGender(third_partner_gender) ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_gender'),
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
                                            child: Text(getGender(third_partner_gender) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_phone?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_phone'),
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
                                            child: Text(third_partner_phone?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_email?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_email'),
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
                                            child: Text(third_partner_email?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: third_partner_image==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_third_partner_photo'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_image= await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_image = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: localdata
                                                  .info_photo_hint_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(third_partner_image)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(third_partner_image),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
                                              completedcheckbox(isCompleted: (third_partner_machinegun_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_machine_gun'),
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
                                            child: Text(third_partner_machinegun_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_cover_note?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_cover_letter'),
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
                                            child: Text(third_partner_cover_note?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_note_page?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_notification_page'),
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
                                            child: Text(third_partner_note_page?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (third_partner_reg_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_reg_no'),
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
                                            child: Text(third_partner_reg_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: third_partner_phote_note1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child:third_partner_phote_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(third_partner_phote_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(third_partner_phote_note1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: third_partner_photo_tips1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: third_partner_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(third_partner_photo_tips1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(third_partner_photo_tips1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: third_partner_photo_tips2==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.third_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: third_partner_photo_tips2
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(third_partner_photo_tips2)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(third_partner_photo_tips2),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),///Third Partner
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                setapptext(key: 'key_fourth_partner_info'),
                              ),
                            ),
                          ),
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
                                              completedcheckbox(isCompleted: (fourth_partner_name ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_name'),
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
                                            child: Text(fourth_partner_name ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_surname ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_surname'),
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
                                            child: Text(fourth_partner_surname ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_boy ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_wold'),
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
                                            child: Text(fourth_partner_boy ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_father ?? "") ==''?false:true),
                                              /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_birth'),
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
                                            child: Text(fourth_partner_father ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (getGender(fourth_partner_gender) ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_gender'),
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
                                            child: Text(getGender(fourth_partner_gender) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_phone?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_phone'),
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
                                            child: Text(fourth_partner_phone?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_email?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_email'),
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
                                            child: Text(fourth_partner_email?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fourth_partner_image==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_fourth_partner_photo'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_image= await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_image = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: localdata
                                                  .info_photo_hint_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fourth_partner_image)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fourth_partner_image),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
                                              completedcheckbox(isCompleted: (fourth_partner_machinegun_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_machine_gun'),
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
                                            child: Text(fourth_partner_machinegun_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_cover_note?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_cover_letter'),
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
                                            child: Text(fourth_partner_cover_note?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_note_page?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_notification_page'),
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
                                            child: Text(fourth_partner_note_page?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fourth_partner_reg_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_reg_no'),
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
                                            child: Text(fourth_partner_reg_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fourth_partner_phote_note1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child:fourth_partner_phote_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fourth_partner_phote_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fourth_partner_phote_note1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fourth_partner_photo_tips1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: fourth_partner_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fourth_partner_photo_tips1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fourth_partner_photo_tips1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fourth_partner_photo_tips2==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fourth_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: fourth_partner_photo_tips2
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fourth_partner_photo_tips2)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fourth_partner_photo_tips2),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ), ///Fourth Partner
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                setapptext(key: 'key_fifth_partner_info'),
                              ),
                            ),
                          ),
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
                                              completedcheckbox(isCompleted: (fifth_partner_name ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_name'),
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
                                            child: Text(fifth_partner_name ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_surname ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_surname'),
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
                                            child: Text(fifth_partner_surname ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_boy ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_wold'),
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
                                            child: Text(fifth_partner_boy ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_father ?? "") ==''?false:true),
                                              /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_birth'),
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
                                            child: Text(fifth_partner_father ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (getGender(fifth_partner_gender) ?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_gender'),
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
                                            child: Text(getGender(fifth_partner_gender) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_phone?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_phone'),
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
                                            child: Text(fifth_partner_phone?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_email?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_email'),
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
                                            child: Text(fifth_partner_email?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fifth_partner_image==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_fifth_partner_photo'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_image= await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_image = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: localdata
                                                  .info_photo_hint_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fifth_partner_image)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fifth_partner_image),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
                                              completedcheckbox(isCompleted: (fifth_partner_machinegun_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_machine_gun'),
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
                                            child: Text(fifth_partner_machinegun_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_cover_note?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_cover_letter'),
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
                                            child: Text(fifth_partner_cover_note?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_note_page?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_notification_page'),
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
                                            child: Text(fifth_partner_note_page?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fifth_partner_reg_no?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_reg_no'),
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
                                            child: Text(fifth_partner_reg_no?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fifth_partner_phote_note1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child:fifth_partner_phote_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fifth_partner_phote_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fifth_partner_phote_note1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fifth_partner_photo_tips1==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: fifth_partner_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fifth_partner_photo_tips1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fifth_partner_photo_tips1),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: fifth_partner_photo_tips2==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_capture_image')),
                                                  onPressed:
                                                  localdata.isdrafted == 2
                                                      ? null
                                                      : () async {
                                                    showModalBottomSheet(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Container(
                                                            child:
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding:
                                                                  EdgeInsets.all(8),
                                                                  //decoration: BoxDecoration(color: Colors.blue),
                                                                  child:
                                                                  Text(
                                                                    "Pick the image",
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Camera",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    localdata.fifth_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    "Use Gallery",
                                                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 8),
                                          child: Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: fifth_partner_photo_tips2
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(fifth_partner_photo_tips2)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(fifth_partner_photo_tips2),
                                              )
                                                  : Center(
                                                child: Text(setapptext(
                                                    key:
                                                    'key_no_image')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),///fifth Partner


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
              )),
        )
    );
  }
}
