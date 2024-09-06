class MyData {
  final int id;
  final String username;
  final String password;
  final bool admin;
  final int branchId;

  MyData({required this.id, required this.username,required this.password,required this.admin,required this.branchId});

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      id: json['userId'],
      username: json['username'],
      password: json['password'],
      admin: json['admin'],
      branchId:json['branchId'],
    );
  }
}

class OfficeLocationData{
  final int branchId;
  final String branchName;
  final double latitude;
  final double longitude;

  OfficeLocationData({required this.branchId,required this.branchName,required this.latitude,required this.longitude});

  factory OfficeLocationData.fromJson(Map<String, dynamic> json){
    return OfficeLocationData(
      branchId: json['branchId'],
      branchName: json['branchName'],
      latitude: json['latitude'],
      longitude: json['longitude'] , 

      );
  }

}

class UserAttendance {
  final int userId;
  final String userName;
  final GeoAttendance autoGeoAttendance;
  final GeoAttendance manualGeoAttendance;

  UserAttendance({
    required this.userId,
    required this.userName,
    required this.autoGeoAttendance,
    required this.manualGeoAttendance,
  });

  factory UserAttendance.fromJson(Map<String, dynamic> json) {
    return UserAttendance(
      userId: json['userId'],
      userName: json['userName'],
      autoGeoAttendance: GeoAttendance.fromJson(json['autoGeoAttendance']),
      manualGeoAttendance: GeoAttendance.fromJson(json['manualGeoAttendance']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'autoGeoAttendance': autoGeoAttendance.toJson(),
      'manualGeoAttendance': manualGeoAttendance.toJson(),
    };
  }
}

class GeoAttendance {
  final String? checkIn;
  final String? checkOut;
  final double? totalHours;

  GeoAttendance({
    required this.checkIn,
    this.checkOut,
    this.totalHours,
  });

  factory GeoAttendance.fromJson(Map<String, dynamic> json) {
    return GeoAttendance(
      checkIn: json['geoCheckIn'] ?? json['manualCheckIn'],
      checkOut: json['geoCheckOut'] ?? json['manualCheckOut'],
      totalHours: json['geoTotalHours'] ?? json['manualTotalHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geoCheckIn': checkIn,
      'geoCheckOut': checkOut,
      'geoTotalHours': totalHours,
    };
  }
}