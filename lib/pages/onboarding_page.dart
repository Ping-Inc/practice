import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/capture_button.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/providers/onboarding_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OnboardingPage> {
  int currentStep = 0;

  final List<String> onboardingTexts = [
    "A camera roll for your thoughts —",
    "Ping Practice is a not-for-profit journaling [method](https://pingpractice.org/method/) and, as you see here, an app.",
    "Meant to support you in decoupling sensing from sense-making —",
    "Pings are private and saved to your device.",
    "Happy pinging ^ _ ^"
  ];

  void _handleButtonTap() {
    setState(() {
      currentStep++;
    });

    if (currentStep >= onboardingTexts.length) {
      // Complete onboarding and navigate to new ping page
      ref.read(onboardingProvider.notifier).complete();
    }
  }

  List<TextSpan> _buildTextSpans(String text) {
    // Check if the text contains a markdown-style link [text](url)
    final RegExp linkRegex = RegExp(r'\[(.*?)\]\((.*?)\)');
    final Match? match = linkRegex.firstMatch(text);

    if (match != null) {
      // Extract the link text and URL
      final String linkText = match.group(1)!;
      final String url = match.group(2)!;

      // Split the text into parts: before the link, the link itself, and after the link
      final int startIndex = match.start;
      final int endIndex = match.end;

      final List<TextSpan> spans = [];

      // Add text before the link if any
      if (startIndex > 0) {
        spans.add(TextSpan(text: text.substring(0, startIndex)));
      }

      // Add the link
      spans.add(
        TextSpan(
          text: linkText,
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              HapticFeedback.selectionClick();
              final uri = Uri.parse(url);
              launchUrl(uri);
            },
        ),
      );

      // Add text after the link if any
      if (endIndex < text.length) {
        spans.add(TextSpan(text: text.substring(endIndex)));
      }

      return spans;
    } else {
      // No link in the text, return a single TextSpan
      return [TextSpan(text: text)];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeCardBackgroundBlueOldest,
        body: SafeArea(
            child: MainSpacingCell(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: spacingMedium),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: TextSizeEnum.thirtySix.toFontSize(),
                                  fontFamily: FontEnum.garamond.toFontFamily(),
                                  height: lineHeight,
                                  color: themeTextActiveBlue),
                              children: _buildTextSpans(
                                  onboardingTexts[currentStep]))))),
              SizedBox(
                height: spacingFive,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CaptureButton(
                    onTap: _handleButtonTap,
                  )
                ],
              ),
              SizedBox(
                height: spacingFive,
              )
            ]))));
  }
}
