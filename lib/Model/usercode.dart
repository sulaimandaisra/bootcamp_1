class UserCode {
  String _codetypeid;
  String _description;

  UserCode(
    this._codetypeid,
    this._description,
  );
  UserCode.map(dynamic obj) {
    this._codetypeid = obj["codetypeid"];
    this._description = obj["description"];
  }
  String get codetypeid => _codetypeid;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["codetypeid"] = _codetypeid;
    map["description"] = _description;
    return map;
  }
}
