import 'package:flutter/material.dart';
import '../../../../core/extensions/context_dimensions.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/logo_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/banners/banner_splash.png",
              width: context.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 128.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 32,
                  children: [
                    const LogoWidget(width: 256),
                    Column(
                      children: [
                        Text(
                          i18n.onboardingUpperQuote,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          i18n.onboardingLowerQuote,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.main,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: context.width,
                      child: Tooltip(
                        message: i18n.onboardingCTA,
                        child: ElevatedButton(
                          onPressed: () {
                            context.goNamed(AppRouter.restaurants);
                          },
                          child: Text(i18n.onboardingCTA),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
