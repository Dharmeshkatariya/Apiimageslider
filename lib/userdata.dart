class UserData {
 UserData();
  late final int id;
  late final List<String> image;
  late final String businessName;
  late final String businessType;
  late final String ownerName;
  late final String mobileNo;
  late final String address;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = List.castFrom<dynamic, String>(json['image']);
    businessName = json['businessName'];
    businessType = json['businessType'];
    ownerName = json['ownerName'];
    mobileNo = json['mobileNo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['businessName'] = businessName;
    _data['businessType'] = businessType;
    _data['ownerName'] = ownerName;
    _data['mobileNo'] = mobileNo;
    _data['address'] = address;
    return _data;
  }
}