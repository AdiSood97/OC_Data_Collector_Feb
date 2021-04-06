import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kapp/utils/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/appdrawer.dart';
import '../models/localpropertydata.dart';
import '../localization/app_translations.dart';
import '../controllers/reworktask.dart';
import '../models/reworkassignment.dart';
import './surveyinfo.dart';
import './surveylist.dart';
import '../models/surveyAssignment.dart';



class ReworkTaskPage extends StatefulWidget {
  @override
  _ReworkTaskPageState createState() => _ReworkTaskPageState();
}

class _ReworkTaskPageState extends State<ReworkTaskPage> {
  List surveyList;
  SurveyAssignment surveyAssignment;
  bool _prograssbar = true;
  List<LocalPropertySurvey> surveys = [];
  List<ReworkAssignment> availableReworkAssignment = [];
  int currStatus = 0;

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  void _fetchJobs() async {
    var preferences = await SharedPreferences.getInstance();
    var role_id = preferences.getString("new_role_id");
    print("+++++-----------888888888888888888888888888");

    print(role_id);
    final jobsListAPIUrl =
        'http://13.234.225.179:3002/users?role_id=${role_id}';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      final data1 = json.decode(response.body);
      print("surveylist ============ ${data1}");
      setState(() {
        surveyList = data1["data"];
        _prograssbar = false;
      });
      // return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  void convertToSurveyAssignment({ReworkAssignment reworkAssignment}) {
    surveyAssignment = new SurveyAssignment();
    surveyAssignment.id = reworkAssignment.sid;
    surveyAssignment.teamlead = reworkAssignment.surveylead;
    surveyAssignment.teamleadname = reworkAssignment.surveyleadname;
    surveyAssignment.surveyor1 = reworkAssignment.surveyor1;
    surveyAssignment.surveyoronename = reworkAssignment.surveyoronename;
    surveyAssignment.surveyor2 = reworkAssignment.surveyor2;
    surveyAssignment.surveyortwoname = reworkAssignment.surveyortwoname;
    surveyAssignment.province = reworkAssignment.province;
    surveyAssignment.municpality = reworkAssignment.municipality;
    surveyAssignment.nahia = reworkAssignment.nahia;
    surveyAssignment.gozar = reworkAssignment.gozar;
    surveyAssignment.block = reworkAssignment.block;
    surveyAssignment.startDate = reworkAssignment.createdate;
    surveyAssignment.taskStatus = reworkAssignment.surveystatus;
    surveyAssignment.reworkstatus = reworkAssignment.status;
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
      case 3: //Synced
        result = setapptext(key: 'key_synced');
        break;
      default:
        result = "";
    }
    return result;
  }

  void reorderSurveylist() {
    List<LocalPropertySurvey> temp = [];
    String localkey;
    ReworkAssignment id;
    for (int i = 0; i < availableReworkAssignment.length; i++) {
      id = availableReworkAssignment[i];
      localkey = id.province +
          id.municipality +
          id.nahia +
          id.gozar +
          id.block +
          id.parcelno +
          id.unit;
      for (int j = 0; j < surveys.length; j++) {
        if (surveys[j].local_property_key == localkey) {
          temp.add(surveys[j]);
        }
      }
    }
    surveys = temp;
  }

  int removeAssignmentsNotAvailable({List<ReworkAssignment> data}) {
    availableReworkAssignment =[];
    //List<ReworkAssignment>
    String localkey;
    ReworkAssignment id;
    for (int j = 0; j < data.length; j++) {
      id = data[j];
      localkey = id.province +
          id.municipality +
          id.nahia +
          id.gozar +
          id.block +
          id.parcelno +
          id.unit;
      for (int i = 0; i < surveys.length; i++) {
        if (surveys[i].local_property_key == localkey) {
          availableReworkAssignment.add(id);
        }
      }
    }
  }

  Widget listcard({ReworkAssignment id,
    String provinance,
    String nahia,
    String gozar,
    String assigndate,
    LocalPropertySurvey surveydata}) {
    return Card(
      elevation: 3.0,
      child: Container(
        decoration: BoxDecoration(
          //color: Color.fromRGBO(242, 239, 230, 1),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                id.province + "-" + id.nahia + "-" + id.gozar + "-" + id.block +
                    "-" + id.parcelno + "-" + id.unit,
                style: TextStyle(fontWeight: FontWeight.bold),
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
                        surveydata.isdrafted == 2
                            ? IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              convertToSurveyAssignment(reworkAssignment: id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SurveyInfoPage(
                                        surveyAssignment: surveyAssignment,
                                        localsurveykey:
                                        surveydata.local_property_key,
                                        localdata: surveydata,
                                        surveyList: surveyList,
                                      ),
                                ),
                              );
                            })
                            : IconButton(
                          iconSize: 25,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            convertToSurveyAssignment(reworkAssignment: id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SurveyInfoPage(
                                      surveyAssignment: surveyAssignment,
                                      localsurveykey:
                                      surveydata.local_property_key,
                                      localdata: surveydata,
                                      surveyList: surveyList,
                                    ),
                              ),
                            );
                          },
                        ),
                        //upload icon
                        surveydata.isdrafted == 2
                            ? SizedBox()
                            : IconButton(
                          iconSize: 25,
                          icon: Icon(
                            Icons.file_upload,
                            color: (surveydata.isdrafted == 0 || surveydata.isdrafted == 3)
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
            Divider(),
            Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(setapptext(key: 'key_enter_any_mere')),
                        subtitle: Text(id.remarks),
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_assigned_date'),
                        ),
                        Text(
                          DateFormat.yMd().format(
                            DateTime.parse(assigndate),
                          ),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    surveys = await DBHelper().getallpropertysurveys();
    _fetchJobs();
  }

  List<LocalPropertySurvey> propertyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_rework'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: ReworkTask().getReworkAssignments(),
        builder: (context, AsyncSnapshot<List<ReworkAssignment>> assignments) {
          //print(assignments);
          if (assignments.connectionState == ConnectionState.done &&
              assignments.hasData) {
            List<ReworkAssignment> data = assignments.data;
            removeAssignmentsNotAvailable(data: data);
            reorderSurveylist();
            print(data[0].surveyoronename);
            //_fetchJobs();
            return Column(
              children: <Widget>[
                availableReworkAssignment.isEmpty ?? true
                    ? Expanded(
                  child: Center(
                    child: Text(setapptext(key: 'key_no_survey'),
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
                    : Expanded(
                  child: ListView.builder(
                    itemCount: availableReworkAssignment?.isEmpty ?? true
                        ? 0
                        : availableReworkAssignment.length,
                    itemBuilder: (context, index) {
                      /* propertyData = DBHelper().getpropertysurveys(
                                localkey: (data[index].province +
                                    data[index].municipality +
                                    data[index].nahia +
                                    data[index].gozar +
                                    data[index].block +
                                    data[index].parcelno +
                                    data[index].unit)) as List<LocalPropertySurvey>;*/
                      return listcard(
                          id: availableReworkAssignment[index] == null
                              ? new ReworkAssignment()
                              : availableReworkAssignment[index],
                          provinance:
                          availableReworkAssignment[index].province?.isEmpty ??
                              true
                              ? ""
                              : availableReworkAssignment[index].province,
                          nahia: availableReworkAssignment[index].nahia
                              ?.isEmpty ?? true
                              ? ""
                              : availableReworkAssignment[index].nahia,
                          gozar: availableReworkAssignment[index].gozar
                              ?.isEmpty ?? true
                              ? ""
                              : availableReworkAssignment[index].gozar,
                          assigndate:
                          availableReworkAssignment[index].createdate
                              ?.isEmpty ?? true
                              ? ""
                              : availableReworkAssignment[index].createdate,
                          surveydata: surveys[index]
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
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
      case 3: //Synced
        result = Colors.lightBlue;
        break;
    }
    return result;
  }
}
