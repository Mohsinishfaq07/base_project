import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  const LoginRequestModel({
    required this.clientId,

  });

  final int clientId;


  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
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
