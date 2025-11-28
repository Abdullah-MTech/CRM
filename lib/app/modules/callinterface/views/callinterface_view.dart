import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/callinterface_controller.dart';

class CallinterfaceView extends GetView<CallinterfaceController> {
  const CallinterfaceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CallinterfaceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CallinterfaceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
