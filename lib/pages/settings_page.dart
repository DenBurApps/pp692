import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp692/remote_config.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/assets_paths.dart';
import 'package:pp692/utils/texts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        titleSpacing: 16,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(width: 16),
            const Text('Settings', style: AppStyles.displayMedium),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                clipBehavior: Clip.hardEdge,
                height: 252,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(AppImages.cube),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vote for our app',
                            style: AppStyles.displayLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your opinion is important\nfor the development of\nour app',
                            style: AppStyles.bodyLarge.apply(
                              color: AppColors.onSurface.withOpacity(.5),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (await InAppReview.instance.isAvailable()) {
                                await InAppReview.instance.requestReview();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.background,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: const Text(
                                'Rate app',
                                style: AppStyles.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _MenuButton(
                      title: AppTexts.termsTitle,
                      icon: AppIcons.terms,
                      onTap: () async =>
                          await launchUrlString(RemoteConfigService.termsLink),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MenuButton(
                      title: AppTexts.privacyTitle,
                      icon: AppIcons.privacy,
                      onTap: () async => await launchUrlString(
                        RemoteConfigService.privacyLink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _MenuButton(
                      title: AppTexts.contactTitle,
                      icon: AppIcons.contact,
                      onTap: () async => await FlutterEmailSender.send(
                        Email(
                          recipients: ['ПОЧТА'],
                          subject: 'Subject',
                          body: 'Your feedback',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MenuButton(
                      title:
                          'Version: ${AppInfo.of(context).package.versionWithoutBuild}',
                      icon: AppIcons.version,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 + MediaQuery.of(context).viewPadding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.title,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final String icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.background,
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(title, style: AppStyles.bodyLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
