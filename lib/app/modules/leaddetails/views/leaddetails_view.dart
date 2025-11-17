import 'package:crmnir/app/data/calls.dart';
import 'package:crmnir/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/leaddetails_controller.dart';

class LeaddetailsView extends GetView<LeaddetailsController> {
  const LeaddetailsView({super.key});

  double _scale(BuildContext context) =>
      MediaQuery.of(context).size.width / 375.0;

  @override
  Widget build(BuildContext context) {
    final s = _scale(context);
    final c = controller;

    return Scaffold(
      backgroundColor: AppColors.bcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100 * s),
        child: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Lead',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.filter_list),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                MediaQuery.of(context).size.width,
                100.0 * s,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16 * s, 20 * s, 16 * s, 24 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LeadHeaderCard(scale: s, controller: c),
                SizedBox(height: 24 * s),
                _FinancialSection(scale: s, controller: c),
                SizedBox(height: 24 * s),
                _NotesSection(scale: s, controller: c),
                SizedBox(height: 24 * s),
                _CommunicationSection(scale: s, controller: c),
              ],
            ),
          ),
     
      ),
    );
  }
}

class _LeadHeaderCard extends StatelessWidget {
  const _LeadHeaderCard({
    required this.scale,
    required this.controller,
  });

  final double scale;
  final LeaddetailsController controller;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12 * s),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8 * s,
            offset: Offset(0, 3 * s),
          ),
        ],
      ),
      padding: EdgeInsets.all(14 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24 * s,
                backgroundImage: AssetImage(controller.leadAvatar.value),
              ),
              SizedBox(width: 12 * s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.leadName.value,
                      style: TextStyle(
                        fontSize: 16 * s,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 4 * s),
                    Row(
                      children: [
                        Icon(
                          Icons.campaign,
                          size: 14 * s,
                          color: AppColors.darkGreyColor,
                        ),
                        SizedBox(width: 4 * s),
                        Text(
                          controller.leadSource.value,
                          style: TextStyle(
                            fontSize: 12 * s,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * s),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16 * s,
                color: AppColors.darkGreyColor,
              ),
              SizedBox(width: 4 * s),
              Expanded(
                child: Text(
                  controller.leadAddress.value,
                  style: TextStyle(
                    fontSize: 13 * s,
                    decoration: TextDecoration.underline,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(width: 8 * s),
              Icon(
                Icons.phone,
                size: 16 * s,
                color: AppColors.darkGreyColor,
              ),
              SizedBox(width: 4 * s),
              Text(
                controller.leadPhone.value,
                style: TextStyle(
                  fontSize: 13 * s,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * s),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 34 * s,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6 * s),
                    border: Border.all(color: AppColors.lightGreyColor),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10 * s),
                  child: Row(
                    children: [
                      Text(
                        controller.timeRange.value,
                        style: TextStyle(
                          fontSize: 12 * s,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 16 * s,
                        color: AppColors.darkGreyColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8 * s),
              GestureDetector(
                onTap: controller.onTapStatus,
                child: Container(
                  height: 34 * s,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14 * s,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6 * s),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        controller.status.value,
                        style: TextStyle(
                          fontSize: 13 * s,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4 * s),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18 * s,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinancialSection extends StatelessWidget {
  const _FinancialSection({
    required this.scale,
    required this.controller,
  });

  final double scale;
  final LeaddetailsController controller;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    TextStyle labelStyle = TextStyle(
      fontSize: 14 * s,
      color: AppColors.darkGreyColor,
    );
    TextStyle valueStyle = TextStyle(
      fontSize: 14 * s,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial',
          style: TextStyle(
            fontSize: 16 * s,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 12 * s),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10 * s,
            horizontal: 4 * s,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: labelStyle),
                  Text('250.00', style: valueStyle),
                ],
              ),
              SizedBox(height: 4 * s),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Parts', style: labelStyle),
                  Text('100.00', style: valueStyle),
                ],
              ),
              SizedBox(height: 4 * s),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profit', style: labelStyle),
                  Text('150.00', style: valueStyle),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotesSection extends StatelessWidget {
  const _NotesSection({
    required this.scale,
    required this.controller,
  });

  final double scale;
  final LeaddetailsController controller;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10 * s),
            border: Border.all(color: AppColors.lightGreyColor),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12 * s,
            vertical: 10 * s,
          ),
          child: TextField(
            minLines: 3,
            maxLines: 5,
            onChanged: controller.updateNotes,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Notes / Issue / Description',
              hintStyle: TextStyle(
                fontSize: 13 * s,
                color: AppColors.greyColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CommunicationSection extends StatelessWidget {
  const _CommunicationSection({
    required this.scale,
    required this.controller,
  });

  final double scale;
  final LeaddetailsController controller;

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lead's Communication",
          style: TextStyle(
            fontSize: 16 * s,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 12 * s),
        ...controller.communications
            .map((c) => Padding(
                  padding: EdgeInsets.only(bottom: 12 * s),
                  child: _CommunicationCard(
                    scale: s,
                    model: c,
                    onCall: () => controller.onTapCall(c.phone),
                    onPlay: () => controller.onTapPlay(c),
                  ),
                ))
            .toList(),
      ],
    );
  }
}

class _CommunicationCard extends StatelessWidget {
  const _CommunicationCard({
    required this.scale,
    required this.model,
    required this.onCall,
    required this.onPlay,
  });

  final double scale;
  final CallModel model;
  final VoidCallback onCall;
  final VoidCallback onPlay;

  String _formatTime(DateTime t) {
    final day = t.day;
    const months = [
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
    final month = months[t.month];
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

  IconData _directionIcon(CallDirection d) {
    switch (d) {
      case CallDirection.incoming:
        return Icons.call_received;
      case CallDirection.outgoing:
        return Icons.call_made;
      case CallDirection.missed:
        return Icons.call_missed;
    }
  }

  Color _directionColor(CallDirection d) {
    switch (d) {
      case CallDirection.incoming:
        return AppColors.secondary;
      case CallDirection.outgoing:
        return AppColors.primary;
      case CallDirection.missed:
        return AppColors.errorColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10 * s),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8 * s,
            offset: Offset(0, 2 * s),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12 * s,
              vertical: 10 * s,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20 * s,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.person,
                    color: AppColors.whiteColor,
                    size: 22 * s,
                  ),
                ),
                SizedBox(width: 10 * s),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.nameOrNumber,
                              style: TextStyle(
                                fontSize: 15 * s,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8 * s),
                          GestureDetector(
                            onTap: onCall,
                            child: Icon(
                              Icons.phone,
                              size: 20 * s,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4 * s),
                      Text(
                        'Line: ${model.line}  •  ${model.phone}',
                        style: TextStyle(
                          fontSize: 12 * s,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                      SizedBox(height: 6 * s),
                      Row(
                        children: [
                          Icon(
                            _directionIcon(model.direction),
                            size: 16 * s,
                            color: _directionColor(model.direction),
                          ),
                          SizedBox(width: 6 * s),
                          Expanded(
                            child: Text(
                              '${_formatTime(model.time)}  •  ${_mmss(model.duration)}',
                              style: TextStyle(
                                fontSize: 11 * s,
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
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12 * s,
              vertical: 8 * s,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check,
                  size: 16 * s,
                  color: Colors.green,
                ),
                SizedBox(width: 6 * s),
                Expanded(
                  child: Text(
                    'Line: ${model.line}  •  ${model.phone}',
                    style: TextStyle(
                      fontSize: 11 * s,
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPlay,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10 * s,
                      vertical: 4 * s,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4 * s),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 14 * s,
                          color: AppColors.whiteColor,
                        ),
                        SizedBox(width: 4 * s),
                        Text(
                          _mmss(model.duration),
                          style: TextStyle(
                            fontSize: 11 * s,
                            color: AppColors.whiteColor,
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
        ],
      ),
    );
  }
}
