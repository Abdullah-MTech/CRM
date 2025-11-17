import 'package:get/get.dart';

class LeadController extends GetxController {
  final messages = [
    Message("Lorem ipsum dolor sit amet, conse.", true, "10:00"),
    Message("Lorem ipsum dolor sit amet,\nconsectetur adipiscing.", false, "10:02"),
    Message(
        "Lorem ipsum dolor sit amet, consectetur\nadipisicing elit, sed do.", true, "10:05"),
    Message("Lorem ipsum dolor sit amet consec tetur adipisicing elit, sed do.", false, "10:15"),
    Message("Lorem ipsum dolor sit a.", true, "—"),
    Message(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse.",
      true,
      "—",
    ),
  ].obs;

  void sendMessage(String msg) {
    if (msg.trim().isEmpty) return;
    messages.add(Message(msg, true, "Now"));
  }
}


class Message {
  final String text;
  final bool isMe;
  final String time;
  Message(this.text, this.isMe, this.time);
}