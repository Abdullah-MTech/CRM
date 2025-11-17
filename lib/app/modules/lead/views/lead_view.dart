import 'package:crmnir/app/modules/lead/controllers/lead_controller.dart';
import 'package:crmnir/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadView extends GetView<LeadController> {
  const LeadView({super.key});

  double scale(BuildContext context) =>
      MediaQuery.of(context).size.width / 375.0;

  @override
  Widget build(BuildContext context) {
    final s = scale(context);
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: const Text(
          "Lead",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
        // toolbarHeight:  120,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.vertical(
            bottom: new Radius.elliptical(
              MediaQuery.of(context).size.width,
              100.0,
            ),
          ),
        ),
        actions: [
          Icon(Icons.more_horiz, color: AppColors.whiteColor, size: 26 * s),
          SizedBox(width: 16 * s),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130 * s),

          child: Container(
            // color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 16 * s),
                    CircleAvatar(
                      radius: 20 * s,
                      backgroundImage: AssetImage(
                        "assets/profile.png",
                      ), // replace
                    ),
                    SizedBox(width: 4 * s),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ronald Richards",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17 * s,
                          ),
                        ),
                        SizedBox(height: 4 * s),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2 * s),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(3 * s),
                            // border:
                            //     Border.all(color: AppColors.whiteColor),
                          ),
                          child: Text(
                            "LEAD",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 10 * s,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10 * s),
                Row(
                  children: [
                    SizedBox(width: 16 * s),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Caller: +44 161 464 0360",
                          style: TextStyle(
                            color: AppColors.whiteColor.withOpacity(0.9),
                            fontSize: 12 * s,
                          ),
                        ),
                        SizedBox(height: 2 * s),
                        Text(
                          "Line: US Sales  •  +1 415 555 0139",
                          style: TextStyle(
                            color: AppColors.whiteColor.withOpacity(0.9),
                            fontSize: 12 * s,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40 * s),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14 * s,
                    vertical: 10 * s,
                  ),
                  children: [
                    SizedBox(height: 10 * s),
                    _today(s),
                    SizedBox(height: 10 * s),
                    ...controller.messages
                        .map((m) => _Bubble(msg: m, scale: s))
                        .toList(),
                    SizedBox(height: 80 * s),
                  ],
                ),
              ),
            ),
            _InputBar(
              scale: s,
              textController: textController,
              onSend: () {
                controller.sendMessage(textController.text);
                textController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _today(double s) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 6 * s),
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(20 * s),
        ),
        child: Text(
          "Today",
          style: TextStyle(fontSize: 12 * s, color: AppColors.darkGreyColor),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double scale;
  const _Header({required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;
    return Stack(
      children: [
        Container(
          height: 170 * s,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: 10 * s,
          left: 12 * s,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
              size: 20 * s,
            ),
          ),
        ),
        Positioned(
          top: 14 * s,
          right: 16 * s,
          child: Icon(
            Icons.more_horiz,
            color: AppColors.whiteColor,
            size: 26 * s,
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  final Message msg;
  final double scale;

  const _Bubble({required this.msg, required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;
    final isMe = msg.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4 * s),
            padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 10 * s),
            constraints: BoxConstraints(maxWidth: 260 * s),
            decoration: BoxDecoration(
              color: isMe ? AppColors.secondary : AppColors.lightGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14 * s),
                topRight: Radius.circular(14 * s),
                bottomLeft: Radius.circular(isMe ? 14 * s : 0),
                bottomRight: Radius.circular(isMe ? 0 : 14 * s),
              ),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                color: isMe ? AppColors.whiteColor : AppColors.blackColor,
                fontSize: 13.5 * s,
                height: 1.25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: isMe ? 4 * s : 0,
              left: isMe ? 0 : 4 * s,
            ),
            child: Text(
              msg.time,
              style: TextStyle(fontSize: 10 * s, color: AppColors.greyColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final double scale;
  final TextEditingController textController;
  final VoidCallback onSend;

  const _InputBar({
    required this.scale,
    required this.textController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * s, vertical: 8 * s),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8 * s,
            offset: Offset(0, -2 * s),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon(
          //   Icons.add_circle_outline,
          //   color: AppColors.darkGreyColor,
          //   size: 26 * s,
          // ),
          SizedBox(width: 8 * s),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14 * s,
                vertical: 2 * s,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                
                borderRadius: BorderRadius.circular(5 * s),
              ),
              child: TextField(
                controller: textController,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a message...",
                  prefixIcon: Icon(Icons.attach_file, color: Colors.black, size: 26 * s),
                ),
              ),
            ),
          ),
          SizedBox(width: 8 * s),
          GestureDetector(
            onTap: onSend,
            child: Container(
              padding: EdgeInsets.all(12 * s),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(5 * s),
              ),
              child: Icon(
                Icons.send,
                color: AppColors.whiteColor,
                size: 18 * s,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
