class UserModel {
  String uid;
  String email;
  String fname;
  String lname;
  String image;
  List pid;

  UserModel({
    this.uid,
    this.email,
    this.fname,
    this.lname,
    this.image,
    this.pid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'],
        email: map['email'],
        fname: map['fname'],
        lname: map['lname'],
        image: map['image'],
        pid: map['pid'],
      );

  Map<String, dynamic> userMap() {
    return {
      'uid': uid,
      'email': email,
      'fname': fname,
      'lname': lname,
      'image': image,
      'pid': pid,
    };
  }
}
