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
import './docverification.dart';
import './propertylocation.dart';
import './businesslicense.dart';
import './firstpartnerinfo.dart';

class PropertyDetailsPage extends StatefulWidget {
  PropertyDetailsPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  LocalPropertySurvey localdata;
  List<String> propertyUseValues = ['0'];
  Map<String, String> propertyUses={'0':"None Selected"};
  List<String> propertySubUseValues=[];
  Map<String, String> propertySubUses={};
  String selectedPropertyType;
  bool gotProperty = false;
  bool gotSubProperty = false;
  String selectedSubUse;

  int lang;

  String getLanguageCode(int id){
    switch(id){
      case 0: return '';
      case 1: return 'Pasthu';
      case 2: return 'Dari';
    }
  }


  var _formkey = GlobalKey<FormState>();

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  void _propertyUseListAPI() async {
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

  void _propertySubUseListAPI(String type, int editmode) async {
    selectedPropertyType = type;
    propertySubUseValues = ['0'];
    propertySubUses = {};
    propertySubUses['0']="None Selected";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await http.get(Configuration.apiurl + 'mPropertySubUseType?UsesType=$selectedPropertyType&active=true', headers: {
      "Content-Type": "application/json",
      "Authorization": preferences.getString("accesstoken")
    });

    if (response.statusCode == 200) {
      final data1 = json.decode(response.body);
      print('SUB wieryweionhurhg o--=-=-${data1["data"] }');

      for(dynamic item in data1["data"]){

        propertySubUseValues.add(item['value'].toString());
        propertySubUses[item['value']] = item['SubUsesType'];

      }
      propertySubUseValues = propertySubUseValues.toSet().toList();
      setState(() {
        gotSubProperty = true;
        propertySubUses = propertySubUses;
      });
      if(editmode!= 1) Navigator.pop(context);

    } else {
      throw Exception('Failed to load jobs from API');
    }
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
    print('Property sub ========${localdata.specified_current_use}');
    print('Property ========${localdata.current_use_of_property}');
    print('Property res ========${localdata.redeemable_property}');
    print('Property comm ========${localdata.proprietary_properties}');
    print('Property gov ========${localdata.govt_property}');
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
          if (localdata.property_have_document == "1") {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: DocVerificationPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else {
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
                child: PropertyLocationPage(
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
    asyncMethod();

    super.initState();
  }

  Future<void> asyncMethod() async {
    await _propertyUseListAPI();
    if(localdata.editmode==1){
     await _propertySubUseListAPI(localdata.current_use_of_property,1);
    }
    gotSubProperty=true;
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
          return (!(!(dbdata.state == AppState.Busy) && gotProperty && gotSubProperty))
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
                        formheader(headerlablekey: 'key_property_details'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata
                                              .location_of_land_area?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.location_of_land_area,
                                  iscompleted: ((localdata.location_of_land_area
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.location_of_land_area ==
                                              "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_location_land'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_1'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_2'),
                                        value: "2"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_3'),
                                        value: "3"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_4'),
                                        value: "4"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_5'),
                                        value: "5"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_6'),
                                        value: "6"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_zone_7'),
                                        value: "7"),
                                  ],
                                  onSaved: (String value) {
                                    localdata.location_of_land_area = value;
                                  },
                                  onChanged: (value) {
                                    localdata.location_of_land_area = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              formCardDropdown(
                                  fieldrequired: false,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata.property_have_document
                                              ?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.property_have_document,
                                  iscompleted: ((localdata
                                                  .property_have_document
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.property_have_document ==
                                              "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey: setapptext(
                                      key: 'key_does_properties_document'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_yes_sir'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_no'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.property_have_document = value;
                                  },
                                  onChanged: (value) {
                                    localdata.property_have_document = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              formcardtextfield6(
                                value: localdata.current_use_of_property??'0',
                                valuesList: propertyUseValues,
                                valuesMap: propertyUses,
                                enable: false,
                                keyboardtype: TextInputType.text,
                                headerlablekey:
                                setapptext(key: 'key_current_use_property_type'),
                                radiovalue:
                                ((localdata.current_use_of_property?.isEmpty ??
                                    true) ||
                                    (localdata.current_use_of_property == "0"))
                                    ? CheckColor.Black
                                    : CheckColor.Green,
                                hinttextkey:
                                setapptext(key: 'key_none_selected'),
                                initvalue: localdata.current_use_of_property?.isEmpty ??
                                    true
                                    ? ""
                                    : localdata.current_use_of_property,
                                fieldrequired: true,
                                validator: (value) {
                                  if ((value.trim().isEmpty)|| value == "0") {
                                    return setapptext(
                                        key: 'key_field_not_blank');
                                  }
                                },
                                onSaved: (value) {

                                  localdata.current_use_of_property = value.trim();
                                  print("current_use_of_property =========== $value");
                                },
                                onChanged: (value) {

                                  setState(() {
                                    selectedPropertyType = propertyUses[value];
                                    localdata.current_use_of_property = value;
                                    localdata.redeemable_property = null;
                                    localdata.proprietary_properties = null;
                                    localdata.govt_property = null;
                                    localdata.specified_current_use = null;
                                    localdata.unspecified_current_use_type =
                                    null;
                                  });
                                  print("current_use_of_property =========== $value");
                                  showLoaderDialog(context);
                                  _propertySubUseListAPI(localdata.current_use_of_property,0);
                                },

                              ),
                              if (localdata.current_use_of_property != "9"&& propertySubUseValues.length>1) ...[
                                formcardtextfield6(
                                  value: getSelectedSubUse(),
                                  valuesList: propertySubUseValues,
                                  valuesMap: propertySubUses,
                                  enable: false,
                                  keyboardtype: TextInputType.text,
                                  headerlablekey:
                                  setapptext(key: 'key_sub_usage_type'),
                                  radiovalue:
                                  ((((localdata.redeemable_property?.isEmpty ?? true)||(localdata.redeemable_property == "0"))
                                      && ((localdata.proprietary_properties?.isEmpty ?? true)||(localdata.proprietary_properties == "0"))
                                      && ((localdata.specified_current_use?.isEmpty ?? true)||(localdata.specified_current_use == "0"))
                                      && ((localdata.govt_property?.isEmpty ?? true)||(localdata.govt_property == "0"))))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  hinttextkey:
                                  setapptext(key: 'key_none_selected'),
                                  initvalue: localdata.specified_current_use?.isEmpty ??
                                      true
                                      ? ""
                                      : localdata.specified_current_use,
                                  fieldrequired: true,
                                  onSaved: (value) {
                                    if (localdata.current_use_of_property == '1') localdata.redeemable_property = value.trim();
                                    else if (localdata.current_use_of_property == '2') localdata.proprietary_properties = value.trim();
                                    else if (localdata.current_use_of_property == '3') localdata.redeemable_property = value.trim();
                                    else if (localdata.current_use_of_property == '5') localdata.govt_property = value.trim();
                                    else if (localdata.current_use_of_property == '8') localdata.specified_current_use = value.trim();


                                   // localdata.specified_current_use = value.trim();
                                    print("current_use_of_propertySub =========== $value");
                                  },
                                  onChanged: (value) {

                                    setState(() {
                                      if (localdata.current_use_of_property == '1') localdata.redeemable_property = value.trim();
                                      else if (localdata.current_use_of_property == '2') localdata.proprietary_properties = value.trim();
                                      else if (localdata.current_use_of_property == '3') localdata.redeemable_property = value.trim();
                                      else if (localdata.current_use_of_property == '5') localdata.govt_property = value.trim();
                                      else if (localdata.current_use_of_property == '8') localdata.specified_current_use = value.trim();

                                    });
                                  },
                      validator: (value) {
                        if ((value.isEmpty) || value == "0") {
                          return setapptext(key: 'key_required');
                        }
                      }
                                ),
                              ],
                              ///-------------------
                              /*
                              formCardDropdown(
                                  fieldrequired: true,
                                  enable:
                                  localdata.isdrafted == 2 ? true : false,
                                  value: localdata.current_use_of_property
                                      ?.isEmpty ??
                                      true
                                      ? "0"
                                      : localdata.current_use_of_property,
                                  iscompleted: ((localdata
                                      .current_use_of_property
                                      ?.isEmpty ??
                                      true) ||
                                      (localdata.current_use_of_property ==
                                          "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey: setapptext(
                                      key: 'key_current_use_property_type'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_release'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_commercial'),
                                        value: "2"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_complex'),
                                        value: "3"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_productive'),
                                        value: "4"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_govt'),
                                        value: "5"),
                                    Dpvalue(
                                        name:
                                        setapptext(key: 'key_agriculture'),
                                        value: "6"),
                                    Dpvalue(
                                        name:
                                        setapptext(key: 'key_block_score'),
                                        value: "7"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_demaged'),
                                        value: "10"),
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_property_type_specified'),
                                        value: "8"),
                                    Dpvalue(
                                        name: setapptext(
                                            key:
                                            'key_property_type_unspecified'),
                                        value: "9"),
                                  ],
                                  onSaved: (String value) {
                                    localdata.current_use_of_property = value;
                                  },
                                  onChanged: (value) {
                                    localdata.current_use_of_property = value;
                                    setState(() {
                                      localdata.redeemable_property = null;
                                      localdata.proprietary_properties = null;
                                      localdata.specified_current_use = null;
                                      localdata.unspecified_current_use_type =
                                      null;
                                    });
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              ///release
                              ///start
                              if (localdata.current_use_of_property == '1') ...[
                                formCardDropdown(
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value: localdata
                                                .redeemable_property?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.redeemable_property,
                                    iscompleted: ((localdata.redeemable_property
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.redeemable_property ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_Type_of_redeemable_property'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Palace'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Lease_Apartment'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Four_walls_no_building'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Under_Construction_Repairs'),
                                          value: "4"),
                                    ],
                                    onSaved: (String value) {
                                      localdata.redeemable_property = value;
                                    },
                                    onChanged: (value) {
                                      localdata.redeemable_property = value;
                                      setState(() {});
                                    },
                                    fieldrequired: true,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///commercial
                              ///start
                              if (localdata.current_use_of_property == "2") ...[
                                formCardDropdown(
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value: localdata.proprietary_properties
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.proprietary_properties,
                                    iscompleted: ((localdata
                                                    .proprietary_properties
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.proprietary_properties ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_Proprietary_Properties'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_shop'),
                                          value: "10"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Barber'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_hotel_restaurant'),
                                          value: "2"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Restaurant'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Serai'),
                                          value: "4"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Warehouse'),
                                          value: "5"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Tail_Tank'),
                                          value: "6"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Pharmacy'),
                                          value: "7"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Bathroom'),
                                          value: "8"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "9"),
                                    ],
                                    onSaved: (String value) {
                                      localdata.proprietary_properties = value;
                                    },
                                    onChanged: (value) {
                                      localdata.proprietary_properties = value;
                                      setState(() {});
                                    },
                                    fieldrequired: true,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///complex (Release / Business)
                              ///start
                              if (localdata.current_use_of_property == "3") ...[
                                formCardDropdown(
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value: localdata
                                                .redeemable_property?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.redeemable_property,
                                    iscompleted: ((localdata.redeemable_property
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.redeemable_property ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_Type_of_redeemable_property'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Palace'),
                                          value: "10"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Lease_Apartment'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Four_walls_no_building'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Under_Construction_Repairs'),
                                          value: "3"),
                                    ],
                                    onSaved: (String value) {
                                      localdata.redeemable_property = value;
                                    },
                                    onChanged: (value) {
                                      localdata.redeemable_property = value;
                                      setState(() {});
                                    },
                                    fieldrequired: true,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value: localdata.proprietary_properties
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.proprietary_properties,
                                    iscompleted: ((localdata
                                                    .proprietary_properties
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.proprietary_properties ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_Proprietary_Properties'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_shop'),
                                          value: "10"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Barber'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_hotel_restaurant'),
                                          value: "2"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Restaurant'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Serai'),
                                          value: "4"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Warehouse'),
                                          value: "5"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Tail_Tank'),
                                          value: "6"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Pharmacy'),
                                          value: "7"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Bathroom'),
                                          value: "8"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "9"),
                                    ],
                                    onSaved: (String value) {
                                      localdata.proprietary_properties = value;
                                    },
                                    onChanged: (value) {
                                      localdata.proprietary_properties = value;
                                      setState(() {});
                                    },
                                    fieldrequired: true,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///governmental
                              ///start
                              if (localdata.current_use_of_property == "5") ...[
                                formCardDropdown(
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value:
                                        localdata.govt_property?.isEmpty ?? true
                                            ? "0"
                                            : localdata.govt_property,
                                    iscompleted: ((localdata
                                                    .govt_property?.isEmpty ??
                                                true) ||
                                            (localdata.govt_property == "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_govt_proprty'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_School_Startup'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Secondary_school'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Great_school'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_University'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Learning_Center'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_hospital'),
                                          value: "6"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_clinic'),
                                          value: "7"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Playground'),
                                          value: "8"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Park'),
                                          value: "9"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Military_area'),
                                          value: "10"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_mosque'),
                                          value: "11"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Graveyard'),
                                          value: "12"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Pilgrimage'),
                                          value: "13"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "14"),
                                    ],
                                    onSaved: (String value) {
                                      localdata.govt_property = value;
                                    },
                                    onChanged: (value) {
                                      localdata.govt_property = value;
                                      setState(() {});
                                    },
                                    fieldrequired: true,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///Property Type - Other (specified)
                              ///start
                              if (localdata.current_use_of_property == "9") ...[
                                formCardDropdown(
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value: localdata.specified_current_use
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.specified_current_use,
                                    iscompleted: ((localdata
                                                    .specified_current_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.specified_current_use ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_type_of_currentuse'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Car_station'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Enough_National_Station'),
                                          value: "2"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_air_square'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Road'),
                                          value: "4"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Wasteland'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_agriculture'),
                                          value: "6"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Green_area'),
                                          value: "7"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Jungle'),
                                          value: "8"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_abc'),
                                          value: "9"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Sea'),
                                          value: "10"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Empty_land'),
                                          value: "11"),
                                    ],
                                    onSaved: (String value) {
                                      localdata.specified_current_use = value;
                                    },
                                    onChanged: (value) {
                                      localdata.specified_current_use = value;
                                      setState(() {});
                                    },
                                    fieldrequired: true,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                               */



                              ///end
                              ///Property Type - Other (unspecified)
                              ///start
                              if (localdata.current_use_of_property == "9") ...[
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue: localdata
                                                .unspecified_current_use_type
                                                ?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata
                                            .unspecified_current_use_type,
                                    headerlablekey:
                                        setapptext(key: 'key_current_usage'),
                                    radiovalue: localdata
                                                .unspecified_current_use_type
                                                ?.isEmpty ??
                                            true
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onSaved: (value) {
                                      localdata.unspecified_current_use_type =
                                          value;
                                    },
                                    onChanged: (value) {
                                      localdata.unspecified_current_use_type =
                                          value;
                                      setState(() {});
                                    })
                              ],

                              ///end
                              // draftbutton(),

                              SizedBox(
                                height: 50,
                              )
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String getSelectedSubUse() {
    if (localdata.current_use_of_property == '1') return localdata.redeemable_property;
    else if (localdata.current_use_of_property == '2') return localdata.proprietary_properties;
    else if (localdata.current_use_of_property == '3') return localdata.redeemable_property;
    else if (localdata.current_use_of_property == '5') return localdata.govt_property;
    else if (localdata.current_use_of_property == '8') return localdata.specified_current_use;
  }
}
