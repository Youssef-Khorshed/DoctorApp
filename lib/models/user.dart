class UserModel {
  String imagePath;
  String uId;
  String name;
  String phone;
  String email;
  String about;
  String type;
  UserModel.empty();
  UserModel(
      {this.imagePath,
      this.uId,
      this.name,
      this.phone,
      this.email,
      this.about,
      this.type});
  // factory UserModel.fromMap(map) {
  //   return UserModel(
  //     uId: map['uid'],
  //     email: map['email'],
  //     name: map['username'],
  //     phone: map['phone'],
  //   );
  // }
  UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      print('null');
    } else {
      uId = json['uId'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      about = json['about'];
      type = json['type'];
      imagePath = json['imagePath'];
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'about': about,
      'type': type,
      'imagePath': imagePath
    };
  }

  // List<UserModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
  //   return querySnapshot.docs.map((snapshot) {
  //     final Map<String, dynamic> dataMap =
  //         snapshot.data() as Map<String, dynamic>;

  //     return UserModel(
  //       uId: dataMap['uid'],
  //       email: dataMap['email'],
  //     );
  //   }).toList();
  // }
}
// class DataModel {
//   final String name;
//   final String developer;
//   final String framework;
//   final String tool;
//
//   DataModel({this.name, this.developer, this.framework, this.tool});
//
//   //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
//   //This function in essential to the working of FirestoreSearchScaffold
//
//   List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
//     return querySnapshot.docs.map((snapshot) {
//       final Map<String, dynamic> dataMap =
//       snapshot.data() as Map<String, dynamic>;
//
//       return DataModel(
//           name: dataMap['name'],
//           developer: dataMap['developer'],
//           framework: dataMap['framework'],
//           tool: dataMap['tool']);
//     }).toList();
//   }
// }


