import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ListView13.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:kapp/widgets/appformcards.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ListView13.dart';
import 'ViewList11.dart';
class ViewList12 extends StatefulWidget {
  @override
  _ViewList12State createState() => _ViewList12State();
}

class _ViewList12State extends State<ViewList12> {
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
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: ViewList13(
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
                child: ViewList11(
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
  String boundaryinfonote="",fore_limits_east="",fore_limits_west="",fore_limits_south="",fore_limits_north="";
  Future getData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      boundaryinfonote=preferences.getString('boundaryinfonote');
      fore_limits_east=preferences.getString('fore_limits_east');
      fore_limits_west=preferences.getString('fore_limits_west');
      fore_limits_south=preferences.getString('fore_limits_south');
      fore_limits_north=preferences.getString('fore_limits_north');
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
                  formheader(headerlablekey: 'key_four_limits'),
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
                                              completedcheckbox(isCompleted: (boundaryinfonote?? "") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_property_note'),
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
                                            child: Text(boundaryinfonote??'',style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fore_limits_east?? "") ==''?false:true),
                                              Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_east'),
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
                                            child: Text(fore_limits_east,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fore_limits_west?? "") ==''?false:true),
                                              Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_west'),
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
                                            child: Text(fore_limits_west,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fore_limits_south?? "") ==''?false:true),
                                              Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_south'),
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
                                            child: Text(fore_limits_south,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (fore_limits_north?? "") ==''?false:true),
                                              Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_north'),
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
                                            child: Text(fore_limits_north,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                                isCompleted: (localdata.home_map?? "") ==''?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_home_map'),
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
                                                    tempval = localdata
                                                        .info_photo_hint_reg_no;

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
                                                                    localdata.info_photo_hint_photo_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                    localdata.info_photo_hint_photo_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                    localdata
                                                        .info_photo_hint_reg_no =
                                                        tempval;
                                                    _regno.text =
                                                        tempval;
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
                                                  .info_photo_hint_photo_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(localdata
                                                  .info_photo_hint_photo_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(localdata
                                                    .info_photo_hint_photo_note1),
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
                                                isCompleted: (localdata.info_photo_hint_photo_note1?? "") ==''?false:true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_home_photo'),
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
                                                    tempval = localdata
                                                        .info_photo_hint_reg_no;

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
                                                                    localdata.info_photo_hint_photo_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                    localdata.info_photo_hint_photo_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                    localdata
                                                        .info_photo_hint_reg_no =
                                                        tempval;
                                                    _regno.text =
                                                        tempval;
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
                                                  .info_photo_hint_photo_note1
                                                  ?.isEmpty ??
                                                  true
                                                  ? Center(
                                                child: Text(setapptext(
                                                    key: 'key_no_image')),
                                              )
                                                  : File(localdata
                                                  .info_photo_hint_photo_note1)
                                                  .existsSync()
                                                  ? Image.file(
                                                File(localdata
                                                    .info_photo_hint_photo_note1),
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
