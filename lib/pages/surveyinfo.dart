import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kapp/controllers/task.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:kapp/utils/locator.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import '../localization/app_translations.dart';
import '../models/localpropertydata.dart';
import '../utils/db_helper.dart';
import '../utils/appstate.dart';
import './generalinfoone.dart';
import '../widgets/appformcards.dart';
import '../models/surveyAssignment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyInfoPage extends StatefulWidget {
  SurveyInfoPage(
      {this.localdata,
      this.localsurveykey,
      this.surveyAssignment,
      this.surveyDetails,
      this.surveyList});
  final LocalPropertySurvey localdata;
  String localsurveykey;
  final SurveyAssignment surveyAssignment;
  final surveyDetails;
  List surveyList;
  @override
  _SurveyInfoPageState createState() =>
      _SurveyInfoPageState(surveyDetails, surveyList);
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  _SurveyInfoPageState(this.surveyDetails, this.surveyList);
  final surveyDetails;
  List surveyList;
  String defaultSurveyId1;
  String currentSurveyId;
  String currentSurveyName;
  bool display1 = true;
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

  LocalPropertySurvey localdata;
  SurveyAssignment surveyAssignment;
  var _formkey = GlobalKey<FormState>();
  FocusNode _firstsurveyor;
  FocusNode _secondsurveyor;
  FocusNode _technicalsupport;
  bool _prefAvailable = false;
  var surveyorone;
  var surveyorthree;
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
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
        //localdata.taskid = surveyDetails['_id'];
        if (!(_formkey.currentState.validate())) {
          return;
        } else {
          _formkey.currentState.save();
          if(localdata.isrework!=1){
            if (widget.localdata != null) {
              localdata = widget.localdata;
            }
          }
          if (widget.surveyAssignment != null) {
            localdata.taskid = widget.surveyAssignment.id;
          }
          /*if (localdata.editmode == 1) {
            localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
            localdata.editmode = 1;
          }*/
          /*if (widget.surveyAssignment != null) {
           if(widget.surveyAssignment.surveyoronename != "") {
             localdata.first_surveyor_name =
                 widget.surveyAssignment.surveyoronename;
             localdata.senond_surveyor_name =
                 widget.surveyAssignment.surveyortwoname;
             localdata.technical_support_name =
                 widget.surveyAssignment.teamleadname;
             localdata.province = widget.surveyAssignment.province;
             localdata.city = widget.surveyAssignment.municpality;
             localdata.area = widget.surveyAssignment.nahia;
             localdata.pass = widget.surveyAssignment.gozar;
             localdata.block = widget.surveyAssignment.block;
             localdata.surveyoroneid = widget.surveyAssignment.surveyor1;
             localdata.surveyortwoid = widget.surveyAssignment.surveyor2;
             localdata.surveyleadid = widget.surveyAssignment.teamlead;
           }
            localdata.other_key =
                (widget.surveyAssignment.reworkstatus?.isEmpty ?? true)
                    ? "Survey Completed"
                    : widget.surveyAssignment.reworkstatus;
          }*/
          Navigator.pushReplacement(
            context,
            PageTransition(
                child: GeneralInfoOnePage(
                  localdata: localdata,
                  surveyList: surveyList,
                ),
                type: PageTransitionType.rightToLeft),
          );
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

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    surveyAssignment=new SurveyAssignment();
    print("SurveyAssignment is :=${surveyAssignment}");
    _firstsurveyor = new FocusNode();
    _secondsurveyor = new FocusNode();
    _technicalsupport = new FocusNode();
    if(surveyDetails != null){
      localdata.taskid = surveyDetails["_id"];
      //localdata.taskid = surveyDetails.first_surveyor_name;
      currentSurveyId = surveyDetails['_id'];
      currentSurveyName =
          '${surveyDetails['first_name']} ${surveyDetails['last_name']}';
    }
    print("97959-----------=================== ${localdata.first_surveyor_name}");
    print(widget.localsurveykey);
    print("current survery details ====== ${currentSurveyId},${currentSurveyName}");
   //print("survery list ====== ${surveyList}");
    defaultSurveyId1 = '';
    if (widget.localdata != null) {
      localdata = widget.localdata;
    }
    if (widget.surveyAssignment != null) {
      localdata.first_surveyor_name = widget.surveyAssignment.surveyoronename;
      localdata.senond_surveyor_name = widget.surveyAssignment.surveyortwoname;
      localdata.technical_support_name = widget.surveyAssignment.teamleadname;
    }
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      Future.delayed(Duration.zero).then((_) {
        /*if (surveyDetails == null){
          localdata.taskid = widget.localdata.taskid;
        }else {
          localdata.taskid = surveyDetails["_id"];
        }*/
        Provider.of<DBHelper>(context, listen: false).getSingleProperty(
            taskid: (surveyDetails!=null)?surveyDetails['_id']:widget.localdata.taskid,
            localkey: widget.localsurveykey);
      });
    }
    asyncMethod();
    super.initState();
  }

  Future<void> asyncMethod() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    localdata.surveyoroneid = preferences.getString('new_id');
    print(localdata.surveyoroneid);

    setState(() {
      _prefAvailable = true;
    });
  }


  @override
  void didChangeDependencies() {
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
      localdata.editmode = 1;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++++${widget.localsurveykey}");
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
      //localdata.editmode = 1;
    }
    print('pqoowieuuwiefni ${localdata.first_surveyor_name}');
    print('pqoowieuuwiefni ${localdata.surveyoroneid}');
    print('sgsdgsdsddsf ${localdata.surveyortwoid}');
    print('sgsdgsdsddsf ${localdata.senond_surveyor_name}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_property_survey'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: !_prefAvailable?Center(
        child: CircularProgressIndicator(),
      ):Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          if(localdata.editmode==1){
            localdata = dbdata.singlepropertysurveys;
          }
          surveyorone = getValueForName(localdata.surveyoroneid,
              localdata.first_surveyor_name, surveyList);
          localdata.first_surveyor_name =
          '${surveyorone['first_name'].trim()} ${surveyorone['last_name'].trim()}';
          localdata.surveyoroneid = surveyorone['_id'].toString();
          if(localdata.isrework==1){
            if(localdata.technical_support_name != null || localdata.surveyleadid!=null){
                  surveyorthree = getValueForName(localdata.surveyleadid,
                      localdata.technical_support_name, surveyList)??'';

                  localdata.technical_support_name =
                      '${surveyorthree['first_name'].trim()} ${surveyorthree['last_name'].trim()}';
                  localdata.surveyleadid = surveyorthree['_id'].toString();}
                }

                return dbdata.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //header
                        formheader(headerlablekey: 'key_provider_details'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              localdata.editmode == 1
                                  ? Wrap(
                                      runAlignment: WrapAlignment.spaceBetween,
                                      runSpacing: 20,
                                      spacing: 20,
                                      children: <Widget>[
                                        wrapContaint(
                                            titel:
                                                setapptext(key: 'key_province'),
                                            subtitel: getProvincename(
                                                localdata.province?.isEmpty ??
                                                        true
                                                    ? ""
                                                    : localdata.province)),
                                        wrapContaint(
                                            titel: setapptext(
                                                key: 'key_municipality'),
                                            subtitel: getCity(
                                                localdata.city?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.city)),
                                        wrapContaint(
                                            titel: setapptext(key: 'key_nahia'),
                                            subtitel:
                                                localdata.area?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.area),
                                        wrapContaint(
                                            titel: setapptext(key: 'key_gozar'),
                                            subtitel:
                                                localdata.pass?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.pass),
                                        wrapContaint(
                                            titel: setapptext(
                                                key: 'key_only_block'),
                                            subtitel:
                                                localdata.block?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.block),
                                        wrapContaint(
                                            titel:
                                                setapptext(key: 'key_parcel'),
                                            subtitel: localdata
                                                        .part_number?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.part_number),
                                        wrapContaint(
                                            titel:
                                                setapptext(key: 'key_unit_no'),
                                            subtitel: localdata
                                                        .unit_number?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.unit_number),
                                      ],
                                    )
                                  // ? Container(
                                  //     padding:
                                  //         EdgeInsets.only(left: 15, right: 15),
                                  //     child: Column(
                                  //       children: <Widget>[
                                  //         Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_province')),
                                  //                   Text(
                                  //                     getProvincename(localdata
                                  //                                 .province
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata.province),
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_city')),
                                  //                   Text(
                                  //                     getCity(localdata.city
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata.city),
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_only_block')),
                                  //                   Text(
                                  //                     localdata.block
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata.block,
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             )
                                  //           ],
                                  //         ),
                                  //         SizedBox(
                                  //           height: 15,
                                  //         ),
                                  //         Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_part')),
                                  //                   Text(
                                  //                     localdata.part_number
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata
                                  //                             .part_number,
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_unit_no')),
                                  //                   Text(
                                  //                     localdata.unit_number
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata
                                  //                             .unit_number,
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //                 fit: FlexFit.tight,
                                  //                 child: SizedBox())
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   )
                                  : SizedBox(),
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
                                    child: Text(localdata.first_surveyor_name,style: TextStyle(fontSize: 18),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                    child: Divider(
                                      height: 5,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  SizedBox(height: 10,)
                                ],
                              )
                          ),
                        ),
                      ),
                              formcardtextfield1(
                                  enable: false,
                                  value: getValueForName(localdata.surveyortwoid,localdata.senond_surveyor_name, surveyList),
                                  fieldrequired: true,
                                  surveyList: surveyList,
                                  headerlablekey:
                                  setapptext(key: 'key_second_surveyor'),
                                  radiovalue:
                                  localdata.senond_surveyor_name?.isEmpty ??
                                      true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  hinttextkey:
                                  setapptext(key: 'key_enter_1st_surveyor'),
                                  fieldfocus: _secondsurveyor,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _secondsurveyor.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_technicalsupport);
                                  },
                                  /*initvalue:
                                      localdata.senond_surveyor_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.senond_surveyor_name,*/
                                  validator: (dynamic value) {
                                    if (value['_id'].trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (dynamic value) {
                                    localdata.senond_surveyor_name =
                                    '${value['first_name'].trim()} ${value['last_name'].trim()}';
                                    localdata.surveyortwoid = value['_id'].trim();
                                  },
                                  onChanged: (dynamic value) {
                                    localdata.senond_surveyor_name =
                                    '${value['first_name'].trim()} ${value['last_name'].trim()}';
                                    localdata.surveyortwoid = value['_id'].trim();
                                    setState(() {});
                                  }),
                              if(surveyorthree == null)Container(
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
                                              completedcheckbox(isCompleted: false),

                                              Flexible(
                                                child: Container(
                                                  child: Text(setapptext(key: 'key_name_technical_support'), style:TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                    overflow: TextOverflow.visible,
                                                    softWrap: true,
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
                                            child: Text("",style: TextStyle(fontSize: 18),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                            child: Divider(
                                              height: 5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              if(surveyorthree != null)formcardtextfield1(
                                  enable: false,
                                  value: getValueForName(localdata.technical_support_name,localdata.surveyleadid, surveyList),
                                  fieldrequired: false,
                                  surveyList: surveyList,
                                  headerlablekey: setapptext(
                                      key: 'key_name_technical_support'),
                                headerlablekeycolor: (surveyorthree == null)?
                                Colors.grey:Colors.black,
                                  radiovalue: localdata.technical_support_name
                                      ?.isEmpty ??
                                      true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  hinttextkey:(surveyorthree == null)?
                                  "":(surveyorthree['first_name']+' '+surveyorthree['last_name']),
                                  fieldfocus: _technicalsupport,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _technicalsupport.unfocus();
                                  },
                                  initvalue: localdata.technical_support_name
                                      ?.isEmpty ??
                                      true
                                      ? ""
                                      : localdata.technical_support_name,
                                  validator: (dynamic value) {},
                                  onSaved: (dynamic value) {
                                    if(value!=null){
                                    localdata.technical_support_name =
                                    '${value['first_name'].trim()} ${value['last_name'].trim()}';
                                    localdata.surveyleadid = value['_id'].trim();}
                                  },
                                  onChanged: null,/*(dynamic value) {
                                    localdata.technical_support_name =
                                    '${value['first_name'].trim()} ${value['last_name'].trim()}';
                                    localdata.surveyleadid = value['_id'].trim();
                                    setState(() {});
                                  }*/
                              ),
                            ],
                          ),
                        ),
                        //footer
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
                  ),
                );
        },
      ),
    );
  }

  getValueForName(String id, String name, List surList) {
    for(int i = 0; i<surveyList.length; i++){
      if(id != null){
        if (surList[i]['_id'] == id) {
          print('=-=-=-=-000---0-0--0 ${surList[i]['first_name']}');
          return surList[i];
        }
      }
      if(name != null){
        if (surList[i]['_id'] == name) {
          print('=-=-=-=-000---0-0--0 ${surList[i]['first_name']}');
          return surList[i];
        }
      }
    }
  }
}
