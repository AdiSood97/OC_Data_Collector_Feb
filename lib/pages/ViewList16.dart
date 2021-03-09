import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList17.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList15.dart';

class ViewList16 extends StatefulWidget {
  @override
  _ViewList16State createState() => _ViewList16State();
}

class _ViewList16State extends State<ViewList16> {
  LocalPropertySurvey localdata = LocalPropertySurvey();
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
                child: ViewList17(
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
                child: ViewList15(
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

  String getYesNo(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_yes_sir');
        break;
      case "2":
        result = setapptext(key: 'key_no');
        break;
      default:
        result = id;
    }
    return result;
  }

  String getCurrentFunction(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_release');
        break;
      case "2":
        result = setapptext(key: 'key_commercial');
        break;
      case "3":
        result = setapptext(key: 'key_govt');
        break;
      case "4":
        result = setapptext(key: 'key_productive');
        break;
      case "5":
        result = setapptext(key: 'key_general');
        break;
      default:
        result = id;
    }
    return result;
  }

  String getCategory(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_Modern_Concrete');
        break;
      case "2":
        result = setapptext(key: 'key_Concrete');
        break;
      case "3":
        result = setapptext(key: 'key_Half_cream_and_half_baked');
        break;
      case "4":
        result = setapptext(key: 'key_Cream');
        break;
      case "5":
        result = setapptext(key: 'key_metal');
        break;
      case "6":
        result = setapptext(key: 'key_other1');
        break;
      default:
        result = id;
    }
    return result;
  }

  String fst_have_building = "",
      fst_building_use = "",
      fst_building_category = "",
      fst_specifyif_other = "",
      fst_no_of_floors = "",
      fst_cubie_meter = "",
      snd_have_building = "",
      snd_building_use = "",
      snd_building_category = "",
      snd_specifyif_other = "",
      snd_no_of_floors = "",
      snd_cubie_meter = "",
      trd_have_building = "",
      trd_building_use = "",
      trd_building_category = "",
      trd_specifyif_other = "",
      trd_no_of_floors = "",
      trd_cubie_meter = "",
      forth_have_building = "",
      forth_building_use = "",
      forth_building_category = "",
      forth_specifyif_other = "",
      forth_no_of_floors = "",
      forth_cubie_meter = "",
      fth_have_building = "",
      fth_building_use = "",
      fth_building_category = "",
      fth_specifyif_other = "",
      fth_no_of_floors = "",
      fth_cubie_meter = "";

  Future getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fst_have_building = preferences.getString('fst_have_building');
      fst_building_use = preferences.getString('fst_building_use');
      fst_building_category = preferences.getString('fst_building_category');
      fst_specifyif_other = preferences.getString('fst_specifyif_other');
      fst_no_of_floors = preferences.getString('fst_no_of_floors');
      fst_cubie_meter = preferences.getString('fst_cubie_meter');
      snd_have_building = preferences.getString('snd_have_building');
      snd_building_use = preferences.getString('snd_building_use');
      snd_building_category = preferences.getString('snd_building_category');
      snd_specifyif_other = preferences.getString('snd_specifyif_other');
      snd_no_of_floors = preferences.getString('snd_no_of_floors');
      snd_cubie_meter = preferences.getString('snd_cubie_meter');
      trd_have_building = preferences.getString('trd_have_building');
      trd_building_use = preferences.getString('trd_building_use');
      trd_building_category = preferences.getString('trd_building_category');
      trd_specifyif_other = preferences.getString('trd_specifyif_other');
      trd_no_of_floors = preferences.getString('trd_no_of_floors');
      trd_cubie_meter = preferences.getString('trd_cubie_meter');
      forth_have_building = preferences.getString('forth_have_building');
      forth_building_use = preferences.getString('forth_building_use');
      forth_building_category = preferences.getString('forth_building_category');
      forth_specifyif_other = preferences.getString('forth_specifyif_other');
      forth_no_of_floors = preferences.getString('forth_no_of_floors');
      forth_cubie_meter = preferences.getString('forth_cubie_meter');
      fth_have_building = preferences.getString('fth_have_building');
      fth_building_use = preferences.getString('fth_building_use');
      fth_building_category = preferences.getString('fth_building_category');
      fth_specifyif_other = preferences.getString('fth_specifyif_other');
      fth_no_of_floors = preferences.getString('fth_no_of_floors');
      fth_cubie_meter = preferences.getString('fth_cubie_meter');
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
        body: SafeArea(
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              formheader(headerlablekey: 'key_building_info'),
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
                        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              width: 400,
                              //padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(176, 174, 171, 1),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    textDirection: locator<LanguageService>()
                                                .currentlanguage ==
                                            0
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    children: <Widget>[
                                      completedcheckbox(isCompleted: (getYesNo(fst_have_building)??"")==""?false:true),
                                      Text(
                                        '*',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                      ),
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            setapptext(
                                                key:
                                                    'key_does_property_building'),
                                            overflow: TextOverflow.visible,
                                            softWrap: true,
                                            style: TextStyle(),
                                            textDirection:
                                                locator<LanguageService>()
                                                            .currentlanguage ==
                                                        0
                                                    ? TextDirection.ltr
                                                    : TextDirection.rtl,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      getYesNo(fst_have_building),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Divider(
                                      height: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )),
                        ),
                      ),
                      if (fst_have_building == "1")
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: Center(
                            child: Text(
                              setapptext(key: 'key_fst_building_info'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (fst_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                                  .currentlanguage ==
                                              0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCurrentFunction(fst_building_use)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_use'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                              LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCurrentFunction(fst_building_use) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fst_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                                  .currentlanguage ==
                                              0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCategory(fst_building_category)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_category'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                              LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCategory(fst_building_category) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fst_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                                  .currentlanguage ==
                                              0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (fst_specifyif_other??"")==""?false:true),
                                        /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_choose_another'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                              LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        fst_specifyif_other ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fst_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                                  .currentlanguage ==
                                              0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (fst_no_of_floors??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_Number_of_floors'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                              LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        fst_no_of_floors ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fst_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                                  .currentlanguage ==
                                              0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (fst_cubie_meter??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(key: 'key_Unit_Size'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                              LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        fst_cubie_meter ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fst_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                                  .currentlanguage ==
                                              0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getYesNo(snd_have_building)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_add_building'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                              LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getYesNo(snd_have_building) ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),

                      if (snd_have_building == "1")
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: Center(
                            child: Text(
                              setapptext(key: 'key_second_building_info'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (snd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCurrentFunction(snd_building_use)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_use'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCurrentFunction(snd_building_use) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (snd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCategory(snd_building_category)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_category'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCategory(snd_building_category) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (snd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (snd_specifyif_other??"")==""?false:true),
                                        /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_choose_another'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        snd_specifyif_other ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (snd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (snd_no_of_floors??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_Number_of_floors'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        snd_no_of_floors ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (snd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (snd_cubie_meter??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(key: 'key_Unit_Size'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        snd_cubie_meter ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (snd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getYesNo(snd_have_building)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_add_building'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getYesNo(snd_have_building) ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),

                      if (trd_have_building == "1")
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: Center(
                            child: Text(
                              setapptext(key: 'key_third_building_info'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (trd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCurrentFunction(trd_building_use)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_use'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCurrentFunction(trd_building_use) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (trd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCategory(trd_building_category)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_category'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCategory(trd_building_category) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (trd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (trd_specifyif_other??"")==""?false:true),
                                        /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_choose_another'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        trd_specifyif_other ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (trd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (trd_no_of_floors??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_Number_of_floors'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        trd_no_of_floors ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (trd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (trd_cubie_meter??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(key: 'key_Unit_Size'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        trd_cubie_meter ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (trd_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getYesNo(snd_have_building)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_add_building'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getYesNo(snd_have_building) ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),

                      if (forth_have_building == "1")
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: Center(
                            child: Text(
                              setapptext(key: 'key_fourth_building_info'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (forth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCurrentFunction(forth_building_use)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_use'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCurrentFunction(forth_building_use) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (forth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCategory(forth_building_category)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_category'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCategory(forth_building_category) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (forth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (forth_specifyif_other??"")==""?false:true),
                                        /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_choose_another'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        forth_specifyif_other ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (forth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (forth_no_of_floors??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_Number_of_floors'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        forth_no_of_floors ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (forth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (forth_cubie_meter??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(key: 'key_Unit_Size'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        forth_cubie_meter ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (forth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getYesNo(snd_have_building)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_add_building'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getYesNo(snd_have_building) ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),

                      if (fth_have_building == "1")
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: Center(
                            child: Text(
                              setapptext(key: 'key_fifth_builging_info'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (fth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCurrentFunction(fth_building_use)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_use'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCurrentFunction(fth_building_use) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getCategory(fth_building_category)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_building_category'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getCategory(fth_building_category) ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (fth_specifyif_other??"")==""?false:true),
                                        /* Text(
                                                '*',
                                                style: TextStyle(color: Colors.red, fontSize: 18),
                                              ),*/
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_choose_another'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        fth_specifyif_other ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (fth_no_of_floors??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_Number_of_floors'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        fth_no_of_floors ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (fth_cubie_meter??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(key: 'key_Unit_Size'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        fth_cubie_meter ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      if (fth_have_building == '1')
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                width: 400,
                                //padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(176, 174, 171, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: locator<LanguageService>()
                                          .currentlanguage ==
                                          0
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      children: <Widget>[
                                        completedcheckbox(isCompleted: (getYesNo(snd_have_building)??"")==""?false:true),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              setapptext(
                                                  key: 'key_add_building'),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: TextStyle(),
                                              textDirection: locator<
                                                  LanguageService>()
                                                  .currentlanguage ==
                                                  0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        getYesNo(snd_have_building) ?? "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
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
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ));
  }
}
