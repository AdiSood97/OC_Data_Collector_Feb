import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList7.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList5.dart';
class ViewList6 extends StatefulWidget {
  @override
  _ViewList6State createState() => _ViewList6State();
}
class _ViewList6State extends State<ViewList6> {
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
  String getDocumentType(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_religious');
        break;
      case "2":
        result = setapptext(key: 'key_customary');
        break;
      case "3":
        result = setapptext(key: 'key_official_decree');
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
                child: ViewList7(
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
                child: ViewList5(
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
  String tempval = "";
  String document_type="",issued_on="",place_of_issue="",property_number="",document_cover="",document_page="",doc_reg_number="",land_area_qawwala="",property_doc_photo_1="",property_doc_photo_2="",property_doc_photo_3="",property_doc_photo_4="";
  TextEditingController _proareaowner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Future getData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      document_type=preferences.getString('document_type');
      print("DocumentTYpe is=${document_type}");
      issued_on=preferences.getString('issued_on');
      place_of_issue=preferences.getString('place_of_issue');
      property_number=preferences.getString('property_number');
      document_cover=preferences.getString('document_cover');
      document_page=preferences.getString('document_page');
      doc_reg_number=preferences.getString('doc_reg_number');
      land_area_qawwala=preferences.getString('land_area_qawwala');
      property_doc_photo_1=preferences.getString('property_doc_photo_1');
      print('Photo 1 address: ${property_doc_photo_1??""}');
      //print('Photo 1 address via localdata: ${localdata.property_doc_photo_1??""}');
      property_doc_photo_2=preferences.getString('property_doc_photo_2');
      property_doc_photo_3=preferences.getString('property_doc_photo_3');
      property_doc_photo_4=preferences.getString('property_doc_photo_4');
    });
  }
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
                  formheader(headerlablekey: 'key_doc_type_verification'),
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
                                              completedcheckbox(isCompleted: getDocumentType(document_type ??'') ==''?false:true),
                                              Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_doc_type'),
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
                                            child: Text(getDocumentType(document_type ??''),
                                              style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1")Container(
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
                                              completedcheckbox(isCompleted: (issued_on??'') ==''?false:true),
                                              Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Issued_on'),
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
                                            child: Text(issued_on??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1")Container(
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
                                              completedcheckbox(isCompleted: (place_of_issue??'') ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Place_of_Issue'),
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
                                            child: Text(place_of_issue??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1") Container(
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
                                              completedcheckbox(isCompleted: (property_number??'') ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Property_Number'),
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
                                            child: Text(property_number??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1")Container(
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
                                              completedcheckbox(isCompleted: (document_cover??'') ==''?false:true),
                                             /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Document_Cover'),
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
                                            child: Text(document_cover??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1")Container(
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
                                              completedcheckbox(isCompleted: (document_page??'') ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Document_Page'),
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
                                            child: Text(document_page??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1")Container(
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
                                              completedcheckbox(isCompleted: (doc_reg_number!=null ? doc_reg_number :"") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Document_Registration_Number'),
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
                                            child: Text(doc_reg_number??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              if (document_type == "1") Container(
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
                                              completedcheckbox(isCompleted: (land_area_qawwala!=null ? land_area_qawwala :"") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Land_area_in_Qawwala'),
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
                                            child: Text(land_area_qawwala??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                              //Photo1
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
                                              completedcheckbox(isCompleted: (property_doc_photo_1??'')==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Property_Document_Photo-1'),
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
                                          // SizedBox(height: 5,),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                child:property_doc_photo_1
                                                    ?.isEmpty ??
                                                    true
                                                    ? Center(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_no_image')),
                                                )
                                                    : Image.file(
                                                  File(property_doc_photo_1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              //Photo2
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
                                              completedcheckbox(isCompleted: (property_doc_photo_2??'')==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Property_Document_Photo-2'),
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
                                          // SizedBox(height: 5,),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                child: property_doc_photo_2
                                                    ?.isEmpty ??
                                                    true
                                                    ? Center(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_no_image')),
                                                )
                                                    : Image.file(
                                                  File(property_doc_photo_2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              //Photo3
                              if (document_type == "1")Container(
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
                                              completedcheckbox(isCompleted: (property_doc_photo_3??'')==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Property_Document_Photo-3'),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                child: property_doc_photo_3
                                                    ?.isEmpty ??
                                                    true
                                                    ? Center(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_no_image')),
                                                )
                                                    : Image.file(
                                                  File(property_doc_photo_3),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              //Photo 4
                              if (document_type == "1") Container(
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
                                              completedcheckbox(isCompleted: (property_doc_photo_4??'')==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_Property_Document_Photo-4'),
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
                                          // SizedBox(height: 5,),
                                          /*Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 10),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Column(
                                                children: <Widget>[
                                                  RaisedButton(
                                                    child: Text(
                                                      setapptext(
                                                          key:
                                                          'key_capture_image'),
                                                    ),
                                                    onPressed:
                                                    localdata.isdrafted == 2
                                                        ? null
                                                        : () async {
                                                      tempval = localdata
                                                          .land_area_qawwala;

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
                                                                    padding: EdgeInsets.all(8),
                                                                    //decoration: BoxDecoration(color: Colors.blue),
                                                                    child: Text(
                                                                      "Pick the image",
                                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Divider(),
                                                                  GestureDetector(
                                                                    onTap: () async {
                                                                      // localdata.property_doc_photo_1 = await appimagepicker(source: ImageSource.camera);
                                                                      Navigator.pop(context);
                                                                      setState(() {});
                                                                    },
                                                                    child: Text(
                                                                      "Use Camera",
                                                                      style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                    ),
                                                                  ),
                                                                  Divider(),
                                                                  GestureDetector(
                                                                    onTap: () async {
                                                                      //  localdata.property_doc_photo_1 = await appimagepicker(source: ImageSource.gallery);
                                                                      Navigator.pop(context);
                                                                      setState(() {});
                                                                    },
                                                                    child: Text(
                                                                      "Use Gallery",
                                                                      style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                      setState(() {});
                                                      localdata
                                                          .land_area_qawwala =
                                                          tempval;
                                                      _proareaowner
                                                          .text =
                                                          tempval;
                                                      setState(() {});
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),*/
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                child: property_doc_photo_4
                                                    ?.isEmpty ??
                                                    true
                                                    ? Center(
                                                  child: Text(setapptext(
                                                      key:
                                                      'key_no_image')),
                                                )
                                                    : Image.file(
                                                  File(property_doc_photo_4),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )
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
