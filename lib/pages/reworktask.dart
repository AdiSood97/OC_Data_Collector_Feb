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
import './reworklist.dart';

class ReworkTaskPage extends StatefulWidget {
  @override
  _ReworkTaskPageState createState() => _ReworkTaskPageState();
}

class _ReworkTaskPageState extends State<ReworkTaskPage> {
  List<LocalPropertySurvey> surveys = [];
  int currStatus = 0;
  
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  String workstatus({int status}) {
    var result = setapptext(key: 'key_not_started');
    if(status != null) {
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
    }
    return result;
  }
  int getStatus( {ReworkAssignment id}){
    int status;
    String localkey = id.province +
        id.municipality +
        id.nahia +
        id.gozar +
        id.block +
        id.parcelno +
        id.unit;
    for(int i = 0; i<surveys.length; i++){
      if(surveys[i].local_property_key == localkey){
        status = surveys[i].isdrafted;
      }
    }
    currStatus = status;
    return status;
  }

  Color workstatuscolor({int status}) {
    Color result = Color.fromRGBO(189, 148, 36, 1);
    if(status != null) {
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
    }
    return result;
  }

  Widget listcard(
      {ReworkAssignment id,
      String status,
      Color statuscolor,
      String provinance,
      String nahia,
      String gozar,
      String assigndate}) {
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
                id.province + "-" + id.nahia + "-" + id.gozar+"-"+id.block+"-"+id.parcelno+"-"+id.unit,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  direction: Axis.vertical,
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
                Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text(
                      setapptext(key: 'key_status'),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          color: statuscolor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RewokListPage(
                      sid: id,

                    ),
                  ),
                );
                print(id);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(blurRadius: 5.0, color: Colors.black)
                      ],
                      color: Colors.blue),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3.5,
                    right: MediaQuery.of(context).size.width / 3.5,
                  ),
                  child: Center(
                    child: Text(
                      setapptext(key: 'key_continue'),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
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
  }

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
            print(data[0].surveyoronename);
           //_fetchJobs();
            return Column(
              children: <Widget>[
                data.isEmpty ?? true
                    ? Expanded(
                        child: Center(
                          child: Text(setapptext(key: 'key_no_survey'),style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: data?.isEmpty ?? true ? 0 : data.length,
                          itemBuilder: (context, index) {
                            print("$index status: ${data[index].status}");
                            print("$index appstatus: ${data[index].appstatus}");
                            print("$index surveystatus: ${data[index].surveystatus}");
                            return listcard(
                                id: data[index] == null
                                    ? new ReworkAssignment()
                                    : data[index],
                                provinance:
                                    data[index].province?.isEmpty ?? true
                                        ? ""
                                        : data[index].province,
                                nahia: data[index].nahia?.isEmpty ?? true
                                    ? ""
                                    : data[index].nahia,
                                gozar: data[index].gozar?.isEmpty ?? true
                                    ? ""
                                    : data[index].gozar,
                                assigndate:
                                    data[index].createdate?.isEmpty ?? true
                                        ? ""
                                        : data[index].createdate,
                                status:
                                    workstatus(status: getStatus(id:data[index])),
                                statuscolor: workstatuscolor(
                                    status: currStatus));
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
}
