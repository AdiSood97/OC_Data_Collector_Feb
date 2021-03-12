import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/pages/ViewList6.dart';
import 'package:kapp/pages/ViewList8.dart';
import 'package:kapp/pages/ViewList9.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewList4.dart';
class ViewList5 extends StatefulWidget {
  @override
  _ViewList5State createState() => _ViewList5State();
}

class _ViewList5State extends State<ViewList5> {
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
  String getLocationZone(String id) {
    var result = "";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_zone_1');
        break;
      case "2":
        result = setapptext(key: 'key_zone_2');
        break;
      case "3":
        result = setapptext(key: 'key_zone_3');
        break;
      case "4":
        result = setapptext(key: 'key_zone_4');
        break;
      case "5":
        result = setapptext(key: 'key_zone_5');
        break;
      case "6":
        result = setapptext(key: 'key_zone_6');
        break;
      case "7":
        result = setapptext(key: 'key_zone_7');
        break;
      default:
        result = id;
    }
    return result;
  }
  String getOwnerShip(String id){
    var result="";
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
  String getCurrentProperty(String id){
    var result="";
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
        result=setapptext(key: 'key_complex');
        break;
      case "4":
        result=setapptext(key: 'key_productive');
        break;
      case "5":
        result=setapptext(key: 'key_govt');
        break;
      case "6":
        result=setapptext(key: 'key_agriculture');
        break;
      case "7":
        result=setapptext(key: 'key_block_score');
        break;
      case "8":
        result=setapptext(key: 'key_property_type_specified');
        break;
      case "9":
        result=setapptext(key: 'key_property_type_unspecified');
        break;
      case "10":
        result=setapptext(key: 'key_demaged');
        break;

      default:
        result = id;
    }
    return result;
  }
  String getCommercialStatus(String id){
    var result="";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_Barber');
        break;
      case "2":
        result = setapptext(key: 'key_hotel_restaurant');
        break;
      case "3":
        result=setapptext(key: 'key_Restaurant');
        break;
      case "4":
        result=setapptext(key: 'key_Serai');
        break;
      case "5":
        result=setapptext(key: 'key_Warehouse');
        break;
      case "6":
        result=setapptext(key: 'key_Tail_Tank');
        break;
      case "7":
        result=setapptext(key: 'key_Pharmacy');
        break;
      case "8":
        result=setapptext(key: 'key_Bathroom');
        break;
      case "9":
        result=setapptext(key: 'key_other1');
        break;
      case "10":
        result=setapptext(key: 'key_shop');
        break;

      default:
        result = id;
    }
    return result;
  }
  String getGovernmentalStatus(String id){
    var result="";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_School_Startup');
        break;
      case "2":
        result = setapptext(key: 'key_Secondary_school');
        break;
      case "3":
        result=setapptext(key: 'key_Great_school');
        break;
      case "4":
        result=setapptext(key: 'key_University');
        break;
      case "5":
        result=setapptext(key: 'key_Learning_Center');
        break;
      case "6":
        result=setapptext(key: 'key_hospital');
        break;
      case "7":
        result=setapptext(key: 'key_clinic');
        break;
      case "8":
        result=setapptext(key: 'key_Playground');
        break;
      case "9":
        result=setapptext(key: 'key_Park');
        break;
      case "10":
        result=setapptext(key: 'key_Military_area');
        break;
      case "11":
        result=setapptext(key: 'key_mosque');
        break;
      case "12":
        result=setapptext(key: 'key_Graveyard');
        break;
      case "13":
        result=setapptext(key: 'key_Pilgrimage');
        break;
      case "14":
        result=setapptext(key: 'key_other1');
        break;
      default:
        result = id;
    }
    return result;
  }
  String getSpecifiedUse(String id){
    var result="";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_Car_station');
        break;
      case "2":
        result = setapptext(key: 'key_Enough_National_Station');
        break;
      case "3":
        result=setapptext(key: 'key_air_square');
        break;
      case "4":
        result=setapptext(key: 'key_Road');
        break;
      case "5":
        result=setapptext(key: 'key_Wasteland');
        break;
      case "6":
        result=setapptext(key: 'key_agriculture');
        break;
      case "7":
        result=setapptext(key: 'key_Green_area');
        break;
      case "8":
        result=setapptext(key: 'key_Jungle');
        break;
      case "9":
        result=setapptext(key: 'key_abc');
        break;
      case "10":
        result=setapptext(key: 'key_Sea');
        break;
      case "11":
        result=setapptext(key: 'key_Empty_land');
        break;
      default:
        result = id;
    }
    return result;
  }
  String getRedeem(String id){
    var result="";
    switch (id) {
      case "0":
        result = setapptext(key: 'key_none_selected');
        break;
      case "1":
        result = setapptext(key: 'key_Lease_Apartment');
        break;
      case "2":
        result = setapptext(key: 'key_Four_walls_no_building');
        break;
      case "3":
        result=setapptext(key: 'key_Under_Construction_Repairs');
        break;
      case "4":
        result=setapptext(key: 'key_Serai');
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
        if (property_have_document == "1") {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: ViewList6(
                  ),
                  type: PageTransitionType.rightToLeft));
        } else {
          if ((current_use_of_property == "2") ||
              (current_use_of_property == "3")) {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: ViewList8(
                    ),
                    type: PageTransitionType.rightToLeft));
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: ViewList9(
                    ),
                    type: PageTransitionType.rightToLeft));
          }
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
                child: ViewList4(
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
  String location_zone="",property_have_document="",current_use_of_property="",proprietary_properties="",redeemable_property="",govt_property = '',specified_current_use = '', unspecified_current_use_type='' ;
  Future getData()async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      location_zone=preferences.getString('location_of_land_area');
      property_have_document=preferences.getString('property_have_document');
      current_use_of_property=preferences.getString('current_use_of_property');
      proprietary_properties=preferences.getString('proprietary_properties');
      print("jhdfjghdhguihdgdjkhgdgjhdhghdhghdghdghdg=${getCommercialStatus(proprietary_properties)}");
      govt_property=preferences.getString('govt_property') ?? "" ;
      specified_current_use=preferences.getString('specified_current_use') ?? "" ;
      unspecified_current_use_type=preferences.getString('unspecified_current_use_type')??'';
      redeemable_property=preferences.getString('redeemable_property');

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
                formheader(headerlablekey: 'key_property_details'),
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
                                          completedcheckbox(isCompleted: getLocationZone(location_zone)==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_location_land'),
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
                                        child: Text(getLocationZone(location_zone),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: getOwnerShip(property_have_document) ==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_does_properties_document'),
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
                                        child: Text(getOwnerShip(property_have_document),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: getCurrentProperty(current_use_of_property) ==''?false:true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_current_use_property_type'),
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
                                        child: Text(getCurrentProperty(current_use_of_property),style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          if(current_use_of_property=='2'||current_use_of_property=='3')Container(
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
                                          completedcheckbox(isCompleted: getCommercialStatus(proprietary_properties) ==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_Proprietary_Properties'),
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
                                        child: Text(getCommercialStatus(proprietary_properties) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          if(current_use_of_property=='1'||current_use_of_property=='3')Container(
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
                                          completedcheckbox(isCompleted: getRedeem(redeemable_property) ==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_Type_of_redeemable_property'),
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
                                        child: Text(getRedeem(redeemable_property) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          if(current_use_of_property=='5')Container(
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
                                          completedcheckbox(isCompleted: getGovernmentalStatus(govt_property)==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_govt_proprty'),
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
                                        child: Text(getGovernmentalStatus(govt_property) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          if(current_use_of_property=='8')Container(
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
                                          completedcheckbox(isCompleted: getSpecifiedUse(specified_current_use) ==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_type_of_currentuse'),
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
                                        child: Text(getSpecifiedUse(specified_current_use) ?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          if(current_use_of_property=='9')Container(
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
                                          completedcheckbox(isCompleted: unspecified_current_use_type ==''?false:true),
                                          /*Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),*/
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_current_usage'),
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
                                        child: Text(unspecified_current_use_type?? "",style: TextStyle(fontSize: 20,color: Colors.black),),
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
          ),
        )
    );
  }
}
