import 'package:crmnir/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crmnir/utilities/Colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.bcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          toolbarHeight: 0,
        ),
      ),
      drawer: _Drawer(),
      body: SafeArea(
        child: Column(
          children: [
            _HeaderWithCallerId(controller: c, scaffoldKey: scaffoldKey),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NewActivitySection(controller: c),
                    const SizedBox(height: 20),
                    _SearchField(controller: c),
                    const SizedBox(height: 20),
                    const Divider(height: 22),
                    const SizedBox(height: 16),
                    _DialPad(controller: c),
                    const SizedBox(height: 24),
                    _CallButton(controller: c),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderWithCallerId extends StatelessWidget {
  const _HeaderWithCallerId({
    required this.controller,
    required this.scaffoldKey,
  });

  final HomeController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double headerHeight = 160;

    return SizedBox(
      height: headerHeight + 40,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: headerHeight,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(22),
                //   bottomRight: Radius.circular(22),
                // ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(Icons.sort),
                          color: Colors.white,
                          onPressed: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white.withOpacity(0.25),
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                Icons.notifications,
                                size: 28,
                                color: AppColors.whiteColor,
                              ),

                              Positioned(
                                top: -1,
                                right: -1,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20),
                                    // border: Border.all(
                                    //   color: AppColors.whiteColor,
                                    //   width: 1.5,
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Caller ID',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 14,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Obx(() {
              final displayNumber =
                  controller.dialedNumber.value.isNotEmpty
                      ? controller.dialedNumber.value
                      : controller.callerId.value;

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        displayNumber,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      size: 22,
                      color: AppColors.darkGreyColor,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _NewActivitySection extends StatelessWidget {
  const _NewActivitySection({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New activity for today',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Row(
            children: [
              _ActivityChip(
                label: '+ Dialer',
                isSelected: controller.selectedActivityTab.value == 0,
                onTap: () => controller.selectActivityTab(0),
              ),
              const SizedBox(width: 12),
              _ActivityChip(
                label: '+ Message',
                isSelected: controller.selectedActivityTab.value == 1,
                onTap: () => controller.selectActivityTab(1),
                outlined: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityChip extends StatelessWidget {
  const _ActivityChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.outlined = false,
  });

  final String label;
  final bool isSelected;
  final bool outlined;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool filled = isSelected && !outlined;

    final Color bgColor = filled ? AppColors.primary : AppColors.whiteColor;

    final Color borderColor =
        filled ? AppColors.primary : AppColors.lightGreyColor;

    final Color textColor =
        filled ? AppColors.whiteColor : AppColors.blackColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary,),
            padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 80,
                    width: 80,
                    // color: AppColors.primary,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome to CRM',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home_outlined, color: AppColors.primary),
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Get.back();
                    // controller.tabIndex.value = 0;
                  },
                ),
                Divider(color: AppColors.lightGreyColor, thickness: 1),
                ListTile(
                  leading: Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'Chat',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.LEAD);
                    // controller.tabIndex.value = 0;
                  },
                ),
                Divider(color: AppColors.lightGreyColor, thickness: 1),
                ListTile(
                  leading: Icon(
                    Icons.person_outline_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'Lead',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.LEAD);
                    // controller.tabIndex.value = 0;
                  },
                ),
                Divider(color: AppColors.lightGreyColor, thickness: 1),
                ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                    // controller.tabIndex.value = 0;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search Contact...',
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.darkGreyColor,
            size: 20,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.primary, width: 0.2),
          ),
        ),
      ),
    );
  }
}

class _DialPad extends StatelessWidget {
  const _DialPad({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final keys = <_DialKeyModel>[
      const _DialKeyModel('1', ''),
      const _DialKeyModel('2', 'abc'),
      const _DialKeyModel('3', 'def'),
      const _DialKeyModel('4', 'ghi'),
      const _DialKeyModel('5', 'jkl'),
      const _DialKeyModel('6', 'mno'),
      const _DialKeyModel('7', 'pqrs'),
      const _DialKeyModel('8', 'tuv'),
      const _DialKeyModel('9', 'wxyz'),
      const _DialKeyModel('*', ''),
      const _DialKeyModel('0', '+'),
      const _DialKeyModel('#', ''),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double itemSize = (maxWidth - 2 * 32) / 3; // 3 columns, spacing

        return Center(
          child: Wrap(
            spacing: MediaQuery.of(context).size.width * 0.08,
            runSpacing: MediaQuery.of(context).size.height * 0.01,
            children:
                keys
                    .map(
                      (k) => _DialPadButton(
                        model: k,
                        size: itemSize.clamp(50, 70),
                        onTap: () => controller.addDigit(k.digit),
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}

class _DialKeyModel {
  const _DialKeyModel(this.digit, this.letters);

  final String digit;
  final String letters;
}

class _DialPadButton extends StatelessWidget {
  const _DialPadButton({
    required this.model,
    required this.size,
    required this.onTap,
  });

  final _DialKeyModel model;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Ink(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.digit,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            if (model.letters.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                model.letters,
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.5,
                  color: AppColors.darkGreyColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width * 0.2;
    final double clampedSize = size.clamp(55, 74);

    return Center(
      child: InkWell(
        onTap: controller.callCurrentNumber,
        borderRadius: BorderRadius.circular(clampedSize / 2),
        child: Ink(
          width: clampedSize,
          height: clampedSize,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.phone, color: Colors.white, size: 36),
        ),
      ),
    );
  }
}
