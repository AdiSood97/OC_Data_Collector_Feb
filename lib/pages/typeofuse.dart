import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kapp/configs/configuration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './businesslicense.dart';
import './docverification.dart';
import './firstpartnerinfo.dart';

class TypeOfUsePage extends StatefulWidget {
  TypeOfUsePage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _TypeOfUsePageState createState() => _TypeOfUsePageState();
}

class _TypeOfUsePageState extends State<TypeOfUsePage> {
  LocalPropertySurvey localdata;
  List<String> propertyUseValues = [];
  Map<String, String> propertyUses={};
  bool gotProperty = false;
  var _formkey = GlobalKey<FormState>();

  void _propertyUseListAPI() async {
    propertyUseValues.add('0');
    propertyUses['0']='None Selected';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await http.get(Configuration.apiurl + 'mPropertyUseType?active=true', headers: {
      "Content-Type": "application/json",
      "Authorization": preferences.getString("accesstoken")
    });

    if (response.statusCode == 200) {
      final data1 = json.decode(response.body);
      print('wieryweionhurhg o--=-=-${data1["data"] }');

      for(dynamic item in data1["data"]){

        propertyUseValues.add(item['value']);
        propertyUses[item['value']] = item['name'];

      }
      propertyUseValues = propertyUseValues.toSet().toList();

      setState(() {
        gotProperty = true;
      });

    } else {
      throw Exception('Failed to load jobs from API');
    }
  }


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
        if (!(_formkey.currentState.validate())) {
          return;
        } else {
          _formkey.currentState.save();
          if (localdata.isdrafted != 2) {
            await DBHelper()
                .updatePropertySurvey(localdata, localdata.local_property_key);
          }
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: BusinessLicensePage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: FirstPartnerPage(
                      localdata: localdata,
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
                child: DocVerificationPage(
                  localdata: localdata,
                ),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        child: Row(
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

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    _propertyUseListAPI();
    super.initState();
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
      body: Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          return (!(!(dbdata.state == AppState.Busy) && gotProperty))
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
                        formheader(headerlablekey: 'key_type_of_use'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield6(

                                value: localdata.use_in_property_doc??"0",
                                valuesList: propertyUseValues,
                                valuesMap: propertyUses,
                                enable: false,
                                keyboardtype: TextInputType.text,
                                headerlablekey:
                                setapptext(key: 'key_use_type_doc'),
                                radiovalue:
                                ((localdata.use_in_property_doc?.isEmpty ?? true) || localdata.use_in_property_doc=='0')
                                    ? CheckColor.Black
                                    : CheckColor.Green,
                                hinttextkey:
                                setapptext(key: 'key_none_selected'),
                                initvalue: localdata.use_in_property_doc?.isEmpty ??
                                    true
                                    ? ""
                                    : localdata.use_in_property_doc,
                                fieldrequired: false,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return setapptext(
                                        key: 'key_field_not_blank');
                                  }
                                },
                                onSaved: (value) {

                                  localdata.use_in_property_doc = value;
                                  print("current_use_of_property =========== $value");
                                  //_municipalityListAPI(value);
                                },
                                onChanged: (value) {
                                  setState(() {
                                    localdata.use_in_property_doc = value;
                                  });
                                  /*showLoaderDialog(context);
                                  _municipalityListAPI(value,0);

                                  setState(() {
                                    municipalityview = true;
                                    // _prograssbar = true;
                                  });*/
                                },
                              ),
                              if (localdata.use_in_property_doc == "8") ...[
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    headerlablekey:
                                        setapptext(key: 'key_Another'),
                                    radiovalue:
                                        localdata.type_of_use_other?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    initvalue:
                                        localdata.type_of_use_other?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.type_of_use_other,
                                    onSaved: (value) {
                                      localdata.type_of_use_other =
                                          value.trim();
                                    },
                                    onChanged: localdata.isdrafted == 2
                                        ? null
                                        : (value) {
                                            localdata.type_of_use_other =
                                                value.trim();
                                            setState(() {});
                                          }),
                              ]
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
                );
        },
      ),
    );
  }
}
