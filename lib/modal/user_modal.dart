class UserModal {
   String? name;
   String email;
   String phoneNumber;
   String userId;
   String profilePic;
   String? permis;

  UserModal({this.name, required this.email, required this.phoneNumber, required this.userId, required this.profilePic, this.permis});

  //from map
  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      permis: map['permis'] ?? '',
      userId: map['UserId'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  //to map

Map<String,dynamic> toMap () {
    return {
      'name' : name,
      'email' : email,
      'permis': permis,
      'userId' : userId,
      'profilePic' : profilePic,
      'phoneNumber': phoneNumber,

    };
}
}
