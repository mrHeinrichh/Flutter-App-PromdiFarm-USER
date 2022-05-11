import 'package:promdifarm_app/domain/entities/index.dart';
import 'destination.model.dart';

class AcceptDelivery implements AcceptDeliveryEntity {
  final String id;
  final List<Destination> pending;
  final List<Destination> completed;
  final List<Destination> failed;
  final List<Destination> started;
  final List<Destination> arrived;
  final List<Destination> waiting;

  AcceptDelivery({
    required this.id,
    required this.pending,
    required this.completed,
    required this.failed,
    this.started = const [],
    this.arrived = const [],
    this.waiting = const [],
  });

  @override
  List<Object> get props => [pending, completed, failed];

  @override
  bool? get stringify => throw UnimplementedError();
}
