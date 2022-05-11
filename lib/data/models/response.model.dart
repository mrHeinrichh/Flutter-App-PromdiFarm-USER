import 'package:promdifarm_app/data/models/meta.model.dart';

class Response {
  String status;
  bool error;
  String message;
  List data;
  Meta meta;

  Response({
    this.status = "",
    this.error = false,
    this.message = "",
    required this.data,
    required this.meta,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return new Response(
      status: json["status"] == null ? "" : json["status"],
      error: json["error"] == null ? false : json["error"],
      message: json["message"] == null ? "" : json["message"],
      data: json["data"] == null ? [] : new List.from(json["data"]),
      meta: json["meta"] == null ? new Meta() : new Meta.fromJson(json["meta"]),
    );
  }
}
