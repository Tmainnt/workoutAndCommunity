// ignore: constant_identifier_names
enum Role { User, Admin }

// ignore: constant_identifier_names
enum Gender { Male, Female }

class User {
  String _email;
  String _name;
  Gender _gender;
  String _dof;
  String _phone;
  Role _role;

  User({
    required String email,
    required String name,
    required Gender gender,
    required String dof,
    required String phone,
    required Role role,
  }) : _email = email,
       _name = name,
       _gender = gender,
       _dof = dof,
       _phone = phone,
       _role = role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["user_email"],
      name: json["user_name"],
      dof: json["date_of_birth"],
      phone: json["phone_number"],
      gender: Gender.values.firstWhere(
        (e) => e.name.toLowerCase() == json["user_gender"].toLowerCase(),
      ),
      role: Role.values.firstWhere(
        (e) => e.name.toLowerCase() == json["role"].toLowerCase(),
      ),
    );
  }

  String get email => _email;
  String get name => _name;
  Gender get gender => _gender;
  String get dof => _dof;
  String get phone => _phone;
  Role get role => _role;
}
