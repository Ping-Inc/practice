import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/dusk.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/providers/passcode_provider.dart';

/// What the keypad is for: choosing a passcode (choose, then confirm), or
/// entering it to return to private mode (unlock, with Face ID as a backup).
enum PasscodeFlow { set, unlock }

enum _Stage { choose, confirm, unlock }

const int _passcodeLength = 4;

/// The passcode keypad. Pops `true` when the passcode was set or the unlock
/// succeeded, and `false` (or nothing) when cancelled.
class PasscodePage extends ConsumerStatefulWidget {
  const PasscodePage({super.key, required this.flow});

  final PasscodeFlow flow;

  @override
  ConsumerState<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends ConsumerState<PasscodePage>
    with SingleTickerProviderStateMixin {
  // Shakes the dots side to side on a wrong entry, like the iPhone lock
  // screen.
  late final AnimationController _shake = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  late _Stage _stage =
      widget.flow == PasscodeFlow.unlock ? _Stage.unlock : _Stage.choose;
  String _entry = '';
  String? _firstCode;
  bool _busy = false;

  static const _titles = {
    _Stage.choose: 'Choose a passcode',
    _Stage.confirm: 'Confirm passcode',
    _Stage.unlock: 'Return to Private mode',
  };

  static const _notes = {
    _Stage.choose: 'This passcode will be required to re-enter Private mode.',
    _Stage.confirm: 'Enter the same four digits again.',
    _Stage.unlock: 'Enter your passcode.',
  };

  void _press(String digit) {
    if (_busy || _entry.length >= _passcodeLength) return;
    setState(() => _entry += digit);
    if (_entry.length == _passcodeLength) {
      _busy = true;
      // A short pause so the last dot is seen filling in.
      Future.delayed(const Duration(milliseconds: 220), _submit);
    }
  }

  void _delete() {
    if (_busy || _entry.isEmpty) return;
    setState(() => _entry = _entry.substring(0, _entry.length - 1));
  }

  Future<void> _submit() async {
    final entry = _entry;
    final notifier = ref.read(passcodeProvider.notifier);

    switch (_stage) {
      case _Stage.choose:
        setState(() {
          _firstCode = entry;
          _stage = _Stage.confirm;
          _entry = '';
        });
      case _Stage.confirm:
        if (entry == _firstCode) {
          await notifier.setPasscode(entry);
          if (mounted) Navigator.of(context).pop(true);
          return;
        }
        await _rejectEntry('Passcodes didn’t match. Choose again.');
        if (!mounted) return;
        // Back to choosing; the title changing says so.
        setState(() {
          _stage = _Stage.choose;
          _firstCode = null;
        });
      case _Stage.unlock:
        if (await notifier.verify(entry)) {
          if (mounted) Navigator.of(context).pop(true);
          return;
        }
        if (!mounted) return;
        await _rejectEntry('Wrong passcode.');
        if (!mounted) return;
    }
    _busy = false;
  }

  /// Shakes the filled dots, then clears them. [announcement] is read out
  /// by VoiceOver, since the shake can't be seen.
  Future<void> _rejectEntry(String announcement) async {
    HapticFeedback.mediumImpact();
    SemanticsService.sendAnnouncement(
        View.of(context), announcement, TextDirection.ltr);
    await _shake.forward(from: 0);
    if (mounted) setState(() => _entry = '');
  }

  Future<void> _useBiometrics() async {
    if (_busy) return;
    try {
      final ok = await LocalAuthentication().authenticate(
        localizedReason: 'Return to Private mode',
        // If Face ID isn't available, iOS offers the iPhone's own passcode.
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
      if (ok && mounted) Navigator.of(context).pop(true);
    } catch (_) {
      // Cancelled or unavailable: stay on the keypad.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUnlock = _stage == _Stage.unlock;
    // Unlock is only seen in public mode, so it uses the dusk colors.
    final background =
        isUnlock ? Dusk.background : Theme.of(context).scaffoldBackgroundColor;
    final text = isUnlock ? Dusk.text : Theme.of(context).colorScheme.primary;
    final secondary =
        isUnlock ? Dusk.secondary : Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(spacingFour),
                child: SystemTap(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Semantics(
                    button: true,
                    label: isUnlock ? 'Stay in Public mode' : 'Cancel',
                    child: SizedBox(
                      width: tapTarget,
                      height: tapTarget,
                      child: Icon(PhosphorIcons.caret_left, color: text),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: spacingLarge),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SystemText(
                    text: _titles[_stage]!,
                    size: TextSizeEnum.twenty,
                    color: text,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 6),
                  // Two lines tall on every stage, so the keypad doesn't
                  // jump when a stage's line is shorter.
                  SizedBox(
                    height: 2 * 15 * lineHeight,
                    child: SystemText(
                      text: _notes[_stage]!,
                      color: secondary,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: spacingMedium),
                  AnimatedBuilder(
                    animation: _shake,
                    builder: (context, child) {
                      // Four swings that fade out over the shake.
                      final t = _shake.value;
                      final dx = math.sin(t * math.pi * 8) * 14 * (1 - t);
                      return Transform.translate(
                          offset: Offset(dx, 0), child: child);
                    },
                    child: _Dots(filled: _entry.length, color: text),
                  ),
                  // Where the error message used to be; keeps the keypad in
                  // the same place.
                  SizedBox(height: 36),
                ],
              ),
            ),
            SizedBox(height: spacingMedium),
            _Keypad(color: text, onDigit: _press, onDelete: _delete),
            const Spacer(),
            if (isUnlock)
              _BiometricButton(color: secondary, onTap: _useBiometrics),
            SizedBox(height: spacingMedium),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.filled, required this.color});

  final int filled;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$filled of $_passcodeLength digits entered',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < _passcodeLength; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 11),
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < filled ? color : Colors.transparent,
                border: Border.all(color: color, width: 1),
              ),
            ),
        ],
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad(
      {required this.color, required this.onDigit, required this.onDelete});

  final Color color;
  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;

  static const double _key = 72;

  @override
  Widget build(BuildContext context) {
    Widget digit(String d) => SystemTap(
          onTap: () => onDigit(d),
          child: Semantics(
            button: true,
            label: d,
            child: Container(
              width: _key,
              height: _key,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: thinLine),
              ),
              // A tight line height, split evenly above and below, so the
              // digit sits in the middle of its circle. (The app's usual
              // text style adds tall spacing above, which pushes it down.)
              child: Text(
                d,
                textAlign: TextAlign.center,
                style: TextStyle(
                  inherit: false,
                  fontFamily: FontEnum.sfpro.toFontFamily(),
                  fontSize: TextSizeEnum.twentyNine.toFontSize(),
                  height: 1.0,
                  leadingDistribution: TextLeadingDistribution.even,
                  color: color,
                ),
              ),
            ),
          ),
        );

    Widget row(List<Widget> keys) => Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: SizedBox(
            width: 272,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: keys,
            ),
          ),
        );

    return Column(
      children: [
        row([digit('1'), digit('2'), digit('3')]),
        row([digit('4'), digit('5'), digit('6')]),
        row([digit('7'), digit('8'), digit('9')]),
        row([
          SizedBox(width: _key, height: _key),
          digit('0'),
          SystemTap(
            onTap: onDelete,
            child: Semantics(
              button: true,
              label: 'Delete',
              child: SizedBox(
                width: _key,
                height: _key,
                child: Icon(PhosphorIcons.backspace_light, color: color),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

/// "Use Face ID" (or Touch ID, or the iPhone's passcode when neither is set
/// up). Hidden if the iPhone has no passcode at all.
class _BiometricButton extends StatefulWidget {
  const _BiometricButton({required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;

  @override
  State<_BiometricButton> createState() => _BiometricButtonState();
}

class _BiometricButtonState extends State<_BiometricButton> {
  String? _label;

  @override
  void initState() {
    super.initState();
    _loadLabel();
  }

  Future<void> _loadLabel() async {
    final auth = LocalAuthentication();
    String? label;
    try {
      if (await auth.isDeviceSupported()) {
        final types = await auth.getAvailableBiometrics();
        if (types.contains(BiometricType.face)) {
          label = 'Use Face ID';
        } else if (types.contains(BiometricType.fingerprint)) {
          label = 'Use Touch ID';
        } else {
          label = 'Use iPhone Passcode';
        }
      }
    } catch (_) {
      label = null;
    }
    if (mounted) setState(() => _label = label);
  }

  @override
  Widget build(BuildContext context) {
    final label = _label;
    if (label == null) return SizedBox(height: tapTarget);
    return SystemTap(
      onTap: widget.onTap,
      child: Semantics(
        button: true,
        child: SizedBox(
          height: tapTarget,
          child: Center(child: SystemText(text: label, color: widget.color)),
        ),
      ),
    );
  }
}
