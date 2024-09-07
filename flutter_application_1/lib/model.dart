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

class UserData {
  final int userId;
  final String userName;
  final String userMobileNumber;
  final String userMail;
  final String userDOB;
  final String userPosting;

  UserData({
    required this.userId,
    required this.userName,
    required this.userMobileNumber,
    required this.userMail,
    required this.userDOB,
    required this.userPosting,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'],
      userName: json['userName'],
      userMobileNumber: json['userMobileNumber'],
      userMail: json['userMail'],
      userDOB: json['userDOB'],
      userPosting: json['userPosting'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userMobileNumber': userMobileNumber,
      'userMail': userMail,
      'userDOB': userDOB,
      'userPosting': userPosting,
    };
  }
}
class UserAttendance {
  final int userId;
  final String userName;
  final String date;
  final AutomatedGeoAttendance? autoGeoAttendance;
  final ManualAttendance? manualGeoAttendance;

  UserAttendance({
    required this.userId,
    required this.userName,
    required this.date,
    this.autoGeoAttendance,
    this.manualGeoAttendance,
  });

  factory UserAttendance.fromJson(Map<String, dynamic> json) {
    return UserAttendance(
      userId: json['userId'],
      userName: json['userName'],
      date: json['date'],
      autoGeoAttendance: json['autoGeoAttendance'] != null
          ? AutomatedGeoAttendance.fromJson(json['autoGeoAttendance'])
          : null,
      manualGeoAttendance: json['manualGeoAttendance'] != null
          ? ManualAttendance.fromJson(json['manualGeoAttendance'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'userId': userId,
      'userName': userName,
      'date': date,
    };

    if (autoGeoAttendance != null) {
      data['autoGeoAttendance'] = autoGeoAttendance!.toJson();
    }

    if (manualGeoAttendance != null) {
      data['manualGeoAttendance'] = manualGeoAttendance!.toJson();
    }

    return data;
  }
}

class AutomatedGeoAttendance {
  final String? geoCheckIn;
  final String? geoCheckOut;
  final double? geoTotalHours;

  AutomatedGeoAttendance({
    this.geoCheckIn,
    this.geoCheckOut,
    this.geoTotalHours,
  });

  factory AutomatedGeoAttendance.fromJson(Map<String, dynamic> json) {
    return AutomatedGeoAttendance(
      geoCheckIn: json['geoCheckIn'],
      geoCheckOut: json['geoCheckOut'],
      geoTotalHours: json['geoTotalHours']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (geoCheckIn != null) {
      data['geoCheckIn'] = geoCheckIn;
    }

    if (geoCheckOut != null) {
      data['geoCheckOut'] = geoCheckOut;
    }

    if (geoTotalHours != null) {
      data['geoTotalHours'] = geoTotalHours;
    }

    return data;
  }
}

class ManualAttendance {
  final String? manualCheckIn;
  final String? manualCheckOut;
  final double? manualTotalHours;

  ManualAttendance({
    this.manualCheckIn,
    this.manualCheckOut,
    this.manualTotalHours,
  });

  factory ManualAttendance.fromJson(Map<String, dynamic> json) {
    return ManualAttendance(
      manualCheckIn: json['manualCheckIn'],
      manualCheckOut: json['manualCheckOut'],
      manualTotalHours: json['manualTotalHours']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (manualCheckIn != null) {
      data['manualCheckIn'] = manualCheckIn;
    }

    if (manualCheckOut != null) {
      data['manualCheckOut'] = manualCheckOut;
    }

    if (manualTotalHours != null) {
      data['manualTotalHours'] = manualTotalHours;
    }

    return data;
  }
}
