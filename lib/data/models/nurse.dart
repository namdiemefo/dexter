/// id : ""
/// name : ""

class Nurse {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  Nurse({
      String id, 
      String name}){
    _id = id;
    _name = name;
}

  Nurse.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}