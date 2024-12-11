import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp692/remote_config.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/texts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppSideMenu extends StatelessWidget {
  const AppSideMenu({super.key, required this.closeFunction});

  final void Function() closeFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 269,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: AppColors.background,
      ),
      padding: EdgeInsets.only(
        left: 20,
        top: MediaQuery.of(context).viewInsets.top +
            MediaQuery.of(context).viewPadding.top +
            30,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: closeFunction,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                  color: AppColors.surface,
                ),
              ),
              const SizedBox(width: 30),
              const DefaultTextStyle(
                style: AppStyles.displayLarge,
                child: Text(AppTexts.settingsTitle),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _MenuButton(
            title: AppTexts.rateTitle,
            onTap: () async {
              if (await InAppReview.instance.isAvailable()) {
                await InAppReview.instance.requestReview();
              }
            },
          ),
          Divider(height: 2, color: AppColors.surface.withOpacity(.1)),
          _MenuButton(
            title: AppTexts.contactTitle,
            onTap: () async => await FlutterEmailSender.send(
              Email(
                recipients: ['ПОЧТА'],
                subject: 'Subject',
                body: 'Your feedback',
              ),
            ),
          ),
          Divider(height: 2, color: AppColors.surface.withOpacity(.1)),
          _MenuButton(
            title: AppTexts.termsTitle,
            onTap: () async =>
                await launchUrlString(RemoteConfigService.termsLink),
          ),
          Divider(height: 2, color: AppColors.surface.withOpacity(.1)),
          _MenuButton(
            title: AppTexts.privacyTitle,
            onTap: () async =>
                await launchUrlString(RemoteConfigService.privacyLink),
          ),
          const SizedBox(height: 20),
          Text(
            'Version: ${AppInfo.of(context).package.versionWithoutBuild}',
            style: AppStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.title, required this.onTap});

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultTextStyle(
                style: AppStyles.displayMedium,
                child: Text(title),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
                color: AppColors.surface,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
