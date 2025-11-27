import 'package:crmnir/app/Models/calls.dart';
import 'package:crmnir/app/modules/calls/controllers/calls_controller.dart';
import 'package:crmnir/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CallsView extends GetView<CallsController> {
  const CallsView({Key? key}) : super(key: key);

  // baseline width used for scale factor (iPhone 8 width 375)
  double scale(BuildContext c) => MediaQuery.of(c).size.width / 375.0;

  @override
  Widget build(BuildContext context) {
    // Ensure status bar icons are light because appbar is dark
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: AppColors.bcolor,
      appBar: AppBar(
        title: const Text(
          'Call',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        toolbarHeight: 120,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.vertical(
            bottom: new Radius.elliptical(
              MediaQuery.of(context).size.width,
              100.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Curved top area
            // _TopWave(
            //   title: 'Call',
            //   scale: scale(context),
            // ),
            SizedBox(height: 12 * scale(context)),
            // Tabs and content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale(context)),
              child: Column(
                children: [
                  _SegmentedTabs(scaleFactor: scale(context)),
                  SizedBox(height: 14 * scale(context)),
                ],
              ),
            ),
            // List
            // List
            Expanded(
              child: Obx(() {
                final items = controller.filteredCalls;
                final isLoading = controller.isLoading.value;
                final hasError = controller.hasError.value;

                // RefreshIndicator always wraps a scrollable
                return RefreshIndicator(
                  onRefresh: controller.refreshCalls,
                  child:
                      items.isEmpty
                          ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16 * scale(context),
                              vertical: 32 * scale(context),
                            ),
                            children: [
                              SizedBox(height: 12 * scale(context)),
                              if (isLoading) ...[
                                Center(child: CircularProgressIndicator()),
                              ] else ...[
                                Center(
                                  child: Text(
                                    hasError
                                        ? 'Failed to load calls.\nPull down to try again.'
                                        : controller.selectedTab.value == 0
                                        ? 'No calls to show.'
                                        : 'No missed calls.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14 * scale(context),
                                      color: AppColors.greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          )
                          : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16 * scale(context),
                              vertical: 8 * scale(context),
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final model = items[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: 12 * scale(context),
                                ),
                                child: CallCard(
                                  model: model,
                                  scaleFactor: scale(context),
                                  onPlay: () => controller.playRecording(model),
                                  onCall:
                                      () => controller.callNumber(model.phone),
                                ),
                              );
                            },
                          ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// Segmented toggle (All / Missed)
class _SegmentedTabs extends StatelessWidget {
  final double scaleFactor;
  const _SegmentedTabs({Key? key, required this.scaleFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ctrl = Get.find<CallsController>();
      final sel = ctrl.selectedTab.value;
      return Row(
        children: [
          // All button
          _SegmentItem(
            text: 'All',
            active: sel == 0,
            onTap: () => ctrl.setTab(0),
            scale: scaleFactor,
          ),
          SizedBox(width: 10 * scaleFactor),
          _SegmentItem(
            text: 'Missed',
            active: sel == 1,
            onTap: () => ctrl.setTab(1),
            scale: scaleFactor,
          ),
        ],
      );
    });
  }
}

class _SegmentItem extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;
  final double scale;
  const _SegmentItem({
    Key? key,
    required this.text,
    required this.active,
    required this.onTap,
    required this.scale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 30.0 * scale;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8 * scale),
          border: Border.all(color: AppColors.greyColor, width: 1),
          boxShadow:
              active
                  ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.12),
                      blurRadius: 8 * scale,
                      offset: Offset(0, 2 * scale),
                    ),
                  ]
                  : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: active ? AppColors.whiteColor : AppColors.darkGreyColor,
            fontWeight: FontWeight.w600,
            fontSize: 14 * scale,
          ),
        ),
      ),
    );
  }
}

/// CallCard widget matches screenshot's layout
class CallCard extends StatelessWidget {
  final CallModel model;
  final double scaleFactor;
  final VoidCallback onPlay;
  final VoidCallback onCall;

  const CallCard({
    Key? key,
    required this.model,
    required this.scaleFactor,
    required this.onPlay,
    required this.onCall,
  }) : super(key: key);

  String _formatTime(DateTime t) {
    // e.g. "31 Oct, 22 02:33 AM • 0:30"
    final day = t.day;
    final month = _monthShort(t.month);
    final year = t.year % 100;
    final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final minute = t.minute.toString().padLeft(2, '0');
    final ampm = t.hour >= 12 ? 'PM' : 'AM';
    return '$day $month, $year  $hour:$minute $ampm';
  }

  String _mmss(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m}:${s.toString().padLeft(2, '0')}';
  }

  static String _monthShort(int m) {
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[m];
  }

  @override
  Widget build(BuildContext context) {
    final cardRadius = 10.0 * scaleFactor;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: AppColors.greyColor, width: 0.7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8 * scaleFactor,
            offset: Offset(0, 2 * scaleFactor),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row (main content)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14 * scaleFactor,
              vertical: 12 * scaleFactor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 48 * scaleFactor,
                  height: 48 * scaleFactor,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.whiteColor,
                    size: 26 * scaleFactor,
                  ),
                ),
                SizedBox(width: 12 * scaleFactor),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + (optional lead badge)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.nameOrNumber,
                              style: TextStyle(
                                fontSize: 16 * scaleFactor,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8 * scaleFactor),
                          // call icon to the right
                          GestureDetector(
                            onTap: onCall,
                            child: Icon(
                              Icons.phone,
                              color: AppColors.greyColor,
                              size: 22 * scaleFactor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6 * scaleFactor),
                      // Line and phone small text
                      Text(
                        'Line: ${model.line}  •  ${model.phone}',
                        style: TextStyle(
                          fontSize: 13 * scaleFactor,
                          color: AppColors.darkGreyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8 * scaleFactor),
                      // Time row
                      Row(
                        children: [
                          Icon(
                            _iconForDirection(model.direction),
                            size: 16 * scaleFactor,
                            color: _colorForDirection(model.direction),
                          ),
                          SizedBox(width: 8 * scaleFactor),
                          Expanded(
                            child: Text(
                              '${_formatTime(model.time)}  •  ${_mmss(model.duration)}',
                              style: TextStyle(
                                fontSize: 12 * scaleFactor,
                                color: AppColors.greyColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider and small bottom bar with play button
          Divider(height: 0.9),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12 * scaleFactor,
                vertical: 8 * scaleFactor,
              ),
              child: Row(
                children: [
                  // small left status text (example)
                  Expanded(
                    child: Text(
                      model.missed
                          ? 'Call back via: ${model.line}'
                          : '${model.line}  •  ${model.phone}',
                      style: TextStyle(
                        fontSize: 12 * scaleFactor,
                        color:
                            model.missed
                                ? AppColors.errorColor
                                : AppColors.darkGreyColor,
                      ),
                    ),
                  ),
                  // play duration button
                  GestureDetector(
                    onTap: onPlay,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10 * scaleFactor,
                        vertical: 4 * scaleFactor,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3 * scaleFactor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: AppColors.whiteColor,
                            size: 16 * scaleFactor,
                          ),
                          SizedBox(width: 6 * scaleFactor),
                          Text(
                            _mmss(model.duration),
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 12 * scaleFactor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForDirection(CallDirection d) {
    switch (d) {
      case CallDirection.incoming:
        return Icons.call_received;
      case CallDirection.outgoing:
        return Icons.call_made;
      case CallDirection.missed:
        return Icons.call_missed;
    }
  }

  Color _colorForDirection(CallDirection d) {
    switch (d) {
      case CallDirection.incoming:
        return AppColors.secondary;
      case CallDirection.outgoing:
        return AppColors.primary;
      case CallDirection.missed:
        return AppColors.errorColor;
    }
  }
}
