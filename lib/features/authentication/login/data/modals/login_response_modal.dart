import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  const LoginResponseModel({
    required this.clientId,

  });

  final int clientId;


  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      clientId: json['clientId'],

    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['clientId'] = clientId;

    return _data;
  }

  @override
  List<Object?> get props => [clientId,];
}