import 'package:twilio_voice/twilio_voice.dart';

class TwilioCallService {
  TwilioCallService._();

  static final TwilioCallService instance = TwilioCallService._();

  String? _accessToken;
  bool _initialized = false;

  // Hardcoded for now. Replace these with data from Laravel later.
  static const String _testAccessToken = 'YOUR_TEST_TWILIO_ACCESS_TOKEN_HERE';

  List<String> _fromNumbers = const [
    '+44 161 464 0360',
    // Add more Twilio numbers here for local testing.
    // '+44 20 1234 5678',
    // '+1 555 123 4567',
  ];

  List<String> get fromNumbers => List.unmodifiable(_fromNumbers);

  /// Call this once at startup or lazily before the first call.
  Future<void> ensureInitialized() async {
    if (_initialized) return;

    _accessToken = _testAccessToken;

    if (_accessToken == null || _accessToken!.isEmpty) {
      throw Exception('Twilio access token is not configured.');
    }

    // On iOS, deviceToken is handled automatically; accessToken is mandatory.
    await TwilioVoice.instance.setTokens(accessToken: _accessToken!);

    _initialized = true;
  }

  /// Place an outbound call using Twilio.
  Future<void> placeCall({
    required String from,
    required String to,
  }) async {
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

  /// Example hook for when you wire Laravel later.
  /// Call this with data from your API.
  void updateConfigFromBackend({
    required String accessToken,
    required List<String> fromNumbers,
  }) {
    _accessToken = accessToken;
    _fromNumbers = fromNumbers;
    _initialized = false; // Force re-init with new token on next call.
  }
}
