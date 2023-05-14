class Global {
  String mockBaseUrl;
  String laravelBaseUrl;
  String apiPath;

  Global({this.mockBaseUrl, this.laravelBaseUrl, this.apiPath});

  Global.fromJson(Map<String, dynamic> json) {
    mockBaseUrl = json['mock_base_url'].toString();
    laravelBaseUrl = json['laravel_base_url'].toString();
    apiPath = json['api_path'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mock_base_url'] = mockBaseUrl;
    data['laravel_base_url'] = laravelBaseUrl;
    data['api_path'] = apiPath;
    return data;
  }
}
