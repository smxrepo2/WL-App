class CustomerPackages {
  int amount;
  int duration;
  String name;
  String status;

  CustomerPackages({this.amount, this.duration, this.name, this.status});

  CustomerPackages.fromJson(Map<String, dynamic> json) {
    amount = json['Amount'];
    duration = json['Duration'];
    name = json['Name'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Amount'] = this.amount;
    data['Duration'] = this.duration;
    data['Name'] = this.name;
    data['Status'] = this.status;
    return data;
  }
}