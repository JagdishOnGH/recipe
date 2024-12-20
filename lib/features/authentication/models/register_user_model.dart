class RegisterUserModel {
  //email password , confirm password and name are required
  //pp , phone number and address are optional
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String? pp;
  final String? phoneNumber;
  final String? address;

  RegisterUserModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    this.pp,
    this.phoneNumber,
    this.address,
  });
//to map the data to json
}
