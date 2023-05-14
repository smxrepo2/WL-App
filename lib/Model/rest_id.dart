class RestId {
  int RestuarantId;
  RestId({this.RestuarantId});
  RestId.fromJson(Map<String, dynamic> json) {
    RestuarantId = json['RestuarantId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RestuarantId'] = RestuarantId;
    return data;
  }
}
