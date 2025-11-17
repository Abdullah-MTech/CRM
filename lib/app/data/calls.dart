class CallModel {
  final String nameOrNumber;
  final String line;
  final String phone;
  final DateTime time;
  final Duration duration;
  final bool missed;
  final CallDirection direction; // incoming/outgoing/missed

  CallModel({
    required this.nameOrNumber,
    required this.line,
    required this.phone,
    required this.time,
    required this.duration,
    this.missed = false,
    this.direction = CallDirection.incoming,
  });
}

enum CallDirection { incoming, outgoing, missed }