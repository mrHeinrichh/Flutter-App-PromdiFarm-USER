import 'package:promdifarm_app/domain/entities/meta.entity.dart';

class Meta implements MetaEntity {
  final String token;
  final String refresh;

  Meta({this.token = "", this.refresh = ""});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return new Meta(
      token: json["token"] == null ? "" : json["token"],
      refresh: json["refresh"] == null ? "" : json["refresh"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "refresh": refresh,
    };
  }

  @override
  List<Object> get props => [
        token,
        refresh,
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
