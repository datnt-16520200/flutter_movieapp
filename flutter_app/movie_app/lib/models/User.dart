class User{
  int _userId;
  String _name;
  String _email;
  String _adress;
  String _birthday;
  String _gender;

  User(this._userId,this._name, this._email, this._adress, this._birthday, this._gender);

  String get gender => _gender;

  String get birthday => _birthday;

  String get adress => _adress;

  String get email => _email;

  String get name => _name;

  int get userId => _userId;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      json['user_id'],
      json['name'],
      json['email'],
      json['adress'],
      json['birthday'],
      json['gender']
    );
  }
}