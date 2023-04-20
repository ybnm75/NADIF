class UserModal {
   String name;
   String email;
   String phoneNumber;
   String userId;
   String profilePic;

  UserModal({required this.name, required this.email, required this.phoneNumber, required this.userId, required this.profilePic});

  //from map
  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userId: map['UserId'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  //to map

Map<String,dynamic> toMap () {
    return {
      'name' : name,
      'email' : email,
      'userId' : userId,
      'profilePic' : profilePic,
      'phoneNumber': phoneNumber,

    };
}
}
