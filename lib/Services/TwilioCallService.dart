import 'package:twilio_voice/twilio_voice.dart';

class TwilioCallService {
  TwilioCallService._();

  static final TwilioCallService instance = TwilioCallService._();

  String? _accessToken;
  bool _initialized = false;

  // Hardcode test token for now.
  static const String _testAccessToken = 'YOUR_TEST_TWILIO_ACCESS_TOKEN';

  // Hardcode from numbers for now.
  List<String> _fromNumbers = const [
    '+44 161 464 0360',
    // Add more later.
  ];

  List<String> get fromNumbers => List.unmodifiable(_fromNumbers);

  Future<void> _initInternal() async {
    _accessToken = _testAccessToken;

    if (_accessToken == null || _accessToken!.isEmpty) {
      throw Exception('Twilio access token is not configured.');
    }

    // This may log "Device token is nil" if VoIP is not fully configured.
    // For outgoing-only you can ignore that log.
    await TwilioVoice.instance.setTokens(accessToken: _accessToken!);

    _initialized = true;
  }

  Future<void> ensureInitialized() async {
    if (_initialized) return;
    await _initInternal();
  }

  Future<void> placeCall({
    required String from,
    required String to,
  }) async {
    // Lazy init: only when we actually place a call.
    await ensureInitialized();

    if (from.isEmpty || to.isEmpty) {
      throw ArgumentError('From and To numbers must not be empty.');
    }

    await TwilioVoice.instance.call.place(
      from: from,
      to: to,
      extraOptions: {
        '__TWI_CALLER_ID': from,
        '__TWI_RECIPIENT_ID': to,
      },
    );
  }

  void updateConfigFromBackend({
    required String accessToken,
    required List<String> fromNumbers,
  }) {
    _accessToken = accessToken;
    _fromNumbers = fromNumbers;
    _initialized = false;
  }
}
