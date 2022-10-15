/// id : ""
/// note : ""
/// shiftStartTime : 9
/// shiftStopTime : 9
/// status : true
/// resident : ""
/// user : ""

class Task {
  String _id;
  String _note;
  int _shiftStartTime;
  int _shiftStopTime;
  bool _status;
  String _resident;
  String _user;

  String get id => _id;
  String get note => _note;
  int get shiftStartTime => _shiftStartTime;
  int get shiftStopTime => _shiftStopTime;
  bool get status => _status;
  String get resident => _resident;
  String get user => _user;

  Task({
      String id, 
      String note, 
      int shiftStartTime, 
      int shiftStopTime, 
      bool status, 
      String resident, 
      String user}){
    _id = id;
    _note = note;
    _shiftStartTime = shiftStartTime;
    _shiftStopTime = shiftStopTime;
    _status = status;
    _resident = resident;
    _user = user;
}

  Task.fromJson(dynamic json) {
    _id = json["id"];
    _note = json["note"];
    _shiftStartTime = json["shiftStartTime"];
    _shiftStopTime = json["shiftStopTime"];
    _status = json["status"];
    _resident = json["resident"];
    _user = json["user"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["note"] = _note;
    map["shiftStartTime"] = _shiftStartTime;
    map["shiftStopTime"] = _shiftStopTime;
    map["status"] = _status;
    map["resident"] = _resident;
    map["user"] = _user;
    return map;
  }

}