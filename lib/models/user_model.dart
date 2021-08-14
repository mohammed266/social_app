
class UserModel{
  String name;
  String email;
  String uId;
  String phone;
  String image;
  String cover;
  String bio;
  bool isVerified;

  UserModel({this.email,this.phone,this.name,this.uId,this.isVerified,this.image,this.bio,this.cover});

  UserModel.fromJason(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isVerified = json['isVerified'];
  }

  Map<String,dynamic> toMap() {
    return {
      'name' : name,
      'email' : email,
      'uId' : uId,
      'phone' : phone,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
      'isVerified' : isVerified,
    };
  }
}