import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final Function() onPressed;
  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset('assets/images/icons/dice.png'),
            ),
            Text(message, textAlign: TextAlign.center),
            Tooltip(
              message: AppLocalizations.of(context)!.errorRetry,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(AppLocalizations.of(context)!.errorRetry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
