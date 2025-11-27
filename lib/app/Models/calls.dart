// app/Models/calls.dart

enum CallDirection { incoming, outgoing, missed }

class CallModel {
  final String nameOrNumber;
  final String line;
  final String phone;
  final DateTime time;
  final Duration duration;
  final CallDirection direction;
  final bool missed;
  final String? recordingId;

  CallModel({
    required this.nameOrNumber,
    required this.line,
    required this.phone,
    required this.time,
    required this.duration,
    required this.direction,
    this.missed = false,
    this.recordingId,
  });
}

/// Top-level response model for /get-call-Logs
class CallLogResponse {
  final bool success;
  final String? message;
  final List<CallLogDto> incomingCalls;
  final List<CallLogDto> outgoingCalls;

  CallLogResponse({
    required this.success,
    required this.message,
    required this.incomingCalls,
    required this.outgoingCalls,
  });

  factory CallLogResponse.fromJson(Map<String, dynamic> json) {
    final incomingJson = json['incoming_calls'];
    final outgoingJson = json['outgoing_calls'];

    return CallLogResponse(
      success: json['success'] == true,
      message: json['message']?.toString(),
      incomingCalls: (incomingJson is List)
          ? incomingJson
              .whereType<Map<String, dynamic>>()
              .map(CallLogDto.fromJson)
              .toList()
          : <CallLogDto>[],
      outgoingCalls: (outgoingJson is List)
          ? outgoingJson
              .whereType<Map<String, dynamic>>()
              .map(CallLogDto.fromJson)
              .toList()
          : <CallLogDto>[],
    );
  }
}

/// Single call record from API
class CallLogDto {
  final String? from;
  final String? to;
  final String? callerName;
  final String? answeredBy;
  final String? durationSeconds;
  final DateTime? startTime;
  final String? recording;
  final String? status;

  CallLogDto({
    this.from,
    this.to,
    this.callerName,
    this.answeredBy,
    this.durationSeconds,
    this.startTime,
    this.recording,
    this.status,
  });

  factory CallLogDto.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    final start = json['start_time'];

    if (start is Map && start['date'] != null) {
      final raw = start['date'].toString(); // "2025-11-24 15:17:27.000000"
      final normalized = raw.replaceFirst(' ', 'T'); // "2025-11-24T15:17:27.000000"
      try {
        parsedDate = DateTime.parse(normalized);
      } catch (_) {
        parsedDate = null;
      }
    }

    return CallLogDto(
      from: json['from']?.toString(),
      to: json['to']?.toString(),
      callerName: json['caller_name']?.toString(),
      answeredBy: json['answered_by']?.toString(),
      durationSeconds: json['duration']?.toString(),
      startTime: parsedDate,
      recording: json['recording']?.toString(),
      status: json['status']?.toString(),
    );
  }

  Duration get duration {
    final secs = int.tryParse(durationSeconds ?? '');
    if (secs == null || secs < 0) return Duration.zero;
    return Duration(seconds: secs);
  }

  bool get isMissed {
    final s = status?.toLowerCase().trim();
    return s == 'no answer' || s == 'no-answer' || s == 'noanswer';
  }
}

/// Mapping from API DTO -> UI model
extension CallLogDtoMapper on CallLogDto {
  /// Incoming calls (array: "incoming_calls")
  CallModel toIncomingCallModel() {
    final missed = isMissed;
    final direction = missed ? CallDirection.missed : CallDirection.incoming;

    final displayName = (callerName != null && callerName!.trim().isNotEmpty)
        ? callerName!.trim()
        : (from ?? 'Unknown');

    // "line" is not present in API -> hardcode it
    const hardcodedLine = 'Main Line';

    return CallModel(
      nameOrNumber: displayName,
      line: hardcodedLine,
      phone: from ?? 'Unknown',
      time: startTime ?? DateTime.now(),
      duration: duration,
      direction: direction,
      missed: missed,
      recordingId: recording,
    );
  }

  /// Outgoing calls (array: "outgoing_calls")
  CallModel toOutgoingCallModel() {
    final missed = isMissed;
    final direction = missed ? CallDirection.missed : CallDirection.outgoing;

    final displayName = (callerName != null && callerName!.trim().isNotEmpty)
        ? callerName!.trim()
        : (to ?? 'Unknown');

    const hardcodedLine = 'Main Line';

    return CallModel(
      nameOrNumber: displayName,
      line: hardcodedLine,
      phone: to ?? 'Unknown',
      time: startTime ?? DateTime.now(),
      duration: duration,
      direction: direction,
      missed: missed,
      recordingId: recording,
    );
  }
}
