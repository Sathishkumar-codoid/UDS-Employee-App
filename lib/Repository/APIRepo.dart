class LanguageList {
  LanguageList(this.id, this.language);

  String? language;
  String id;
}


class SendOTP {
  String phoneNumber;

  SendOTP({
    required this.phoneNumber,
  });

  factory SendOTP.fromJson(Map<String, dynamic> json) => SendOTP(
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
  };
}
class VerifyOTP {
  String phoneNumber;
  String otp;

  VerifyOTP({
    required this.phoneNumber,
    required this.otp,
  });

  factory VerifyOTP.fromJson(Map<String, dynamic> json) => VerifyOTP(
    phoneNumber: json["phone_number"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "otp": otp,
  };
}

class EmployeeData {
  UserData userData;
  OfferLetter offerLetter;

  EmployeeData({
    required this.userData,
    required this.offerLetter,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
    userData: UserData.fromJson(json["user_data"]),
    offerLetter: OfferLetter.fromJson(json["offer_letter"]),
  );

}

class OfferLetter {
  String id;
  dynamic clientId;
  dynamic userId;
  // dynamic joiningDate;
  // dynamic endDate;
  LetterId letterId;
  // dynamic deleted;
  // bool deletedByCascade;
  // bool workingStatus;
  String jobTitle;
  String department;
  String designation;
  String grossSalary;
  // bool isFrom;
  // bool isEditable;
  // bool isActive;

  OfferLetter({
    required this.id,
    required this.clientId,
    required this.userId,
    // required this.joiningDate,
    // required this.endDate,
    required this.letterId,
    // required this.deleted,
    // required this.deletedByCascade,
    // required this.workingStatus,
    required this.jobTitle,
    required this.department,
    required this.designation,
    required this.grossSalary,
    // required this.isFrom,
    // required this.isEditable,
    // required this.isActive,

  });

  factory OfferLetter.fromJson(Map<String, dynamic> json) => OfferLetter(
    id: json["id"],
    clientId: json["client_id"],
    userId: json["user_id"],
    // joiningDate: json["joining_date"],
    // endDate: json["end_date"],
    letterId: LetterId.fromJson(json["letter_id"]),
    // deleted: json["deleted"],
    // deletedByCascade: json["deleted_by_cascade"],
    // workingStatus: json["working_status"],
    jobTitle: json["job_title"],
    department: json["department"],
    designation: json["designation"],
    grossSalary: json["gross_salary"],
    // isFrom: json["is_from"],
    // isEditable: json["is_editable"],
    // isActive: json["is_active"],

  );

}

class LetterId {
  String id;
  String mediaUrl;
  // dynamic deleted;
  // bool deletedByCascade;
  // dynamic awsUrl;
  // String fileExtension;
  // String mediaType;
  // bool isActive;


  LetterId({
    required this.id,
    required this.mediaUrl,
    // required this.deleted,
    // required this.deletedByCascade,
    // required this.awsUrl,
    // required this.fileExtension,
    // required this.mediaType,
    // required this.isActive,
  });

  factory LetterId.fromJson(Map<String, dynamic> json) => LetterId(
    id: json["id"],
    mediaUrl: json["media_url"],
    // deleted: json["deleted"],
    // deletedByCascade: json["deleted_by_cascade"],
    // awsUrl: json["aws_url"],
    // fileExtension: json["file_extension"],
    // mediaType: json["media_type"],
    // isActive: json["is_active"],
  );

}

class UserData {
  String id;
  UserRole userRole;
  List<dynamic> stateId;
  List<dynamic> regionId;
  List<dynamic> zoneId;
  dynamic userSignImage;
  dynamic userName;
  String firstName;
  String lastName;
  String email;
  String password;
  dynamic profileImage;
  dynamic title;
  String phoneNumber;
  dynamic joiningDate;
  bool passwordChanged;
  String userUid;
  String maritalStatus;
  // bool isActive;
  // DateTime createdAt;
  // DateTime modifiedAt;
  // String createdBy;
  // dynamic modifiedBy;
  // dynamic sessionId;

  UserData({
    required this.id,
    required this.userRole,
    required this.stateId,
    required this.regionId,
    required this.zoneId,
    required this.userSignImage,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.title,
    required this.phoneNumber,
    required this.joiningDate,
    required this.passwordChanged,
    required this.userUid,
    required this.maritalStatus,
    // required this.isActive,
    // required this.createdAt,
    // required this.modifiedAt,
    // required this.createdBy,
    // required this.modifiedBy,
    // required this.sessionId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    userRole: UserRole.fromJson(json["user_role"]),
    stateId: List<dynamic>.from(json["state_id"].map((x) => x)),
    regionId: List<dynamic>.from(json["region_id"].map((x) => x)),
    zoneId: List<dynamic>.from(json["zone_id"].map((x) => x)),
    userSignImage: json["user_sign_image"],
    userName: json["user_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    profileImage: json["profile_image"],
    title: json["title"],
    phoneNumber: json["phone_number"],
    joiningDate: json["joining_date"],
    passwordChanged: json["password_changed"],
    userUid: json["user_uid"],
    maritalStatus: json["marital_status"],
    // isActive: json["is_active"],
    // createdAt: DateTime.parse(json["created_at"]),
    // modifiedAt: DateTime.parse(json["modified_at"]),
    // createdBy: json["created_by"],
    // modifiedBy: json["modified_by"],
    // sessionId: json["session_id"],
  );

}

class UserRole {
  String id;
  // dynamic deleted;
  // bool deletedByCascade;
  String role;
  String description;
  // dynamic roleIcon;
  // bool isActive;
  // DateTime createdAt;
  // DateTime modifiedAt;
  // String createdBy;
  // dynamic modifiedBy;

  UserRole({
    required this.id,
    // required this.deleted,
    // required this.deletedByCascade,
    required this.role,
    required this.description,
    // required this.roleIcon,
    // required this.isActive,
    // required this.createdAt,
    // required this.modifiedAt,
    // required this.createdBy,
    // required this.modifiedBy,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
    id: json["id"],
    // deleted: json["deleted"],
    // deletedByCascade: json["deleted_by_cascade"],
    role: json["role"].toString(),
    description: json["description"].toString(),
    // roleIcon: json["role_icon"],
    // isActive: json["is_active"],
    // createdAt: DateTime.parse(json["created_at"]),
    // modifiedAt: DateTime.parse(json["modified_at"]),
    // createdBy: json["created_by"],
    // modifiedBy: json["modified_by"],
  );

}


class GetCalenderData {
  String id;
  dynamic clientId;
  dynamic shiftId;
  bool present;
  DateTime date;
  bool overDue;
  dynamic overDueTime;
  bool leave;
  bool shiftChanged;
  bool working;
  bool weekoff;
  String year;
  dynamic leaveCount;
  bool isActive;

  GetCalenderData({
    required this.id,
    required this.clientId,
    required this.shiftId,
    required this.present,
    required this.date,
    required this.overDue,
    required this.overDueTime,
    required this.leave,
    required this.shiftChanged,
    required this.working,
    required this.weekoff,
    required this.year,
    required this.leaveCount,
    required this.isActive,
  });

  factory GetCalenderData.fromJson(Map<String, dynamic> json) => GetCalenderData(
    id: json["id"],
    clientId: json["client_id"],
    shiftId: json["shift_id"],
    present: json["present"],
    date: DateTime.parse(json["date"]),
    overDue: json["over_due"],
    overDueTime: json["over_due_time"],
    leave: json["leave"],
    weekoff: json["weekoff"],
    shiftChanged: json["shift_changed"],
    working: json["working"],
    year: json["year"],
    leaveCount: json["leave_count"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "shift_id": shiftId,
    "present": present,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "over_due": overDue,
    "over_due_time": overDueTime,
    "leave": leave,
    "shift_changed": shiftChanged,
    "working": working,
    "year": year,
    "weekoff": weekoff,
    "leave_count": leaveCount,
    "is_active": isActive,
  };
}

class Attendance {
  String date;
  String year;
  String month;
  // bool? present;
  // bool? overDue;
  // String? overDueTime;
  // bool? leave;
  // bool? working;
  // bool? weekoff;
  // bool? shiftChanged;
  String checkInTime;
 // String? checkOutTime;

  Attendance({
    required  this.date,
    required this.year,
    required this.month,
     // this.present,
     // this.overDue,
     // this.overDueTime,
     // this.leave,
     // this.working,
     // this.weekoff,
     // this.shiftChanged,
    required  this.checkInTime,
    //  this.checkOutTime,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    date: json["date"],
    year: json["year"],
    month: json["month"],
   // present: json["present"],
    // overDue: json["over_due"],
    // overDueTime: json["over_due_time"],
    // leave: json["leave"],
    // working: json["working"],
    // weekoff: json["weekoff"],
    // shiftChanged: json["shift_changed"],
    checkInTime: json["check_in_time"],
    // checkOutTime: json["check_out_time"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "year": year,
    "month": month,
    // "present": present,
    // "over_due": overDue,
    // "over_due_time": overDueTime,
    // "leave": leave,
    // "working": working,
    // "weekoff": weekoff,
    // "shift_changed": shiftChanged,
    "check_in_time": checkInTime,
  //  "check_out_time": checkOutTime,
  };
}

class CheckOut {
  String date;
  String year;
  String month;
  // bool? present;
  // bool? overDue;
  // String? overDueTime;
  // bool? leave;
  // bool? working;
  // bool? weekoff;
  // bool? shiftChanged;
  //String? checkInTime;
   String checkOutTime;

  CheckOut({
    required  this.date,
    required  this.year,
    required  this.month,
    // this.present,
    // this.overDue,
    // this.overDueTime,
    // this.leave,
    // this.working,
    // this.weekoff,
    // this.shiftChanged,
   // this.checkInTime,
    required   this.checkOutTime,
  });

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
    date: json["date"],
    year: json["year"],
    month: json["month"],
    // present: json["present"],
    // overDue: json["over_due"],
    // overDueTime: json["over_due_time"],
    // leave: json["leave"],
    // working: json["working"],
    // weekoff: json["weekoff"],
    // shiftChanged: json["shift_changed"],
   // checkInTime: json["check_in_time"],
     checkOutTime: json["check_out_time"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "year": year,
    "month": month,
    // "present": present,
    // "over_due": overDue,
    // "over_due_time": overDueTime,
    // "leave": leave,
    // "working": working,
    // "weekoff": weekoff,
    // "shift_changed": shiftChanged,
    //"check_in_time": checkInTime,
      "check_out_time": checkOutTime,
  };
}
class OverTime {
  String date;
  String year;
  String month;
  // bool? present;
   bool overDue;
  // String? overDueTime;
  // bool? leave;
  // bool? working;
  // bool? weekoff;
  // bool? shiftChanged;
  //String? checkInTime;
 // String? checkOutTime;

  OverTime({
    required this.date,
    required this.year,
    required this.month,
    // this.present,
    required this.overDue,
    // this.overDueTime,
    // this.leave,
    // this.working,
    // this.weekoff,
    // this.shiftChanged,
    // this.checkInTime,
   // this.checkOutTime,
  });

  factory OverTime.fromJson(Map<String, dynamic> json) => OverTime(
    date: json["date"],
    year: json["year"],
    month: json["month"],
    // present: json["present"],
     overDue: json["over_due"],
    // overDueTime: json["over_due_time"],
    // leave: json["leave"],
    // working: json["working"],
    // weekoff: json["weekoff"],
    // shiftChanged: json["shift_changed"],
    // checkInTime: json["check_in_time"],
    //checkOutTime: json["check_out_time"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "year": year,
    "month": month,
    // "present": present,
     "over_due": overDue,
    // "over_due_time": overDueTime,
    // "leave": leave,
    // "working": working,
    // "weekoff": weekoff,
    // "shift_changed": shiftChanged,
    //"check_in_time": checkInTime,
 //   "check_out_time": checkOutTime,
  };
}



class HomeShiftDataModel {
  String id;
  String shiftName;
  String fromTime;
  String endTime;
  BranchData? branchData;

  bool checkIn;

  HomeShiftDataModel({
    required this.id,
    required this.shiftName,
    required this.fromTime,
    required this.endTime,
    required this.branchData,
    // required this.clientdData,
    required this.checkIn,
  });

  factory HomeShiftDataModel.fromJson(Map<String, dynamic> json) => HomeShiftDataModel(
    id: json["id"].toString(),
    shiftName: json["shift_name"].toString(),
    fromTime: json["from_time"],
    endTime: json["end_time"],
    branchData: json["branch_data"] !=null ? BranchData.fromJson(json["branch_data"]) : null,

    checkIn: json["check_in"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "shift_name": shiftName,
  //   "from_time": fromTime,
  //   "end_time": endTime,
  //   "branch_data": branchData.toJson(),
  //   "client_id":clientdData.toJson(),
  //   "check_in": checkIn,
  // };
}


class ClientId {
  String id;
  // dynamic deleted;
  // bool deletedByCascade;
  String? clientName;
  // String description;
  // bool isActive;
  // DateTime createdAt;
  // DateTime modifiedAt;
  // String createdBy;
  // dynamic modifiedBy;
  // dynamic logoId;
  // String? regionName;
  // String? stateId;
  // String? stateName;

  ClientId({
    required this.id,
    // required this.deleted,
    // required this.deletedByCascade,
    this.clientName,
    // required this.description,
    // required this.isActive,
    // required this.createdAt,
    // required this.modifiedAt,
    // required this.createdBy,
    // required this.modifiedBy,
    // this.logoId,
    // this.regionName,
    // this.stateId,
    // this.stateName,
  });

  factory ClientId.fromJson(Map<String, dynamic> json) => ClientId(
    id: json["id"],
    // deleted: json["deleted"],
    // deletedByCascade: json["deleted_by_cascade"],
    clientName: json["client_name"],
    // description: json["description"],
    // isActive: json["is_active"],
    // createdAt: DateTime.parse(json["created_at"]),
    // modifiedAt: DateTime.parse(json["modified_at"]),
    // createdBy: json["created_by"],
    // modifiedBy: json["modified_by"],
    // logoId: json["logo_id"],
    // regionName: json["region_name"],
    // stateId: json["state_id"],
    // stateName: json["state_name"],
  );

}

class BranchData {
  String id;
  RegionId? regionId;
  ZoneId zoneId;
  ClientId clientdData;

  BranchData({
    required this.id,
    required this.regionId,
    required this.zoneId,
    required this.clientdData,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
    id: json["id"],
    regionId: RegionId.fromJson(json["region_id"]),
    clientdData: ClientId.fromJson(json['client_id']),

    zoneId: ZoneId.fromJson(json["zone_id"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_id": regionId?.toJson(),
    "zone_id": zoneId.toJson(),

  };
}

class RegionId {
  String id;
  String regionName;
  String description;
  String stateId;

  RegionId({
    required this.id,
    required this.regionName,
    required this.description,
    required this.stateId,
  });

  factory RegionId.fromJson(Map<String, dynamic> json) => RegionId(
    id: json["id"],
    regionName: json["region_name"],
    description: json["description"],
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_name": regionName,
    "description": description,
    "state_id": stateId,
  };
}


class ZoneId {
  String id;
  String zoneName;
  String description;
  dynamic longitude;
  dynamic latitude;
  bool isActive;
  String stateId;
  String regionId;

  ZoneId({
    required this.id,
    required this.zoneName,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.isActive,
    required this.stateId,
    required this.regionId,
  });

  factory ZoneId.fromJson(Map<String, dynamic> json) => ZoneId(
    id: json["id"],
    zoneName: json["zone_name"],
    description: json["description"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    isActive: json["is_active"],
    stateId: json["state_id"],
    regionId: json["region_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "zone_name": zoneName,
    "description": description,
    "longitude": longitude,
    "latitude": latitude,
    "is_active": isActive,
    "state_id": stateId,
    "region_id": regionId,
  };
}




class LeaveType{
  String id;
  String leaveType;


  LeaveType({
    required this.id,
    required this.leaveType,


  });

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    id: json["id"],
    leaveType: json["leave_type"],

  );

}




class ApplyLeave {
  String fromDate;
  String? toDate;
  bool continueLeave;
  //String status;
  String notes;
  String userId;
  String leaveType;

  ApplyLeave({
    required this.fromDate,
    required this.toDate,
    required this.continueLeave,
   // required this.status,
    required this.notes,
    required this.userId,
    required this.leaveType,
  });

  factory ApplyLeave.fromJson(Map<String, dynamic> json) => ApplyLeave(
    fromDate: json["from_date"],
    toDate: json["to_date"],
    continueLeave: json["continue_leave"],
   // status: json["status"],
    notes: json["notes"],
    userId: json["user_id"],
    leaveType: json["leave_type"],
  );

  Map<String, dynamic> toJson() => {
    "from_date": fromDate,
    "to_date": toDate,
    "continue_leave": continueLeave,
  //  "status": status,
    "notes": notes,
    "user_id": userId,
    "leave_type": leaveType,
  };
}



class LeaveStatusType {
  String id;
  LeaveStatusData leaveType;
  DateTime fromDate;
  DateTime? toDate;
  bool continueLeave;
  String status;
  String notes;
  DateTime appliedDate;
  dynamic approvedDate;


  LeaveStatusType({
    required this.id,
    required this.leaveType,

    required this.fromDate,
    required this.toDate,
    required this.continueLeave,
    required this.status,
    required this.notes,
    required this.appliedDate,
    required this.approvedDate,

  });

  factory LeaveStatusType.fromJson(Map<String, dynamic> json) => LeaveStatusType(
    id: json["id"],

    leaveType: LeaveStatusData.fromJson(json["leave_type"]),
    fromDate: DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    continueLeave: json["continue_leave"],
    status: json["status"],
    notes: json["notes"],
    appliedDate: DateTime.parse(json["applied_date"]),
    approvedDate: json["approved_date"],

  );

}


class LeaveStatusData {
  String id;
  // dynamic deleted;
  // bool deletedByCascade;
  // dynamic fromDate;
  // dynamic toDate;
  // dynamic status;
  // dynamic notes;
  // dynamic appliedDate;
  // dynamic approvedDate;
  // bool isActive;
  // DateTime createdAt;
  // DateTime modifiedAt;
  // String createdBy;
  // dynamic modifiedBy;
  // dynamic userId;
  String leaveType;
  // dynamic certificateId;
  // dynamic clientId;
  // dynamic approverId;

  LeaveStatusData({
    required this.id,
    // required this.deleted,
    // required this.deletedByCascade,
    // required this.fromDate,
    // required this.toDate,
    // required this.status,
    // required this.notes,
    // required this.appliedDate,
    // required this.approvedDate,
    // required this.isActive,
    // required this.createdAt,
    // required this.modifiedAt,
    // required this.createdBy,
    // required this.modifiedBy,
    // required this.userId,
    required this.leaveType,
    // required this.certificateId,
    // required this.clientId,
    // required this.approverId,
  });

  factory LeaveStatusData.fromJson(Map<String, dynamic> json) => LeaveStatusData(
    id: json["id"],
    // deleted: json["deleted"],
    // deletedByCascade: json["deleted_by_cascade"],
    // fromDate: json["from_date"],
    // toDate: json["to_date"],
    // status: json["status"],
    // notes: json["notes"],
    // appliedDate: json["applied_date"],
    // approvedDate: json["approved_date"],
    // isActive: json["is_active"],
    // createdAt: DateTime.parse(json["created_at"]),
    // modifiedAt: DateTime.parse(json["modified_at"]),
    // createdBy: json["created_by"],
    // modifiedBy: json["modified_by"],
    // userId: json["user_id"],
    leaveType: json["leave_type"],
    // certificateId: json["certificate_id"],
    // clientId: json["client_id"],
    // approverId: json["approver_id"],
  );

}

class CertificateId {
  String id;
  String mediaUrl;
  // dynamic deleted;
  // bool deletedByCascade;
  // dynamic awsUrl;
  // String fileExtension;
  // String mediaType;
  // bool isActive;
  // DateTime createdAt;
  // DateTime modifiedAt;
  // dynamic createdBy;
  // dynamic modifiedBy;

  CertificateId({
    required this.id,
    required this.mediaUrl,
    // required this.deleted,
    // required this.deletedByCascade,
    // required this.awsUrl,
    // required this.fileExtension,
    // required this.mediaType,
    // required this.isActive,
    // required this.createdAt,
    // required this.modifiedAt,
    // required this.createdBy,
    // required this.modifiedBy,
  });

  factory CertificateId.fromJson(Map<String, dynamic> json) => CertificateId(
    id: json["id"],
    mediaUrl: json["media_url"],
    // deleted: json["deleted"],
    // deletedByCascade: json["deleted_by_cascade"],
    // awsUrl: json["aws_url"],
    // fileExtension: json["file_extension"],
    // mediaType: json["media_type"],
    // isActive: json["is_active"],
    // createdAt: DateTime.parse(json["created_at"]),
    // modifiedAt: DateTime.parse(json["modified_at"]),
    // createdBy: json["created_by"],
    // modifiedBy: json["modified_by"],
  );
}


class PermissionApply {
  String fromTime;
  String toTime;
  String notes;
  String userId;
  String fromdate;

  PermissionApply({
    required this.fromTime,
    required this.toTime,
    required this.notes,
    required this.userId,
    required this.fromdate,
  });

  factory PermissionApply.fromJson(Map<String, dynamic> json) => PermissionApply(
    fromTime: json["from_time"],
    toTime: json["to_time"],
    notes: json["notes"],
    userId: json["user_id"],
    fromdate: json['from_date'],
  );

  Map<String, dynamic> toJson() => {
    "from_time": fromTime,
    "to_time": toTime,
    "notes": notes,
    "user_id": userId,
    "from_date" : fromdate,
  };
}








