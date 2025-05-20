
class UserModel {
  int? idUser;
  String? userName;
  String? passName;

  UserModel({this.idUser,this.passName,this.userName});

  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
      idUser: map['idUser'],
      userName: map['userName'],
      passName: map['passName']
    );
  }
}