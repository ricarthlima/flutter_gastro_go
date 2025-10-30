import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/extensions/context_dimensions.dart';
import 'package:flutter_gastro_go/core/navigation/app_router.dart';
import 'package:flutter_gastro_go/shared/widgets/logo_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    LogoWidget(width: 256),
                    Column(
                      children: [
                        Text(
                          "Uma experiência culinária",
                          style: Theme.of(context).textTheme.titleMedium!,
                        ),
                        Text(
                          "para quem está 'ready to go'!",
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
                      child: ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRouter.restaurants);
                        },
                        child: Text("Bora!"),
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
