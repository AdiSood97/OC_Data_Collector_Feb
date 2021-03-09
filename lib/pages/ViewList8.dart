import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList9.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList7.dart';
class ViewList8 extends StatefulWidget {
  @override
  _ViewList8State createState() => _ViewList8State();
}

class _ViewList8State extends State<ViewList8> {
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
                child: ViewList9(
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
                child: ViewList7(
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
  String number_of_business_unit="",business_unit_have_no_license="",business_license_another="";
  Future getData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      number_of_business_unit=preferences.getString('number_of_business_unit');
      business_unit_have_no_license=preferences.getString('business_unit_have_no_license');
      business_license_another=preferences.getString('business_license_another');
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
                  formheader(headerlablekey: 'key_business_licence'),
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
                                              completedcheckbox(isCompleted: (number_of_business_unit??"") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_how_many_business'),
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
                                            child: Text(number_of_business_unit!=null ? number_of_business_unit :"",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (business_unit_have_no_license??"") ==''?false:true),
                                             /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_howmany_business_license'),
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
                                            child: Text(business_unit_have_no_license!=null ? business_unit_have_no_license :"",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                              completedcheckbox(isCompleted: (business_license_another??"") ==''?false:true),
                                              /*Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_other1'),
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
                                            child: Text(business_license_another!=null ? business_license_another :"",style: TextStyle(fontSize: 20,color: Colors.black),),
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
