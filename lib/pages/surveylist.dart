import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapp/pages/editpage.dart';
import 'package:kapp/pages/surveyor_list.dart';
import 'package:kapp/widgets/appformcards.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../utils/backgroundfetch.dart';
import '../models/localpropertydata.dart';
import './surveyinfo.dart';
import '../models/surveyAssignment.dart';
import '../controllers/appsync.dart';
import './task.dart';
import 'package:kapp/EditScreen/EditList1.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({this.surveyassignment, this.surveyDetails, this.surveyList});
  final SurveyAssignment surveyassignment;
  final surveyDetails;
  List surveyList;
  @override
  _SurveyPageState createState() => _SurveyPageState(surveyDetails, surveyList);
}

class _SurveyPageState extends State<SurveyPage> {
  _SurveyPageState(this.surveyDetails, this.surveyList);
  final surveyDetails;
  List surveyList;

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  double progressval = 0.0;
  List<LocalPropertySurvey> dbdata = [];

  Widget listcard({LocalPropertySurvey surveydata}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(5.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(getProvincename(surveydata.province) +
                    "-" +
                    getCity(surveydata.city) +
                    "-" +
                    surveydata.area +
                    "-" +
                    surveydata.pass +
                    "-" +
                    surveydata.block +
                    "-" +
                    surveydata.part_number +
                    "-" +
                    surveydata.unit_number),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      getStatus(surveydata.isdrafted),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(surveydata.isdrafted),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        ///edit icon
                        ((surveydata.isdrafted == 2) ||
                                (surveydata.isdrafted == 3))
                            ? //view
                            IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () async {
                                  /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyInfoPage(
                                        surveyAssignment:
                                            widget.surveyassignment,
                                        localsurveykey:
                                            surveydata.local_property_key,
                                      ),
                                    ),
                                  );*/
                                  print(
                                      "Drafetd Number Is:=${surveydata.isdrafted}");
                                  print("13136444+++++++++++++++++++++++");
                                  print(
                                      "Survey Id=${surveydata.property_dispte_subject_to}");
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString('id', "${surveydata.id}");
                                  pref.setString('taskid',surveydata.taskid);
                                  pref.setString('local_created_on',surveydata.local_created_on);
                                  pref.setString('local_property_key',surveydata.local_property_key);
                                  pref.setString('other_key',surveydata.other_key);
                                  pref.setString('first_surveyor_name',surveydata.first_surveyor_name);
                                  pref.setString('senond_surveyor_name',surveydata.senond_surveyor_name);
                                  pref.setString('technical_support_name',surveydata.technical_support_name);
                                  pref.setString('property_dispte_subject_to',surveydata.property_dispte_subject_to);
                                  pref.setString('real_person_status',surveydata.real_person_status);
                                  pref.setString('cityzenship_notice',surveydata.cityzenship_notice);
                                  pref.setString('issue_regarding_property',surveydata.issue_regarding_property);
                                  pref.setString('municipality_ref_number',surveydata.municipality_ref_number);
                                  pref.setString('natural_threaten',surveydata.natural_threaten);
                                  pref.setString('status_of_area_plan',surveydata.status_of_area_plan);
                                  pref.setString('status_of_area_official',surveydata.status_of_area_official);
                                  pref.setString('status_of_area_regular',surveydata.status_of_area_regular);
                                  pref.setString('slope_of_area',surveydata.slope_of_area);
                                  pref.setString('province',surveydata.province);
                                  pref.setString('city',surveydata.city);
                                  pref.setString('area',surveydata.area);
                                  pref.setString('pass',surveydata.pass);
                                  pref.setString('block',surveydata.block);
                                  pref.setString('part_number',surveydata.part_number);
                                  pref.setString('unit_number',surveydata.unit_number);
                                  pref.setString('unit_in_parcel',surveydata.unit_in_parcel);
                                  pref.setString('street_name',surveydata.street_name);
                                  pref.setString('historic_site_area',surveydata.historic_site_area);
                                  pref.setString('land_area',surveydata.land_area);
                                  pref.setString('property_type',surveydata.property_type);
                                  pref.setString('property_mode',surveydata.property_mode);
                                  pref.setString('location_of_land_area',surveydata.location_of_land_area);
                                  pref.setString('property_have_document',surveydata.property_have_document);
                                  pref.setString('document_type',surveydata.document_type);
                                  pref.setString('issued_on',surveydata.issued_on);
                                  pref.setString('place_of_issue',surveydata.place_of_issue);
                                  pref.setString('property_number',surveydata.property_number);
                                  pref.setString('document_cover',surveydata.document_cover);
                                  pref.setString('document_page',surveydata.document_page);
                                  pref.setString('doc_reg_number',surveydata.doc_reg_number);
                                  pref.setString('land_area_qawwala',surveydata.land_area_qawwala);
                                  pref.setString('property_doc_photo_1',surveydata.property_doc_photo_1);
                                  pref.setString('property_doc_photo_2',surveydata.property_doc_photo_2);
                                  pref.setString('property_doc_photo_3',surveydata.property_doc_photo_3);
                                  pref.setString('property_doc_photo_4',surveydata.property_doc_photo_4);
                                  pref.setString('odinary_doc_photo1',surveydata.odinary_doc_photo1);
                                  pref.setString('odinary_doc_photo6',surveydata.odinary_doc_photo6);
                                  pref.setString('use_in_property_doc',surveydata.use_in_property_doc);
                                  pref.setString('current_use_of_property',surveydata.current_use_of_property);
                                  pref.setString('type_of_use_other',surveydata.type_of_use_other);
                                  pref.setString('redeemable_property',surveydata.redeemable_property);
                                  pref.setString('proprietary_properties',surveydata.proprietary_properties);
                                  pref.setString('govt_property',surveydata.govt_property);
                                  pref.setString('specified_current_use',surveydata.specified_current_use);
                                  pref.setString('unspecified_current_use_type',surveydata.unspecified_current_use_type);
                                  pref.setString('number_of_business_unit',surveydata.number_of_business_unit);
                                  pref.setString('business_unit_have_no_license',surveydata.business_unit_have_no_license);
                                  pref.setString('business_license_another',surveydata.business_license_another);
                                  pref.setString('first_partner_name',surveydata.first_partner_name);
                                  pref.setString('first_partner_surname',surveydata.first_partner_surname);
                                  pref.setString('first_partner_boy',surveydata.first_partner_boy);
                                  pref.setString('first_partner__father',surveydata.first_partner__father);
                                  pref.setString('first_partner_name_gender',surveydata.first_partner_name_gender);
                                  pref.setString('first_partner_name_phone',surveydata.first_partner_name_phone);
                                  pref.setString('first_partner_name_email',surveydata.first_partner_name_email);
                                  pref.setString('first_partner_name_property_owner',surveydata.first_partner_name_property_owner);
                                  pref.setString('first_partner_name_mere_individuals',surveydata.first_partner_name_mere_individuals);
                                  pref.setString('info_photo_hint_sukuk_number',surveydata.info_photo_hint_sukuk_number);
                                  pref.setString('info_photo_hint_cover_note',surveydata.info_photo_hint_cover_note);
                                  pref.setString('info_photo_hint_note_page',surveydata.info_photo_hint_note_page);
                                  pref.setString('info_photo_hint_reg_no',surveydata.info_photo_hint_reg_no);
                                  pref.setString('info_photo_hint_photo_note1',surveydata.info_photo_hint_photo_note1);
                                  pref.setString('info_photo_hint_photo_tips1',surveydata.info_photo_hint_photo_tips1);
                                  pref.setString('info_photo_hint_photo_tips2',surveydata.info_photo_hint_photo_tips2);
                                  pref.setString('fore_limits_east',surveydata.fore_limits_east);
                                  pref.setString('fore_limits_west',surveydata.fore_limits_west);
                                  pref.setString('fore_limits_south',surveydata.fore_limits_south);
                                  pref.setString('fore_limits_north',surveydata.fore_limits_north);
                                  pref.setString('lightning_meter_no',surveydata.lightning_meter_no);
                                  pref.setString('lightning_common_name',surveydata.lightning_common_name);
                                  pref.setString('lightning_father_name',surveydata.lightning_father_name);
                                  pref.setString('lightning_picture_bell_power',surveydata.lightning_picture_bell_power);
                                  pref.setString('safari_booklet_common_name',surveydata.safari_booklet_common_name);
                                  pref.setString('safari_booklet_father_name',surveydata.safari_booklet_father_name);
                                  pref.setString('safari_booklet_machinegun_no',surveydata.safari_booklet_machinegun_no);
                                  pref.setString('safari_booklet_issue_date',surveydata.safari_booklet_issue_date);
                                  pref.setString('safari_booklet_picture',surveydata.safari_booklet_picture);
                                  pref.setString('property_user_owner',surveydata.property_user_owner);
                                  pref.setString('property_user_master_rent',surveydata.property_user_master_rent);
                                  pref.setString('property_user_recipient_group',surveydata.property_user_recipient_group);
                                  pref.setString('property_user_no_longer',surveydata.property_user_no_longer);
                                  pref.setString('property_user_type_of_misconduct',surveydata.property_user_type_of_misconduct);
                                  pref.setString('fst_have_building',surveydata.fst_have_building);
                                  pref.setString('fst_building_use',surveydata.fst_building_use);
                                  pref.setString('fst_building_category',surveydata.fst_building_category);
                                  pref.setString('fst_specifyif_other',surveydata.fst_specifyif_other);
                                  pref.setString('fst_no_of_floors',surveydata.fst_no_of_floors);
                                  pref.setString('fst_cubie_meter',surveydata.fst_cubie_meter);
                                  pref.setString('snd_have_building',surveydata.snd_have_building);
                                  pref.setString('snd_building_use',surveydata.snd_building_use);
                                  pref.setString('snd_building_category',surveydata.snd_building_category);
                                  pref.setString('snd_specifyif_other',surveydata.snd_specifyif_other);
                                  pref.setString('snd_no_of_floors',surveydata.snd_no_of_floors);
                                  pref.setString('snd_cubie_meter',surveydata.snd_cubie_meter);
                                  pref.setString('trd_have_building',surveydata.trd_have_building);
                                  pref.setString('trd_building_use',surveydata.trd_building_use);
                                  pref.setString('trd_building_category',surveydata.trd_building_category);
                                  pref.setString('trd_specifyif_other',surveydata.trd_specifyif_other);
                                  pref.setString('trd_no_of_floors',surveydata.trd_no_of_floors);
                                  pref.setString('trd_cubie_meter',surveydata.trd_cubie_meter);
                                  pref.setString('forth_have_building',surveydata.forth_have_building);
                                  pref.setString('forth_building_use',surveydata.forth_building_use);
                                  pref.setString('forth_building_category',surveydata.forth_building_category);
                                  pref.setString('forth_specifyif_other',surveydata.forth_specifyif_other);
                                  pref.setString('forth_no_of_floors',surveydata.forth_no_of_floors);
                                  pref.setString('forth_cubie_meter',surveydata.forth_cubie_meter);
                                  pref.setString('fth_have_building',surveydata.fth_have_building);
                                  pref.setString('fth_building_use',surveydata.fth_building_use);
                                  pref.setString('fth_building_category',surveydata.fth_building_category);
                                  pref.setString('fth_specifyif_other',surveydata.fth_specifyif_other);
                                  pref.setString('fth_no_of_floors',surveydata.fth_no_of_floors);
                                  pref.setString('fth_cubie_meter',surveydata.fth_cubie_meter);
                                  pref.setString('home_map',surveydata.home_map);
                                  pref.setString('home_photo',surveydata.home_photo);
                                  pref.setString('reg_property_fertilizer',surveydata.reg_property_fertilizer);
                                  pref.setString('area_unit_release_area',surveydata.area_unit_release_area);
                                  pref.setString('area_unit_business_area',surveydata.area_unit_business_area);
                                  pref.setString('area_unit_total_no_unit',surveydata.area_unit_total_no_unit);
                                  pref.setString('area_unit_business_units',surveydata.area_unit_business_units);
                                  pref.setString('second_partner_name',surveydata.second_partner_name);
                                  pref.setString('second_partner_surname',surveydata.second_partner_surname);
                                  pref.setString('second_partner_boy',surveydata.second_partner_boy);
                                  pref.setString('second_partner_father',surveydata.second_partner_father);
                                  pref.setString('second_partner_gender',surveydata.second_partner_gender);
                                  pref.setString('second_partner_phone',surveydata.second_partner_phone);
                                  pref.setString('second_partner_email',surveydata.second_partner_email);
                                  pref.setString('second_partner_image',surveydata.second_partner_image);
                                  pref.setString('second_partner_machinegun_no',surveydata.second_partner_machinegun_no);
                                  pref.setString('second_partner_cover_note',surveydata.second_partner_cover_note);
                                  pref.setString('second_partner_note_page',surveydata.second_partner_note_page);
                                  pref.setString('second_partner_reg_no',surveydata.second_partner_reg_no);
                                  pref.setString('second_partner_phote_note1',surveydata.second_partner_phote_note1);
                                  pref.setString('second_partner_photo_tips1',surveydata.second_partner_photo_tips1);
                                  pref.setString('second_partner_photo_tips2',surveydata.second_partner_photo_tips2);
                                  pref.setString('third_partner_name',surveydata.third_partner_name);
                                  pref.setString('third_partner_surname',surveydata.third_partner_surname);
                                  pref.setString('third_partner_boy',surveydata.third_partner_boy);
                                  pref.setString('third_partner_father',surveydata.third_partner_father);
                                  pref.setString('third_partner_gender',surveydata.third_partner_gender);
                                  pref.setString('third_partner_phone',surveydata.third_partner_phone);
                                  pref.setString('third_partner_email',surveydata.third_partner_email);
                                  pref.setString('third_partner_image',surveydata.third_partner_image);
                                  pref.setString('third_partner_machinegun_no',surveydata.third_partner_machinegun_no);
                                  pref.setString('third_partner_cover_note',surveydata.third_partner_cover_note);
                                  pref.setString('third_partner_note_page',surveydata.third_partner_note_page);
                                  pref.setString('third_partner_reg_no',surveydata.third_partner_reg_no);
                                  pref.setString('third_partner_phote_note1',surveydata.third_partner_phote_note1);
                                  pref.setString('third_partner_photo_tips1',surveydata.third_partner_photo_tips1);
                                  pref.setString('third_partner_photo_tips2',surveydata.third_partner_photo_tips2);
                                  pref.setString('fourth_partner_name',surveydata.fourth_partner_name);
                                  pref.setString('fourth_partner_surname',surveydata.fourth_partner_surname);
                                  pref.setString('fourth_partner_boy',surveydata.fourth_partner_boy);
                                  pref.setString('fourth_partner_father',surveydata.fourth_partner_father);
                                  pref.setString('fourth_partner_gender',surveydata.fourth_partner_gender);
                                  pref.setString('fourth_partner_phone',surveydata.fourth_partner_phone);
                                  pref.setString('fourth_partner_email',surveydata.fourth_partner_email);
                                  pref.setString('fourth_partner_image',surveydata.fourth_partner_image);
                                  pref.setString('fourth_partner_machinegun_no',surveydata.fourth_partner_machinegun_no);
                                  pref.setString('fourth_partner_cover_note',surveydata.fourth_partner_cover_note);
                                  pref.setString('fourth_partner_note_page',surveydata.fourth_partner_note_page);
                                  pref.setString('fourth_partner_reg_no',surveydata.fourth_partner_reg_no);
                                  pref.setString('fourth_partner_phote_note1',surveydata.fourth_partner_phote_note1);
                                  pref.setString('fourth_partner_photo_tips1',surveydata.fourth_partner_photo_tips1);
                                  pref.setString('fourth_partner_photo_tips2',surveydata.fourth_partner_photo_tips2);
                                  pref.setString('fifth_partner_name',surveydata.fifth_partner_name);
                                  pref.setString('fifth_partner_surname',surveydata.fifth_partner_surname);
                                  pref.setString('fifth_partner_boy',surveydata.fifth_partner_boy);
                                  pref.setString('fifth_partner_father',surveydata.fifth_partner_father);
                                  pref.setString('fifth_partner_gender',surveydata.fifth_partner_gender);
                                  pref.setString('fifth_partner_phone',surveydata.fifth_partner_phone);
                                  pref.setString('fifth_partner_email',surveydata.fifth_partner_email);
                                  pref.setString('fifth_partner_image',surveydata.fifth_partner_image);
                                  pref.setString('fifth_partner_machinegun_no',surveydata.fifth_partner_machinegun_no);
                                  pref.setString('fifth_partner_cover_note',surveydata.fifth_partner_cover_note);
                                  pref.setString('fifth_partner_note_page',surveydata.fifth_partner_note_page);
                                  pref.setString('fifth_partner_reg_no',surveydata.fifth_partner_reg_no);
                                  pref.setString('fifth_partner_phote_note1',surveydata.fifth_partner_phote_note1);
                                  pref.setString('fifth_partner_photo_tips1',surveydata.fifth_partner_photo_tips1);
                                  pref.setString('fifth_partner_photo_tips2',surveydata.fifth_partner_photo_tips2);
                                  pref.setString('formval','${surveydata.formval}');
                                  pref.setString('editmode','${surveydata.editmode}');
                                  pref.setString('isdrafted','${surveydata.isdrafted}');
                                  pref.setString('isrework','${surveydata.isrework}');
                                  pref.setString('boundaryinfonote','${surveydata.boundaryinfonote}');
                                  pref.setString('isreldocphoto1','${surveydata.isreldocphoto1}');
                                  pref.setString('isreldocphoto2','${surveydata.isreldocphoto2}');
                                  pref.setString('isreldocphoto3','${surveydata.isreldocphoto3}');
                                  pref.setString('isreldocphoto4','${surveydata.isreldocphoto4}');
                                  pref.setString('isoddocphoto1','${surveydata.isoddocphoto1}');
                                  pref.setString('isoddocphoto6','${surveydata.isoddocphoto6}');
                                  pref.setString('isfirstpartner_photo','${surveydata.isfirstpartner_photo}');
                                  pref.setString('isinfophotonote1','${surveydata.isinfophotonote1}');
                                  pref.setString('isinfophototips1','${surveydata.isinfophototips1}');
                                  pref.setString('isinfophototips2','${surveydata.isinfophototips2}');
                                  pref.setString('issecond_partner_photo','${surveydata.issecond_partner_photo}');
                                  pref.setString('issecond_partner_photo_note1','${surveydata.issecond_partner_photo_note1}');
                                  pref.setString('issecond_partner_photo_tips1','${surveydata.issecond_partner_photo_tips1}');
                                  pref.setString('issecond_partner_photo_tips2','${surveydata.issecond_partner_photo_tips2}');
                                  pref.setString('isthird_partner_photo','${surveydata.isthird_partner_photo}');
                                  pref.setString('isthird_partner_photo_note1','${surveydata.isthird_partner_photo_note1}');
                                  pref.setString('isthird_partner_photo_tips1','${surveydata.isthird_partner_photo_tips1}');
                                  pref.setString('isthird_partner_photo_tips2','${surveydata.isthird_partner_photo_tips2}');
                                  pref.setString('isfourth_partner_photo','${surveydata.isfourth_partner_photo}');
                                  pref.setString('isfourth_partner_photo_note1','${surveydata.isfourth_partner_photo_note1}');
                                  pref.setString('isfourth_partner_photo_tips1','${surveydata.isfourth_partner_photo_tips1}');
                                  pref.setString('isfourth_partner_photo_tips2','${surveydata.isfourth_partner_photo_tips2}');
                                  pref.setString('isfifth_partner_photo','${surveydata.isfifth_partner_photo}');
                                  pref.setString('isfifth_partner_photo_note1','${surveydata.isfifth_partner_photo_note1}');
                                  pref.setString('isfifth_partner_photo_tips1','${surveydata.isfifth_partner_photo_tips1}');
                                  pref.setString('isfifth_partner_photo_tips2','${surveydata.isfifth_partner_photo_tips2}');
                                  pref.setString('ismeter_pic_bill_power','${surveydata.ismeter_pic_bill_power}');
                                  pref.setString('issafari_booklet_pic','${surveydata.issafari_booklet_pic}');
                                  pref.setString('ishome_sketch_map','${surveydata.ishome_sketch_map}');
                                  pref.setString('ishome_photo','${surveydata.ishome_photo}');
                                  pref.setString('surveyenddate',surveydata.surveyenddate);
                                  pref.setString('surveyoroneid',surveydata.surveyoroneid);
                                  pref.setString('surveyortwoid',surveydata.surveyortwoid);
                                  pref.setString('surveyleadid',surveydata.surveyleadid);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditPage(
                                                surveyList: widget.surveyList,
                                                surveyDeatils:
                                                    widget.surveyDetails,
                                                localsurveykey: surveydata
                                                    .local_property_key,
                                              )));
                                })
                            : //edit
                            IconButton(
                                iconSize: 25,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyInfoPage(
                                        surveyAssignment:
                                            widget.surveyassignment,
                                        localsurveykey:
                                            surveydata.local_property_key,
                                        surveyDetails: widget.surveyDetails,
                                        surveyList: widget.surveyList,
                                      ),
                                    ),
                                  );
                                },
                              ),

                        ///delete icon
                        surveydata.isdrafted == 2
                            ? SizedBox()
                            : IconButton(
                                iconSize: 25,
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text(setapptext(
                                              key: 'key_want_to_delete')),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () async {
                                                DBHelper()
                                                    .deletePropertySurvey(
                                                        localkey: surveydata
                                                            .local_property_key)
                                                    .then((_) {
                                                  Navigator.pop(context);
                                                  Provider.of<DBHelper>(context)
                                                      .getpropertysurveys(
                                                          taskid: widget
                                                              .surveyassignment
                                                              .id);
                                                  setState(() {});
                                                });
                                              },
                                              child: Text(
                                                setapptext(key: 'key_delete'),
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                setapptext(key: 'key_cancel'),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                              ),
                        //upload icon
                        ((surveydata.isdrafted == 2) ||
                                (surveydata.isdrafted == 3))
                            ? SizedBox()
                            : IconButton(
                                iconSize: 25,
                                icon: Icon(
                                  Icons.file_upload,
                                  color: surveydata.isdrafted == 0
                                      ? Colors.grey
                                      : Colors.green,
                                ),
                                onPressed: () async {
                                  if (surveydata.isdrafted == 1) {
                                    //completed
                                    var result = await showDialog<bool>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return UploadData(
                                              propertydata: surveydata);
                                        });
                                    if (!(result)) {
                                      setState(() {});
                                    }
                                  } else if (surveydata.isdrafted == 0) {
                                    //if drafted
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              setapptext(key: 'key_warning'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            content: Text(setapptext(
                                                key: 'key_comp_sync')),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  setapptext(key: 'key_ok'),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                },
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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

  String getStatus(int status) {
    var result = setapptext(key: 'key_Drafted');
    switch (status) {
      case 0: //Drafted
        result = setapptext(key: 'key_Drafted');
        break;
      case 1: //Completed
        result = setapptext(key: 'key_completed');
        break;
      case 2: //Synced
        result = setapptext(key: 'key_synced');
        break;
      case 3: //exist
        result = setapptext(key: 'key_duplicate');
        break;
      default:
        result = "";
    }
    return result;
  }

  Color getStatusColor(int status) {
    Color result = Color.fromRGBO(189, 148, 36, 1);
    switch (status) {
      case 0: //Drafted
        result = Color.fromRGBO(189, 148, 36, 1);
        break;
      case 1: //Completed
        result = Colors.lightGreen;
        break;
      case 2: //Synced
        result = Colors.lightBlue;
        break;
      case 3: //exist
        result = Colors.redAccent;
        break;
    }
    return result;
  }

  void floatingactionbuttonpresed() async {
    var result = await DBHelper()
        .currentsurveycount(assignedcount: 1000, taskid: surveyDetails["_id"]);
    if (result) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                setapptext(key: 'key_warning'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              content: Text(setapptext(key: 'key_survey_excid')),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    setapptext(key: 'key_ok'),
                  ),
                ),
              ],
            );
          });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SurveyInfoPage(
            surveyDetails: surveyDetails,
            surveyList: surveyList,
            localdata: null,
            localsurveykey: null,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    print("Survey assignment---------123");
    print("SurveyAssignment is :=${widget.surveyassignment}");
    //print(surveyDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_survey_list'),
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: setapptext(key: 'key_add_property'),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SurveySearch(
                      surveyList: dbdata,
                      surveyorList: widget.surveyList,
                      surveyassignment: widget.surveyassignment,
                  surveyDetails: widget.surveyDetails,));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: DBHelper().getpropertysurveys(taskid: surveyDetails["_id"]),
        builder:
            (context, AsyncSnapshot<List<LocalPropertySurvey>> surveydata) {
          if (surveydata.connectionState == ConnectionState.done &&
              surveydata.hasData) {
            dbdata = surveydata.data;
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: dbdata?.isEmpty ?? true ? 0 : dbdata.length,
                      itemBuilder: (context, index) {
                        return listcard(surveydata: dbdata[index]);
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Container(
          child: Image(
            image: AssetImage("assets/images/addtask.png"),
          ),
        ),
        tooltip: 'Add New Survey',
        onPressed: floatingactionbuttonpresed,
      ),
    );
  }
}

class SurveySearch extends SearchDelegate<String> {
  final SurveyAssignment surveyassignment;
  final List<LocalPropertySurvey> surveyList;
  final surveyDetails;
  final List surveyorList;
  SurveySearch({this.surveyassignment, this.surveyList, this.surveyDetails, this.surveyorList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {


    String setapptext({String key}) {
      return AppTranslations.of(context).text(key);
    }

    String getStatus(int status) {
      var result = "";
      switch (status) {
        case 0: //Drafted
          result = setapptext(key: 'key_Drafted');
          break;
        case 1: //Completed
          result = setapptext(key: 'key_completed');
          break;
        case 2: //Synced
          result = setapptext(key: 'key_synced');
          break;
        default:
          result = "";
      }
      return result;
    }

    Color getStatusColor(int status) {
      Color result = Colors.transparent;
      switch (status) {
        case 0: //Drafted
          result = Color.fromRGBO(189, 148, 36, 1);
          break;
        case 1: //Completed
          result = Colors.lightGreen;
          break;
        case 2: //Synced
          result = Colors.lightBlue;
          break;
      }
      return result;
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

    final List<LocalPropertySurvey> suggestions = surveyList.where((survey){
      bool temp = false;
      String key = getProvincename(survey.province) + getCity(survey.city) +
          survey.area +
          survey.pass +
          survey.block +
          survey.part_number +
          survey.unit_number;
      if(key.toLowerCase().contains(query.replaceAll('-', '').replaceAll(' ', '').toLowerCase())) temp = true;
      if(survey.local_property_key.replaceAll('-', '').toLowerCase().contains(query.replaceAll(' ', '').replaceAll('-', '').toLowerCase())) temp = true;
      return temp;
    }).toList();

    Widget listcard({LocalPropertySurvey surveydata}) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(0.0),
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(getProvincename(surveydata.province) +
                      "-" +
                      getCity(surveydata.city) +
                      "-" +
                      surveydata.area +
                      "-" +
                      surveydata.pass +
                      "-" +
                      surveydata.block +
                      "-" +
                      surveydata.part_number +
                      "-" +
                      surveydata.unit_number),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        getStatus(surveydata.isdrafted),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(surveydata.isdrafted),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          ///edit icon
                          ((surveydata.isdrafted == 2) ||
                              (surveydata.isdrafted == 3))
                              ? //view
                          IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () async {
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyInfoPage(
                                        surveyAssignment:
                                            widget.surveyassignment,
                                        localsurveykey:
                                            surveydata.local_property_key,
                                      ),
                                    ),
                                  );*/
                                print(
                                    "Drafetd Number Is:=${surveydata.isdrafted}");
                                print("13136444+++++++++++++++++++++++");
                                print(
                                    "Survey Id=${surveydata.property_dispte_subject_to}");
                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                pref.setString('id', "${surveydata.id}");
                                pref.setString('taskid',surveydata.taskid);
                                pref.setString('local_created_on',surveydata.local_created_on);
                                pref.setString('local_property_key',surveydata.local_property_key);
                                pref.setString('other_key',surveydata.other_key);
                                pref.setString('first_surveyor_name',surveydata.first_surveyor_name);
                                pref.setString('senond_surveyor_name',surveydata.senond_surveyor_name);
                                pref.setString('technical_support_name',surveydata.technical_support_name);
                                pref.setString('property_dispte_subject_to',surveydata.property_dispte_subject_to);
                                pref.setString('real_person_status',surveydata.real_person_status);
                                pref.setString('cityzenship_notice',surveydata.cityzenship_notice);
                                pref.setString('issue_regarding_property',surveydata.issue_regarding_property);
                                pref.setString('municipality_ref_number',surveydata.municipality_ref_number);
                                pref.setString('natural_threaten',surveydata.natural_threaten);
                                pref.setString('status_of_area_plan',surveydata.status_of_area_plan);
                                pref.setString('status_of_area_official',surveydata.status_of_area_official);
                                pref.setString('status_of_area_regular',surveydata.status_of_area_regular);
                                pref.setString('slope_of_area',surveydata.slope_of_area);
                                pref.setString('province',surveydata.province);
                                pref.setString('city',surveydata.city);
                                pref.setString('area',surveydata.area);
                                pref.setString('pass',surveydata.pass);
                                pref.setString('block',surveydata.block);
                                pref.setString('part_number',surveydata.part_number);
                                pref.setString('unit_number',surveydata.unit_number);
                                pref.setString('unit_in_parcel',surveydata.unit_in_parcel);
                                pref.setString('street_name',surveydata.street_name);
                                pref.setString('historic_site_area',surveydata.historic_site_area);
                                pref.setString('land_area',surveydata.land_area);
                                pref.setString('property_type',surveydata.property_type);
                                pref.setString('property_mode',surveydata.property_mode);
                                pref.setString('location_of_land_area',surveydata.location_of_land_area);
                                pref.setString('property_have_document',surveydata.property_have_document);
                                pref.setString('document_type',surveydata.document_type);
                                pref.setString('issued_on',surveydata.issued_on);
                                pref.setString('place_of_issue',surveydata.place_of_issue);
                                pref.setString('property_number',surveydata.property_number);
                                pref.setString('document_cover',surveydata.document_cover);
                                pref.setString('document_page',surveydata.document_page);
                                pref.setString('doc_reg_number',surveydata.doc_reg_number);
                                pref.setString('land_area_qawwala',surveydata.land_area_qawwala);
                                pref.setString('property_doc_photo_1',surveydata.property_doc_photo_1);
                                pref.setString('property_doc_photo_2',surveydata.property_doc_photo_2);
                                pref.setString('property_doc_photo_3',surveydata.property_doc_photo_3);
                                pref.setString('property_doc_photo_4',surveydata.property_doc_photo_4);
                                pref.setString('odinary_doc_photo1',surveydata.odinary_doc_photo1);
                                pref.setString('odinary_doc_photo6',surveydata.odinary_doc_photo6);
                                pref.setString('use_in_property_doc',surveydata.use_in_property_doc);
                                pref.setString('current_use_of_property',surveydata.current_use_of_property);
                                pref.setString('type_of_use_other',surveydata.type_of_use_other);
                                pref.setString('redeemable_property',surveydata.redeemable_property);
                                pref.setString('proprietary_properties',surveydata.proprietary_properties);
                                pref.setString('govt_property',surveydata.govt_property);
                                pref.setString('specified_current_use',surveydata.specified_current_use);
                                pref.setString('unspecified_current_use_type',surveydata.unspecified_current_use_type);
                                pref.setString('number_of_business_unit',surveydata.number_of_business_unit);
                                pref.setString('business_unit_have_no_license',surveydata.business_unit_have_no_license);
                                pref.setString('business_license_another',surveydata.business_license_another);
                                pref.setString('first_partner_name',surveydata.first_partner_name);
                                pref.setString('first_partner_surname',surveydata.first_partner_surname);
                                pref.setString('first_partner_boy',surveydata.first_partner_boy);
                                pref.setString('first_partner__father',surveydata.first_partner__father);
                                pref.setString('first_partner_name_gender',surveydata.first_partner_name_gender);
                                pref.setString('first_partner_name_phone',surveydata.first_partner_name_phone);
                                pref.setString('first_partner_name_email',surveydata.first_partner_name_email);
                                pref.setString('first_partner_name_property_owner',surveydata.first_partner_name_property_owner);
                                pref.setString('first_partner_name_mere_individuals',surveydata.first_partner_name_mere_individuals);
                                pref.setString('info_photo_hint_sukuk_number',surveydata.info_photo_hint_sukuk_number);
                                pref.setString('info_photo_hint_cover_note',surveydata.info_photo_hint_cover_note);
                                pref.setString('info_photo_hint_note_page',surveydata.info_photo_hint_note_page);
                                pref.setString('info_photo_hint_reg_no',surveydata.info_photo_hint_reg_no);
                                pref.setString('info_photo_hint_photo_note1',surveydata.info_photo_hint_photo_note1);
                                pref.setString('info_photo_hint_photo_tips1',surveydata.info_photo_hint_photo_tips1);
                                pref.setString('info_photo_hint_photo_tips2',surveydata.info_photo_hint_photo_tips2);
                                pref.setString('fore_limits_east',surveydata.fore_limits_east);
                                pref.setString('fore_limits_west',surveydata.fore_limits_west);
                                pref.setString('fore_limits_south',surveydata.fore_limits_south);
                                pref.setString('fore_limits_north',surveydata.fore_limits_north);
                                pref.setString('lightning_meter_no',surveydata.lightning_meter_no);
                                pref.setString('lightning_common_name',surveydata.lightning_common_name);
                                pref.setString('lightning_father_name',surveydata.lightning_father_name);
                                pref.setString('lightning_picture_bell_power',surveydata.lightning_picture_bell_power);
                                pref.setString('safari_booklet_common_name',surveydata.safari_booklet_common_name);
                                pref.setString('safari_booklet_father_name',surveydata.safari_booklet_father_name);
                                pref.setString('safari_booklet_machinegun_no',surveydata.safari_booklet_machinegun_no);
                                pref.setString('safari_booklet_issue_date',surveydata.safari_booklet_issue_date);
                                pref.setString('safari_booklet_picture',surveydata.safari_booklet_picture);
                                pref.setString('property_user_owner',surveydata.property_user_owner);
                                pref.setString('property_user_master_rent',surveydata.property_user_master_rent);
                                pref.setString('property_user_recipient_group',surveydata.property_user_recipient_group);
                                pref.setString('property_user_no_longer',surveydata.property_user_no_longer);
                                pref.setString('property_user_type_of_misconduct',surveydata.property_user_type_of_misconduct);
                                pref.setString('fst_have_building',surveydata.fst_have_building);
                                pref.setString('fst_building_use',surveydata.fst_building_use);
                                pref.setString('fst_building_category',surveydata.fst_building_category);
                                pref.setString('fst_specifyif_other',surveydata.fst_specifyif_other);
                                pref.setString('fst_no_of_floors',surveydata.fst_no_of_floors);
                                pref.setString('fst_cubie_meter',surveydata.fst_cubie_meter);
                                pref.setString('snd_have_building',surveydata.snd_have_building);
                                pref.setString('snd_building_use',surveydata.snd_building_use);
                                pref.setString('snd_building_category',surveydata.snd_building_category);
                                pref.setString('snd_specifyif_other',surveydata.snd_specifyif_other);
                                pref.setString('snd_no_of_floors',surveydata.snd_no_of_floors);
                                pref.setString('snd_cubie_meter',surveydata.snd_cubie_meter);
                                pref.setString('trd_have_building',surveydata.trd_have_building);
                                pref.setString('trd_building_use',surveydata.trd_building_use);
                                pref.setString('trd_building_category',surveydata.trd_building_category);
                                pref.setString('trd_specifyif_other',surveydata.trd_specifyif_other);
                                pref.setString('trd_no_of_floors',surveydata.trd_no_of_floors);
                                pref.setString('trd_cubie_meter',surveydata.trd_cubie_meter);
                                pref.setString('forth_have_building',surveydata.forth_have_building);
                                pref.setString('forth_building_use',surveydata.forth_building_use);
                                pref.setString('forth_building_category',surveydata.forth_building_category);
                                pref.setString('forth_specifyif_other',surveydata.forth_specifyif_other);
                                pref.setString('forth_no_of_floors',surveydata.forth_no_of_floors);
                                pref.setString('forth_cubie_meter',surveydata.forth_cubie_meter);
                                pref.setString('fth_have_building',surveydata.fth_have_building);
                                pref.setString('fth_building_use',surveydata.fth_building_use);
                                pref.setString('fth_building_category',surveydata.fth_building_category);
                                pref.setString('fth_specifyif_other',surveydata.fth_specifyif_other);
                                pref.setString('fth_no_of_floors',surveydata.fth_no_of_floors);
                                pref.setString('fth_cubie_meter',surveydata.fth_cubie_meter);
                                pref.setString('home_map',surveydata.home_map);
                                pref.setString('home_photo',surveydata.home_photo);
                                pref.setString('reg_property_fertilizer',surveydata.reg_property_fertilizer);
                                pref.setString('area_unit_release_area',surveydata.area_unit_release_area);
                                pref.setString('area_unit_business_area',surveydata.area_unit_business_area);
                                pref.setString('area_unit_total_no_unit',surveydata.area_unit_total_no_unit);
                                pref.setString('area_unit_business_units',surveydata.area_unit_business_units);
                                pref.setString('second_partner_name',surveydata.second_partner_name);
                                pref.setString('second_partner_surname',surveydata.second_partner_surname);
                                pref.setString('second_partner_boy',surveydata.second_partner_boy);
                                pref.setString('second_partner_father',surveydata.second_partner_father);
                                pref.setString('second_partner_gender',surveydata.second_partner_gender);
                                pref.setString('second_partner_phone',surveydata.second_partner_phone);
                                pref.setString('second_partner_email',surveydata.second_partner_email);
                                pref.setString('second_partner_image',surveydata.second_partner_image);
                                pref.setString('second_partner_machinegun_no',surveydata.second_partner_machinegun_no);
                                pref.setString('second_partner_cover_note',surveydata.second_partner_cover_note);
                                pref.setString('second_partner_note_page',surveydata.second_partner_note_page);
                                pref.setString('second_partner_reg_no',surveydata.second_partner_reg_no);
                                pref.setString('second_partner_phote_note1',surveydata.second_partner_phote_note1);
                                pref.setString('second_partner_photo_tips1',surveydata.second_partner_photo_tips1);
                                pref.setString('second_partner_photo_tips2',surveydata.second_partner_photo_tips2);
                                pref.setString('third_partner_name',surveydata.third_partner_name);
                                pref.setString('third_partner_surname',surveydata.third_partner_surname);
                                pref.setString('third_partner_boy',surveydata.third_partner_boy);
                                pref.setString('third_partner_father',surveydata.third_partner_father);
                                pref.setString('third_partner_gender',surveydata.third_partner_gender);
                                pref.setString('third_partner_phone',surveydata.third_partner_phone);
                                pref.setString('third_partner_email',surveydata.third_partner_email);
                                pref.setString('third_partner_image',surveydata.third_partner_image);
                                pref.setString('third_partner_machinegun_no',surveydata.third_partner_machinegun_no);
                                pref.setString('third_partner_cover_note',surveydata.third_partner_cover_note);
                                pref.setString('third_partner_note_page',surveydata.third_partner_note_page);
                                pref.setString('third_partner_reg_no',surveydata.third_partner_reg_no);
                                pref.setString('third_partner_phote_note1',surveydata.third_partner_phote_note1);
                                pref.setString('third_partner_photo_tips1',surveydata.third_partner_photo_tips1);
                                pref.setString('third_partner_photo_tips2',surveydata.third_partner_photo_tips2);
                                pref.setString('fourth_partner_name',surveydata.fourth_partner_name);
                                pref.setString('fourth_partner_surname',surveydata.fourth_partner_surname);
                                pref.setString('fourth_partner_boy',surveydata.fourth_partner_boy);
                                pref.setString('fourth_partner_father',surveydata.fourth_partner_father);
                                pref.setString('fourth_partner_gender',surveydata.fourth_partner_gender);
                                pref.setString('fourth_partner_phone',surveydata.fourth_partner_phone);
                                pref.setString('fourth_partner_email',surveydata.fourth_partner_email);
                                pref.setString('fourth_partner_image',surveydata.fourth_partner_image);
                                pref.setString('fourth_partner_machinegun_no',surveydata.fourth_partner_machinegun_no);
                                pref.setString('fourth_partner_cover_note',surveydata.fourth_partner_cover_note);
                                pref.setString('fourth_partner_note_page',surveydata.fourth_partner_note_page);
                                pref.setString('fourth_partner_reg_no',surveydata.fourth_partner_reg_no);
                                pref.setString('fourth_partner_phote_note1',surveydata.fourth_partner_phote_note1);
                                pref.setString('fourth_partner_photo_tips1',surveydata.fourth_partner_photo_tips1);
                                pref.setString('fourth_partner_photo_tips2',surveydata.fourth_partner_photo_tips2);
                                pref.setString('fifth_partner_name',surveydata.fifth_partner_name);
                                pref.setString('fifth_partner_surname',surveydata.fifth_partner_surname);
                                pref.setString('fifth_partner_boy',surveydata.fifth_partner_boy);
                                pref.setString('fifth_partner_father',surveydata.fifth_partner_father);
                                pref.setString('fifth_partner_gender',surveydata.fifth_partner_gender);
                                pref.setString('fifth_partner_phone',surveydata.fifth_partner_phone);
                                pref.setString('fifth_partner_email',surveydata.fifth_partner_email);
                                pref.setString('fifth_partner_image',surveydata.fifth_partner_image);
                                pref.setString('fifth_partner_machinegun_no',surveydata.fifth_partner_machinegun_no);
                                pref.setString('fifth_partner_cover_note',surveydata.fifth_partner_cover_note);
                                pref.setString('fifth_partner_note_page',surveydata.fifth_partner_note_page);
                                pref.setString('fifth_partner_reg_no',surveydata.fifth_partner_reg_no);
                                pref.setString('fifth_partner_phote_note1',surveydata.fifth_partner_phote_note1);
                                pref.setString('fifth_partner_photo_tips1',surveydata.fifth_partner_photo_tips1);
                                pref.setString('fifth_partner_photo_tips2',surveydata.fifth_partner_photo_tips2);
                                pref.setString('formval','${surveydata.formval}');
                                pref.setString('editmode','${surveydata.editmode}');
                                pref.setString('isdrafted','${surveydata.isdrafted}');
                                pref.setString('isrework','${surveydata.isrework}');
                                pref.setString('boundaryinfonote','${surveydata.boundaryinfonote}');
                                pref.setString('isreldocphoto1','${surveydata.isreldocphoto1}');
                                pref.setString('isreldocphoto2','${surveydata.isreldocphoto2}');
                                pref.setString('isreldocphoto3','${surveydata.isreldocphoto3}');
                                pref.setString('isreldocphoto4','${surveydata.isreldocphoto4}');
                                pref.setString('isoddocphoto1','${surveydata.isoddocphoto1}');
                                pref.setString('isoddocphoto6','${surveydata.isoddocphoto6}');
                                pref.setString('isfirstpartner_photo','${surveydata.isfirstpartner_photo}');
                                pref.setString('isinfophotonote1','${surveydata.isinfophotonote1}');
                                pref.setString('isinfophototips1','${surveydata.isinfophototips1}');
                                pref.setString('isinfophototips2','${surveydata.isinfophototips2}');
                                pref.setString('issecond_partner_photo','${surveydata.issecond_partner_photo}');
                                pref.setString('issecond_partner_photo_note1','${surveydata.issecond_partner_photo_note1}');
                                pref.setString('issecond_partner_photo_tips1','${surveydata.issecond_partner_photo_tips1}');
                                pref.setString('issecond_partner_photo_tips2','${surveydata.issecond_partner_photo_tips2}');
                                pref.setString('isthird_partner_photo','${surveydata.isthird_partner_photo}');
                                pref.setString('isthird_partner_photo_note1','${surveydata.isthird_partner_photo_note1}');
                                pref.setString('isthird_partner_photo_tips1','${surveydata.isthird_partner_photo_tips1}');
                                pref.setString('isthird_partner_photo_tips2','${surveydata.isthird_partner_photo_tips2}');
                                pref.setString('isfourth_partner_photo','${surveydata.isfourth_partner_photo}');
                                pref.setString('isfourth_partner_photo_note1','${surveydata.isfourth_partner_photo_note1}');
                                pref.setString('isfourth_partner_photo_tips1','${surveydata.isfourth_partner_photo_tips1}');
                                pref.setString('isfourth_partner_photo_tips2','${surveydata.isfourth_partner_photo_tips2}');
                                pref.setString('isfifth_partner_photo','${surveydata.isfifth_partner_photo}');
                                pref.setString('isfifth_partner_photo_note1','${surveydata.isfifth_partner_photo_note1}');
                                pref.setString('isfifth_partner_photo_tips1','${surveydata.isfifth_partner_photo_tips1}');
                                pref.setString('isfifth_partner_photo_tips2','${surveydata.isfifth_partner_photo_tips2}');
                                pref.setString('ismeter_pic_bill_power','${surveydata.ismeter_pic_bill_power}');
                                pref.setString('issafari_booklet_pic','${surveydata.issafari_booklet_pic}');
                                pref.setString('ishome_sketch_map','${surveydata.ishome_sketch_map}');
                                pref.setString('ishome_photo','${surveydata.ishome_photo}');
                                pref.setString('surveyenddate',surveydata.surveyenddate);
                                pref.setString('surveyoroneid',surveydata.surveyoroneid);
                                pref.setString('surveyortwoid',surveydata.surveyortwoid);
                                pref.setString('surveyleadid',surveydata.surveyleadid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          surveyList: surveyorList,
                                          surveyDeatils:
                                          surveyDetails,
                                          localsurveykey: surveydata
                                              .local_property_key,
                                        )));
                              })
                              : //edit
                          IconButton(
                            iconSize: 25,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SurveyInfoPage(
                                        surveyAssignment: surveyassignment,
                                        localsurveykey:
                                        surveydata.local_property_key,
                                        surveyDetails: surveyDetails,
                                        surveyList: surveyorList,
                                      ),
                                ),
                              );
                            },
                          ),

                          ///delete icon
                          surveydata.isdrafted == 2
                              ? SizedBox()
                              : IconButton(
                            iconSize: 25,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text(setapptext(
                                          key: 'key_want_to_delete')),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () async {
                                            DBHelper()
                                                .deletePropertySurvey(
                                                localkey: surveydata
                                                    .local_property_key)
                                                .then((_) {
                                              Navigator.pop(context);
                                              Provider.of<DBHelper>(context)
                                                  .getpropertysurveys(
                                                  taskid: surveyassignment
                                                      .id);
                                              /* setState(() {});*/
                                            });
                                          },
                                          child: Text(
                                            setapptext(key: 'key_delete'),
                                            style: TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            setapptext(key: 'key_cancel'),
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          //upload icon
                          ((surveydata.isdrafted == 2) ||
                              (surveydata.isdrafted == 3))
                              ? SizedBox()
                              : IconButton(
                            iconSize: 25,
                            icon: Icon(
                              Icons.file_upload,
                              color: surveydata.isdrafted == 0
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            onPressed: () async {
                              if (surveydata.isdrafted == 1) {
                                //completed
                                var result = await showDialog<bool>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return UploadData(
                                          propertydata: surveydata);
                                    });
                                if (!(result)) {
                                }
                              } else if (surveydata.isdrafted == 0) {
                                //if drafted
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          setapptext(key: 'key_warning'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        content: Text(setapptext(
                                            key: 'key_comp_sync')),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              setapptext(key: 'key_ok'),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: listcard(surveydata: suggestions[index]));
          },
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {


    String setapptext({String key}) {
      return AppTranslations.of(context).text(key);
    }

    String getStatus(int status) {
      var result = "";
      switch (status) {
        case 0: //Drafted
          result = setapptext(key: 'key_Drafted');
          break;
        case 1: //Completed
          result = setapptext(key: 'key_completed');
          break;
        case 2: //Synced
          result = setapptext(key: 'key_synced');
          break;
        default:
          result = "";
      }
      return result;
    }

    Color getStatusColor(int status) {
      Color result = Colors.transparent;
      switch (status) {
        case 0: //Drafted
          result = Color.fromRGBO(189, 148, 36, 1);
          break;
        case 1: //Completed
          result = Colors.lightGreen;
          break;
        case 2: //Synced
          result = Colors.lightBlue;
          break;
      }
      return result;
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

    final List<LocalPropertySurvey> suggestions = surveyList.where((survey){
      bool temp = false;
      String key = getProvincename(survey.province) + getCity(survey.city) +
          survey.area +
          survey.pass +
          survey.block +
          survey.part_number +
          survey.unit_number;
      if(key.toLowerCase().contains(query.replaceAll('-', '').replaceAll(' ', '').toLowerCase())) temp = true;
      if(survey.local_property_key.replaceAll('-', '').toLowerCase().contains(query.replaceAll(' ', '').replaceAll('-', '').toLowerCase())) temp = true;
      return temp;
    }).toList();

    Widget listcard({LocalPropertySurvey surveydata}) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(0.0),
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(getProvincename(surveydata.province) +
                      "-" +
                      getCity(surveydata.city) +
                      "-" +
                      surveydata.area +
                      "-" +
                      surveydata.pass +
                      "-" +
                      surveydata.block +
                      "-" +
                      surveydata.part_number +
                      "-" +
                      surveydata.unit_number),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        getStatus(surveydata.isdrafted),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(surveydata.isdrafted),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          ///edit icon
                          ((surveydata.isdrafted == 2) ||
                              (surveydata.isdrafted == 3))
                              ? //view
                          IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () async {
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyInfoPage(
                                        surveyAssignment:
                                            widget.surveyassignment,
                                        localsurveykey:
                                            surveydata.local_property_key,
                                      ),
                                    ),
                                  );*/
                                print(
                                    "Drafetd Number Is:=${surveydata.isdrafted}");
                                print("13136444+++++++++++++++++++++++");
                                print(
                                    "Survey Id=${surveydata.property_dispte_subject_to}");
                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                pref.setString('id', "${surveydata.id}");
                                pref.setString('taskid',surveydata.taskid);
                                pref.setString('local_created_on',surveydata.local_created_on);
                                pref.setString('local_property_key',surveydata.local_property_key);
                                pref.setString('other_key',surveydata.other_key);
                                pref.setString('first_surveyor_name',surveydata.first_surveyor_name);
                                pref.setString('senond_surveyor_name',surveydata.senond_surveyor_name);
                                pref.setString('technical_support_name',surveydata.technical_support_name);
                                pref.setString('property_dispte_subject_to',surveydata.property_dispte_subject_to);
                                pref.setString('real_person_status',surveydata.real_person_status);
                                pref.setString('cityzenship_notice',surveydata.cityzenship_notice);
                                pref.setString('issue_regarding_property',surveydata.issue_regarding_property);
                                pref.setString('municipality_ref_number',surveydata.municipality_ref_number);
                                pref.setString('natural_threaten',surveydata.natural_threaten);
                                pref.setString('status_of_area_plan',surveydata.status_of_area_plan);
                                pref.setString('status_of_area_official',surveydata.status_of_area_official);
                                pref.setString('status_of_area_regular',surveydata.status_of_area_regular);
                                pref.setString('slope_of_area',surveydata.slope_of_area);
                                pref.setString('province',surveydata.province);
                                pref.setString('city',surveydata.city);
                                pref.setString('area',surveydata.area);
                                pref.setString('pass',surveydata.pass);
                                pref.setString('block',surveydata.block);
                                pref.setString('part_number',surveydata.part_number);
                                pref.setString('unit_number',surveydata.unit_number);
                                pref.setString('unit_in_parcel',surveydata.unit_in_parcel);
                                pref.setString('street_name',surveydata.street_name);
                                pref.setString('historic_site_area',surveydata.historic_site_area);
                                pref.setString('land_area',surveydata.land_area);
                                pref.setString('property_type',surveydata.property_type);
                                pref.setString('property_mode',surveydata.property_mode);
                                pref.setString('location_of_land_area',surveydata.location_of_land_area);
                                pref.setString('property_have_document',surveydata.property_have_document);
                                pref.setString('document_type',surveydata.document_type);
                                pref.setString('issued_on',surveydata.issued_on);
                                pref.setString('place_of_issue',surveydata.place_of_issue);
                                pref.setString('property_number',surveydata.property_number);
                                pref.setString('document_cover',surveydata.document_cover);
                                pref.setString('document_page',surveydata.document_page);
                                pref.setString('doc_reg_number',surveydata.doc_reg_number);
                                pref.setString('land_area_qawwala',surveydata.land_area_qawwala);
                                pref.setString('property_doc_photo_1',surveydata.property_doc_photo_1);
                                pref.setString('property_doc_photo_2',surveydata.property_doc_photo_2);
                                pref.setString('property_doc_photo_3',surveydata.property_doc_photo_3);
                                pref.setString('property_doc_photo_4',surveydata.property_doc_photo_4);
                                pref.setString('odinary_doc_photo1',surveydata.odinary_doc_photo1);
                                pref.setString('odinary_doc_photo6',surveydata.odinary_doc_photo6);
                                pref.setString('use_in_property_doc',surveydata.use_in_property_doc);
                                pref.setString('current_use_of_property',surveydata.current_use_of_property);
                                pref.setString('type_of_use_other',surveydata.type_of_use_other);
                                pref.setString('redeemable_property',surveydata.redeemable_property);
                                pref.setString('proprietary_properties',surveydata.proprietary_properties);
                                pref.setString('govt_property',surveydata.govt_property);
                                pref.setString('specified_current_use',surveydata.specified_current_use);
                                pref.setString('unspecified_current_use_type',surveydata.unspecified_current_use_type);
                                pref.setString('number_of_business_unit',surveydata.number_of_business_unit);
                                pref.setString('business_unit_have_no_license',surveydata.business_unit_have_no_license);
                                pref.setString('business_license_another',surveydata.business_license_another);
                                pref.setString('first_partner_name',surveydata.first_partner_name);
                                pref.setString('first_partner_surname',surveydata.first_partner_surname);
                                pref.setString('first_partner_boy',surveydata.first_partner_boy);
                                pref.setString('first_partner__father',surveydata.first_partner__father);
                                pref.setString('first_partner_name_gender',surveydata.first_partner_name_gender);
                                pref.setString('first_partner_name_phone',surveydata.first_partner_name_phone);
                                pref.setString('first_partner_name_email',surveydata.first_partner_name_email);
                                pref.setString('first_partner_name_property_owner',surveydata.first_partner_name_property_owner);
                                pref.setString('first_partner_name_mere_individuals',surveydata.first_partner_name_mere_individuals);
                                pref.setString('info_photo_hint_sukuk_number',surveydata.info_photo_hint_sukuk_number);
                                pref.setString('info_photo_hint_cover_note',surveydata.info_photo_hint_cover_note);
                                pref.setString('info_photo_hint_note_page',surveydata.info_photo_hint_note_page);
                                pref.setString('info_photo_hint_reg_no',surveydata.info_photo_hint_reg_no);
                                pref.setString('info_photo_hint_photo_note1',surveydata.info_photo_hint_photo_note1);
                                pref.setString('info_photo_hint_photo_tips1',surveydata.info_photo_hint_photo_tips1);
                                pref.setString('info_photo_hint_photo_tips2',surveydata.info_photo_hint_photo_tips2);
                                pref.setString('fore_limits_east',surveydata.fore_limits_east);
                                pref.setString('fore_limits_west',surveydata.fore_limits_west);
                                pref.setString('fore_limits_south',surveydata.fore_limits_south);
                                pref.setString('fore_limits_north',surveydata.fore_limits_north);
                                pref.setString('lightning_meter_no',surveydata.lightning_meter_no);
                                pref.setString('lightning_common_name',surveydata.lightning_common_name);
                                pref.setString('lightning_father_name',surveydata.lightning_father_name);
                                pref.setString('lightning_picture_bell_power',surveydata.lightning_picture_bell_power);
                                pref.setString('safari_booklet_common_name',surveydata.safari_booklet_common_name);
                                pref.setString('safari_booklet_father_name',surveydata.safari_booklet_father_name);
                                pref.setString('safari_booklet_machinegun_no',surveydata.safari_booklet_machinegun_no);
                                pref.setString('safari_booklet_issue_date',surveydata.safari_booklet_issue_date);
                                pref.setString('safari_booklet_picture',surveydata.safari_booklet_picture);
                                pref.setString('property_user_owner',surveydata.property_user_owner);
                                pref.setString('property_user_master_rent',surveydata.property_user_master_rent);
                                pref.setString('property_user_recipient_group',surveydata.property_user_recipient_group);
                                pref.setString('property_user_no_longer',surveydata.property_user_no_longer);
                                pref.setString('property_user_type_of_misconduct',surveydata.property_user_type_of_misconduct);
                                pref.setString('fst_have_building',surveydata.fst_have_building);
                                pref.setString('fst_building_use',surveydata.fst_building_use);
                                pref.setString('fst_building_category',surveydata.fst_building_category);
                                pref.setString('fst_specifyif_other',surveydata.fst_specifyif_other);
                                pref.setString('fst_no_of_floors',surveydata.fst_no_of_floors);
                                pref.setString('fst_cubie_meter',surveydata.fst_cubie_meter);
                                pref.setString('snd_have_building',surveydata.snd_have_building);
                                pref.setString('snd_building_use',surveydata.snd_building_use);
                                pref.setString('snd_building_category',surveydata.snd_building_category);
                                pref.setString('snd_specifyif_other',surveydata.snd_specifyif_other);
                                pref.setString('snd_no_of_floors',surveydata.snd_no_of_floors);
                                pref.setString('snd_cubie_meter',surveydata.snd_cubie_meter);
                                pref.setString('trd_have_building',surveydata.trd_have_building);
                                pref.setString('trd_building_use',surveydata.trd_building_use);
                                pref.setString('trd_building_category',surveydata.trd_building_category);
                                pref.setString('trd_specifyif_other',surveydata.trd_specifyif_other);
                                pref.setString('trd_no_of_floors',surveydata.trd_no_of_floors);
                                pref.setString('trd_cubie_meter',surveydata.trd_cubie_meter);
                                pref.setString('forth_have_building',surveydata.forth_have_building);
                                pref.setString('forth_building_use',surveydata.forth_building_use);
                                pref.setString('forth_building_category',surveydata.forth_building_category);
                                pref.setString('forth_specifyif_other',surveydata.forth_specifyif_other);
                                pref.setString('forth_no_of_floors',surveydata.forth_no_of_floors);
                                pref.setString('forth_cubie_meter',surveydata.forth_cubie_meter);
                                pref.setString('fth_have_building',surveydata.fth_have_building);
                                pref.setString('fth_building_use',surveydata.fth_building_use);
                                pref.setString('fth_building_category',surveydata.fth_building_category);
                                pref.setString('fth_specifyif_other',surveydata.fth_specifyif_other);
                                pref.setString('fth_no_of_floors',surveydata.fth_no_of_floors);
                                pref.setString('fth_cubie_meter',surveydata.fth_cubie_meter);
                                pref.setString('home_map',surveydata.home_map);
                                pref.setString('home_photo',surveydata.home_photo);
                                pref.setString('reg_property_fertilizer',surveydata.reg_property_fertilizer);
                                pref.setString('area_unit_release_area',surveydata.area_unit_release_area);
                                pref.setString('area_unit_business_area',surveydata.area_unit_business_area);
                                pref.setString('area_unit_total_no_unit',surveydata.area_unit_total_no_unit);
                                pref.setString('area_unit_business_units',surveydata.area_unit_business_units);
                                pref.setString('second_partner_name',surveydata.second_partner_name);
                                pref.setString('second_partner_surname',surveydata.second_partner_surname);
                                pref.setString('second_partner_boy',surveydata.second_partner_boy);
                                pref.setString('second_partner_father',surveydata.second_partner_father);
                                pref.setString('second_partner_gender',surveydata.second_partner_gender);
                                pref.setString('second_partner_phone',surveydata.second_partner_phone);
                                pref.setString('second_partner_email',surveydata.second_partner_email);
                                pref.setString('second_partner_image',surveydata.second_partner_image);
                                pref.setString('second_partner_machinegun_no',surveydata.second_partner_machinegun_no);
                                pref.setString('second_partner_cover_note',surveydata.second_partner_cover_note);
                                pref.setString('second_partner_note_page',surveydata.second_partner_note_page);
                                pref.setString('second_partner_reg_no',surveydata.second_partner_reg_no);
                                pref.setString('second_partner_phote_note1',surveydata.second_partner_phote_note1);
                                pref.setString('second_partner_photo_tips1',surveydata.second_partner_photo_tips1);
                                pref.setString('second_partner_photo_tips2',surveydata.second_partner_photo_tips2);
                                pref.setString('third_partner_name',surveydata.third_partner_name);
                                pref.setString('third_partner_surname',surveydata.third_partner_surname);
                                pref.setString('third_partner_boy',surveydata.third_partner_boy);
                                pref.setString('third_partner_father',surveydata.third_partner_father);
                                pref.setString('third_partner_gender',surveydata.third_partner_gender);
                                pref.setString('third_partner_phone',surveydata.third_partner_phone);
                                pref.setString('third_partner_email',surveydata.third_partner_email);
                                pref.setString('third_partner_image',surveydata.third_partner_image);
                                pref.setString('third_partner_machinegun_no',surveydata.third_partner_machinegun_no);
                                pref.setString('third_partner_cover_note',surveydata.third_partner_cover_note);
                                pref.setString('third_partner_note_page',surveydata.third_partner_note_page);
                                pref.setString('third_partner_reg_no',surveydata.third_partner_reg_no);
                                pref.setString('third_partner_phote_note1',surveydata.third_partner_phote_note1);
                                pref.setString('third_partner_photo_tips1',surveydata.third_partner_photo_tips1);
                                pref.setString('third_partner_photo_tips2',surveydata.third_partner_photo_tips2);
                                pref.setString('fourth_partner_name',surveydata.fourth_partner_name);
                                pref.setString('fourth_partner_surname',surveydata.fourth_partner_surname);
                                pref.setString('fourth_partner_boy',surveydata.fourth_partner_boy);
                                pref.setString('fourth_partner_father',surveydata.fourth_partner_father);
                                pref.setString('fourth_partner_gender',surveydata.fourth_partner_gender);
                                pref.setString('fourth_partner_phone',surveydata.fourth_partner_phone);
                                pref.setString('fourth_partner_email',surveydata.fourth_partner_email);
                                pref.setString('fourth_partner_image',surveydata.fourth_partner_image);
                                pref.setString('fourth_partner_machinegun_no',surveydata.fourth_partner_machinegun_no);
                                pref.setString('fourth_partner_cover_note',surveydata.fourth_partner_cover_note);
                                pref.setString('fourth_partner_note_page',surveydata.fourth_partner_note_page);
                                pref.setString('fourth_partner_reg_no',surveydata.fourth_partner_reg_no);
                                pref.setString('fourth_partner_phote_note1',surveydata.fourth_partner_phote_note1);
                                pref.setString('fourth_partner_photo_tips1',surveydata.fourth_partner_photo_tips1);
                                pref.setString('fourth_partner_photo_tips2',surveydata.fourth_partner_photo_tips2);
                                pref.setString('fifth_partner_name',surveydata.fifth_partner_name);
                                pref.setString('fifth_partner_surname',surveydata.fifth_partner_surname);
                                pref.setString('fifth_partner_boy',surveydata.fifth_partner_boy);
                                pref.setString('fifth_partner_father',surveydata.fifth_partner_father);
                                pref.setString('fifth_partner_gender',surveydata.fifth_partner_gender);
                                pref.setString('fifth_partner_phone',surveydata.fifth_partner_phone);
                                pref.setString('fifth_partner_email',surveydata.fifth_partner_email);
                                pref.setString('fifth_partner_image',surveydata.fifth_partner_image);
                                pref.setString('fifth_partner_machinegun_no',surveydata.fifth_partner_machinegun_no);
                                pref.setString('fifth_partner_cover_note',surveydata.fifth_partner_cover_note);
                                pref.setString('fifth_partner_note_page',surveydata.fifth_partner_note_page);
                                pref.setString('fifth_partner_reg_no',surveydata.fifth_partner_reg_no);
                                pref.setString('fifth_partner_phote_note1',surveydata.fifth_partner_phote_note1);
                                pref.setString('fifth_partner_photo_tips1',surveydata.fifth_partner_photo_tips1);
                                pref.setString('fifth_partner_photo_tips2',surveydata.fifth_partner_photo_tips2);
                                pref.setString('formval','${surveydata.formval}');
                                pref.setString('editmode','${surveydata.editmode}');
                                pref.setString('isdrafted','${surveydata.isdrafted}');
                                pref.setString('isrework','${surveydata.isrework}');
                                pref.setString('boundaryinfonote','${surveydata.boundaryinfonote}');
                                pref.setString('isreldocphoto1','${surveydata.isreldocphoto1}');
                                pref.setString('isreldocphoto2','${surveydata.isreldocphoto2}');
                                pref.setString('isreldocphoto3','${surveydata.isreldocphoto3}');
                                pref.setString('isreldocphoto4','${surveydata.isreldocphoto4}');
                                pref.setString('isoddocphoto1','${surveydata.isoddocphoto1}');
                                pref.setString('isoddocphoto6','${surveydata.isoddocphoto6}');
                                pref.setString('isfirstpartner_photo','${surveydata.isfirstpartner_photo}');
                                pref.setString('isinfophotonote1','${surveydata.isinfophotonote1}');
                                pref.setString('isinfophototips1','${surveydata.isinfophototips1}');
                                pref.setString('isinfophototips2','${surveydata.isinfophototips2}');
                                pref.setString('issecond_partner_photo','${surveydata.issecond_partner_photo}');
                                pref.setString('issecond_partner_photo_note1','${surveydata.issecond_partner_photo_note1}');
                                pref.setString('issecond_partner_photo_tips1','${surveydata.issecond_partner_photo_tips1}');
                                pref.setString('issecond_partner_photo_tips2','${surveydata.issecond_partner_photo_tips2}');
                                pref.setString('isthird_partner_photo','${surveydata.isthird_partner_photo}');
                                pref.setString('isthird_partner_photo_note1','${surveydata.isthird_partner_photo_note1}');
                                pref.setString('isthird_partner_photo_tips1','${surveydata.isthird_partner_photo_tips1}');
                                pref.setString('isthird_partner_photo_tips2','${surveydata.isthird_partner_photo_tips2}');
                                pref.setString('isfourth_partner_photo','${surveydata.isfourth_partner_photo}');
                                pref.setString('isfourth_partner_photo_note1','${surveydata.isfourth_partner_photo_note1}');
                                pref.setString('isfourth_partner_photo_tips1','${surveydata.isfourth_partner_photo_tips1}');
                                pref.setString('isfourth_partner_photo_tips2','${surveydata.isfourth_partner_photo_tips2}');
                                pref.setString('isfifth_partner_photo','${surveydata.isfifth_partner_photo}');
                                pref.setString('isfifth_partner_photo_note1','${surveydata.isfifth_partner_photo_note1}');
                                pref.setString('isfifth_partner_photo_tips1','${surveydata.isfifth_partner_photo_tips1}');
                                pref.setString('isfifth_partner_photo_tips2','${surveydata.isfifth_partner_photo_tips2}');
                                pref.setString('ismeter_pic_bill_power','${surveydata.ismeter_pic_bill_power}');
                                pref.setString('issafari_booklet_pic','${surveydata.issafari_booklet_pic}');
                                pref.setString('ishome_sketch_map','${surveydata.ishome_sketch_map}');
                                pref.setString('ishome_photo','${surveydata.ishome_photo}');
                                pref.setString('surveyenddate',surveydata.surveyenddate);
                                pref.setString('surveyoroneid',surveydata.surveyoroneid);
                                pref.setString('surveyortwoid',surveydata.surveyortwoid);
                                pref.setString('surveyleadid',surveydata.surveyleadid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          surveyList: surveyorList,
                                          surveyDeatils:
                                          surveyDetails,
                                          localsurveykey: surveydata
                                              .local_property_key,
                                        )));
                              })
                              : //edit
                          IconButton(
                            iconSize: 25,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SurveyInfoPage(
                                        surveyAssignment: surveyassignment,
                                        localsurveykey:
                                        surveydata.local_property_key,
                                        surveyDetails: surveyDetails,
                                        surveyList: surveyorList,
                                      ),
                                ),
                              );
                            },
                          ),

                          ///delete icon
                          surveydata.isdrafted == 2
                              ? SizedBox()
                              : IconButton(
                            iconSize: 25,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text(setapptext(
                                          key: 'key_want_to_delete')),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () async {
                                            DBHelper()
                                                .deletePropertySurvey(
                                                localkey: surveydata
                                                    .local_property_key)
                                                .then((_) {
                                              Navigator.pop(context);
                                              Provider.of<DBHelper>(context)
                                                  .getpropertysurveys(
                                                  taskid: surveyassignment
                                                      .id);
                                             /* setState(() {});*/
                                            });
                                          },
                                          child: Text(
                                            setapptext(key: 'key_delete'),
                                            style: TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            setapptext(key: 'key_cancel'),
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          //upload icon
                          ((surveydata.isdrafted == 2) ||
                              (surveydata.isdrafted == 3))
                              ? SizedBox()
                              : IconButton(
                            iconSize: 25,
                            icon: Icon(
                              Icons.file_upload,
                              color: surveydata.isdrafted == 0
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                            onPressed: () async {
                              if (surveydata.isdrafted == 1) {
                                //completed
                                var result = await showDialog<bool>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return UploadData(
                                          propertydata: surveydata);
                                    });
                                if (!(result)) {
                                }
                              } else if (surveydata.isdrafted == 0) {
                                //if drafted
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          setapptext(key: 'key_warning'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        content: Text(setapptext(
                                            key: 'key_comp_sync')),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              setapptext(key: 'key_ok'),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: listcard(surveydata: suggestions[index]));
              },
            )
    );
  }
}

class UploadData extends StatefulWidget {
  UploadData({this.propertydata});
  final LocalPropertySurvey propertydata;
  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  double progressval = 0.0;
  String msgvalue = "";
  bool selectenable = true;
  void _setUploadProgress(int sentBytes, int totalBytes) {
    double __progressValue =
        remap(sentBytes.toDouble(), 0, totalBytes.toDouble(), 0, 1);

    __progressValue = double.parse(__progressValue.toStringAsFixed(2));

    if (__progressValue != progressval)
      setState(() {
        progressval = __progressValue;
      });
  }

  static double remap(
      double value,
      double originalMinValue,
      double originalMaxValue,
      double translatedMinValue,
      double translatedMaxValue) {
    if (originalMaxValue - originalMinValue == 0) return 0;
    return (value - originalMinValue) /
            (originalMaxValue - originalMinValue) *
            (translatedMaxValue - translatedMinValue) +
        translatedMinValue;
  }

  @override
  void initState() {
    _setUploadProgress(0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                setapptext(key: 'key_sync_survey_data'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            //progress bar
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: LinearProgressIndicator(value: progressval),
            ),
            //start button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: selectenable
                          ? () async {
                              var sp = await SharedPreferences.getInstance();
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                setState(() {
                                  selectenable = false;
                                  msgvalue =
                                      setapptext(key: 'key_validate_user_data');
                                });
                                // var r = await AppSync().validateUserData(
                                //     taskid: widget.propertydata.taskid);
                                var r = true;
                                if (r) {
                                  setState(() {
                                    msgvalue =
                                        setapptext(key: 'key_sync_progress');
                                  });
                                  var result = await AppSync().fileUpload(
                                      propertydata: widget.propertydata,
                                      uploadpreogress: _setUploadProgress);
                                  if (result) {
                                    sp.setString(
                                        "lastsync", DateTime.now().toString());
                                    // await DBHelper().updateTaskSyncStatus(
                                    //     taskid: widget.propertydata.taskid);
                                    await BackGroundSync().startSync();
                                    print(widget
                                        .propertydata.lightning_common_name);
                                    print(widget
                                        .propertydata.lightning_father_name);
                                    print(widget.propertydata
                                        .safari_booklet_common_name);
                                    print(widget.propertydata
                                        .safari_booklet_father_name);
                                    print('${widget.propertydata}');

                                    setState(() {
                                      msgvalue =
                                          setapptext(key: 'key_sync_completed');
                                      selectenable = false;
                                    });
                                    Future.delayed(Duration(seconds: 1), () {
                                      Navigator.of(context).pop(false);
                                      /*Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (BuildContext context) => EditPage()));*/
                                    });
                                  } else {
                                    setState(() {
                                      msgvalue =
                                          setapptext(key: 'key_sync_failed');
                                    });
                                  }
                                } else {
                                  setState(() {
                                    msgvalue =
                                        setapptext(key: 'key_sync_failed');
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            setapptext(key: 'key_warning'),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          content: Text(
                                            setapptext(
                                                key: 'key_uservalidate_msg'),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () async {
                                                //delete whole task and its property survey
                                                int res = await DBHelper()
                                                    .deleteSurveyList(
                                                        id: widget.propertydata
                                                            .taskid);
                                                if (res != 0) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          TaskPage(),
                                                    ),
                                                  );
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            setapptext(
                                                                key:
                                                                    'key_warning'),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          content: Text(setapptext(
                                                              key:
                                                                  'key_something_wrong')),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                setapptext(
                                                                    key:
                                                                        'key_ok'),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }
                                              },
                                              child: Text(
                                                setapptext(key: 'key_ok'),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                setapptext(key: 'key_Cancel'),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          setapptext(key: 'key_warning'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        content: Text(setapptext(
                                            key: 'key_ckeck_internet')),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              setapptext(key: 'key_ok'),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          : null,
                      child: Text(setapptext(key: 'key_start')),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        setapptext(key: "key_Cancel"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //message
            Container(
              child: Text(msgvalue),
            )
          ],
        ),
      ),
    );
  }
}
