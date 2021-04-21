import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList11.dart';
import 'package:kapp/pages/ViewList12.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:kapp/widgets/appformcards.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList9.dart';
class ViewList10 extends StatefulWidget {
  @override
  _ViewList10State createState() => _ViewList10State();
}

class _ViewList10State extends State<ViewList10> {
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
        if (property_type == "1") {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: ViewList12(
                  ),
                  type: PageTransitionType.rightToLeft));
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: ViewList11(
                  ),
                  type: PageTransitionType.rightToLeft));
        }
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
                child: ViewList9(
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
  String tempval = "", property_type='';
  String info_photo_hint_sukuk_number="",info_photo_hint_cover_note="",info_photo_hint_note_page="",info_photo_hint_reg_no="", info_photo_hint_photo_note1 ='',info_photo_hint_photo_tips1='',info_photo_hint_photo_tips2='';
  Future getData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      info_photo_hint_sukuk_number=preferences.getString('info_photo_hint_sukuk_number');
      info_photo_hint_cover_note=preferences.getString('info_photo_hint_cover_note');
      info_photo_hint_note_page=preferences.getString('info_photo_hint_note_page');
      info_photo_hint_reg_no=preferences.getString('info_photo_hint_reg_no');
      info_photo_hint_photo_note1 =preferences.getString('info_photo_hint_photo_note1');
      print(info_photo_hint_photo_note1);
          info_photo_hint_photo_tips1 =preferences.getString('info_photo_hint_photo_tips1');
          info_photo_hint_photo_tips2 = preferences.getString('info_photo_hint_photo_tips2');
      property_type=preferences.getString('property_type');
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
                  formheader(headerlablekey: 'key_information_and_photo'),
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
                                              completedcheckbox(isCompleted: info_photo_hint_sukuk_number ==''?false:true),
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
                                            child: Text(info_photo_hint_sukuk_number??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: info_photo_hint_cover_note ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_cover_note'),
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
                                            child: Text(info_photo_hint_cover_note??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: info_photo_hint_note_page ==''?false:true),
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
                                            child: Text(info_photo_hint_note_page??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: info_photo_hint_reg_no ==''?false:true),
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
                                            child: Text(info_photo_hint_reg_no??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                                isCompleted: (localdata.info_photo_hint_photo_note1??"")==""?false:true),
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
                                              child: info_photo_hint_photo_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(info_photo_hint_photo_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(info_photo_hint_photo_note1),
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
                                                isCompleted: (localdata.info_photo_hint_photo_tips1??"")==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        /*Padding(
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
                                                                    localdata.info_photo_hint_photo_tips1 = await appimagepicker(source: ImageSource.camera);
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
                                                                    localdata.info_photo_hint_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
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
                                        ),*/
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
                                              child: info_photo_hint_photo_tips1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(info_photo_hint_photo_tips1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(info_photo_hint_photo_tips1),
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
                                                isCompleted: (localdata.info_photo_hint_photo_tips2??"")==""?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        /*Padding(
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
                                                                    localdata.info_photo_hint_photo_tips2 = await appimagepicker(source: ImageSource.camera);
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
                                                                    localdata.info_photo_hint_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
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
                                        ),*/
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
                                              child: info_photo_hint_photo_tips2
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(info_photo_hint_photo_tips2)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(info_photo_hint_photo_tips2),
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
