// lib/app/modules/recent/views/recent_view.dart

import 'package:crmnir/app/Models/People.dart';
import 'package:crmnir/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recent_controller.dart';

class RecentView extends GetView<RecentController> {
  const RecentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Recent',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.history), // or any filter / menu icon
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                // to match your LeadSView pattern
                1000,
                100.0,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.recents.isEmpty) {
            // initial load
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.hasError.value && controller.recents.isEmpty) {
            // error with no cached data
            return _buildErrorState();
          }

          if (controller.recents.isEmpty) {
            // no data
            return _buildEmptyState();
          }

          // Normal state with data
          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.recents.length,
              itemBuilder: (context, index) {
                final contact = controller.recents[index];
                return _recentCard(contact);
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.darkGreyColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load recent history.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGreyColor,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => controller.fetchRecentHistory(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteColor,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.call_outlined,
              size: 48,
              color: AppColors.darkGreyColor,
            ),
            SizedBox(height: 16),
            Text(
              'No recent conversations yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGreyColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Once you start calling, people will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.darkGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentCard(RecentContact contact) {
    final displayName =
        contact.name.isNotEmpty && contact.name.toLowerCase() != 'unknown'
            ? contact.name
            : contact.phoneNumber;

    final initials = _getInitials(displayName);

    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.CONVERSATION, arguments: contact);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.darkGreyColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Text(
                initials,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 16,
                        color: AppColors.darkGreyColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        contact.phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Conversation #${contact.conversationId}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                // TODO: Integrate Twilio call trigger here
                // e.g. controller.startCall(contact.phoneNumber);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.call,
                  size: 20,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String nameOrPhone) {
    final parts = nameOrPhone.trim().split(' ');
    if (parts.length == 1) {
      if (parts.first.length >= 2) {
        return parts.first.substring(0, 2).toUpperCase();
      }
      return parts.first.toUpperCase();
    } else {
      final first = parts[0].isNotEmpty ? parts[0][0] : '';
      final second = parts[1].isNotEmpty ? parts[1][0] : '';
      final initials = '$first$second';
      return initials.toUpperCase();
    }
  }
}
