/// id : ""
/// name : ""
/// startTime : 9
/// stopTime : 14

class Shift {
  String _id;
  String _name;
  int _startTime;
  int _stopTime;

  String get id => _id;
  String get name => _name;
  int get startTime => _startTime;
  int get stopTime => _stopTime;

  Shift({
      String id, 
      String name, 
      int startTime, 
      int stopTime}){
    _id = id;
    _name = name;
    _startTime = startTime;
    _stopTime = stopTime;
}

  Shift.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _startTime = json["startTime"];
    _stopTime = json["stopTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["startTime"] = _startTime;
    map["stopTime"] = _stopTime;
    return map;
  }

}