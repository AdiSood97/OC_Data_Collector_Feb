
import 'package:flutter/material.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/models/localpropertydata.dart';
import 'package:kapp/models/surveyAssignment.dart';
import 'package:kapp/pages/ViewList1.dart';
import 'package:kapp/pages/generalinfoone.dart';
import 'package:kapp/utils/appstate.dart';
import 'package:kapp/utils/db_helper.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:kapp/widgets/appformcards.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum CheckColor { Black, Green, Red }

class EditPage extends StatefulWidget {
  final surveyList;
  final surveyDeatils;
  final localsurveykey;

  EditPage({Key key,this.surveyList, this.surveyDeatils, this.localsurveykey,}):super(key:key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var _formkey = GlobalKey<FormState>();
  FocusNode _firstsurveyor;
  FocusNode _secondsurveyor;
  FocusNode _technicalsupport;
  CheckColor radioValue;
  LocalPropertySurvey localdata= LocalPropertySurvey();
  String surveyFirstName="",surveySecondName="",surveyThirdName="",province='',city='',area='',block='',pass='',part_number='',unit_number='';

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }
  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: ViewList1(
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


Future getData() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      surveyFirstName=preferences.get('first_surveyor_name');
      surveySecondName=preferences.get('senond_surveyor_name');
      surveyThirdName=preferences.get('technical_support_name');
      province=preferences.get('province');
      city=preferences.get('city');
      pass=preferences.get('pass');
      area=preferences.get('area');
      block=preferences.get('block');
      part_number=preferences.get('part_number');
      unit_number=preferences.get('unit_number');
    });

}
  @override
  void initState(){
    //localdata.taskid=widget.surveyDeatils["_id"];
   // print(widget.surveyDeatils["first_name"]);
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
              Expanded(
                  child: ListView(
                    children: [
                      Wrap(
                        runAlignment: WrapAlignment.spaceBetween,
                        runSpacing: 5,
                        spacing: 20,
                        children: <Widget>[
                          wrapContaint(
                              titel:
                              setapptext(key: 'key_province'),
                              subtitel: getProvincename(
                                  province?.isEmpty ??
                                      true
                                      ? ""
                                      : province)),
                          wrapContaint(
                              titel: setapptext(
                                  key: 'key_municipality'),
                              subtitel: getCity(city?.isEmpty ?? true
                                      ? ""
                                      : city)),
                          wrapContaint(
                              titel: setapptext(key: 'key_nahia'),
                              subtitel: area?.isEmpty ?? true
                                  ? ""
                                  : area),
                          wrapContaint(
                              titel: setapptext(key: 'key_gozar'),
                              subtitel: pass?.isEmpty ?? true
                                  ? ""
                                  : pass),
                          wrapContaint(
                              titel: setapptext(
                                  key: 'key_only_block'),
                              subtitel: block?.isEmpty ?? true
                                  ? ""
                                  : block),
                          wrapContaint(
                              titel:
                              setapptext(key: 'key_parcel'),
                              subtitel:part_number?.isEmpty ??
                                  true
                                  ? ""
                                  : part_number),
                          wrapContaint(
                              titel:
                              setapptext(key: 'key_unit_no'),
                              subtitel:unit_number?.isEmpty ??
                                  true
                                  ? ""
                                  : unit_number),
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
                                          completedcheckbox(isCompleted: true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_first_surveyor'),
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
                                        child: Text(surveyFirstName,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_second_surveyor'),
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
                                        child: Text(surveySecondName,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                          completedcheckbox(isCompleted: true),
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red, fontSize: 18),
                                          ),
                                          Flexible(
                                            child: Container(
                                              child: Text(setapptext(key: 'key_name_technical_support'),
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
                                        child: Text(surveyThirdName,style: TextStyle(fontSize: 20,color: Colors.black),),
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
                          //SizedBox(height: 100,),

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
        ))
    );
  }

}
