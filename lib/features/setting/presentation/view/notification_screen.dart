import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/custom_awesome_dialog.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import '../../../../core/extensions/notification_service.dart';
import '../../../../core/shared_widgets/app_bar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [];
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final savedNotifications =
        await NotificationService().getSavedNotifications();
    setState(() {
      notifications = savedNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leading: const SizedBox(),
        flexibleSpace: AppBarWidget(name: "notifications".tr()),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                "notificationSave".tr(),
                style: GoogleFonts.cairo(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            notification['title']!,
                            style: GoogleFonts.cairo(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              CustomAwesomeDialog().showCustomDialog(
                                context: context,
                                title: "delete",
                                desc: "sureDeleteOne",
                                btnOkOnPress: () async {
                                  NotificationService()
                                      .deleteNotifications(index: index);
                                  await _loadNotifications();
                                },
                              );
                            },
                            icon: Icon(
                              Icons.delete_forever_rounded,
                              color: AppColors.red,
                              size: 40.h,
                            ),
                          ),
                          subtitle: Text(
                            notification['body']!,
                            style: GoogleFonts.cairo(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 5.h);
                    },
                    itemCount: notifications.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onTap: () {
                        CustomAwesomeDialog().showCustomDialog(
                          context: context,
                          title: "deleteAll",
                          desc: "sureDeleteAll",
                          btnOkOnPress: () async {
                            NotificationService().deleteAllNotifications();
                            await _loadNotifications();
                          },
                        );
                      },
                      titleButton: "deleteAll".tr(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
