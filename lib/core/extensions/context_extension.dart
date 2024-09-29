import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Size get getSize => mediaQuery.size;
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get aspectRatio => mediaQuery.size.aspectRatio;

  double get constLowValue => 8;
  double get constNormalValue => 16;
  double get constMediumValue => 32;
  double get constHighValue => 48;

  double get lowValue => height * 0.008;
  double get normalValue => height * 0.016;
  double get mediumValue => height * 0.032;
  double get highValue => height * 0.1;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

extension DurationExtension on BuildContext {
  Duration get durationLow => const Duration(milliseconds: 500);
  Duration get durationNormal => const Duration(seconds: 1);
  Duration get durationMedium => const Duration(seconds: 2);
  Duration get durationHigh => const Duration(seconds: 3);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  EdgeInsets get paddingConstNormal => EdgeInsets.all(constNormalValue);
  EdgeInsets get horizontalPaddingConstNormal =>
      EdgeInsets.symmetric(horizontal: constNormalValue);
  EdgeInsets get horizontalPaddingConstLow =>
      EdgeInsets.symmetric(horizontal: constLowValue);
  EdgeInsets get verticalPaddingConstMedium =>
      EdgeInsets.symmetric(vertical: constMediumValue);
  EdgeInsets get verticalPaddingConstNormal =>
      EdgeInsets.symmetric(vertical: constNormalValue);
  EdgeInsets get verticalPaddingConstLow =>
      EdgeInsets.symmetric(vertical: constLowValue);

  EdgeInsets get horizontalPaddingLow =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingNormal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get horizontalPaddingMedium =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get horizontalPaddingHigh =>
      EdgeInsets.symmetric(horizontal: highValue);

  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get verticalPaddingNormal =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get verticalPaddingMedium =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get verticalPaddingHigh =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get onlyLeftPaddingLow => EdgeInsets.only(left: lowValue);
  EdgeInsets get onlyLeftPaddingNormal => EdgeInsets.only(left: normalValue);
  EdgeInsets get onlyLeftPaddingMedium => EdgeInsets.only(left: mediumValue);
  EdgeInsets get onlyLeftPaddingHigh => EdgeInsets.only(left: highValue);

  EdgeInsets get onlyRightPaddingLow => EdgeInsets.only(right: lowValue);
  EdgeInsets get onlyRightPaddingNormal => EdgeInsets.only(right: normalValue);
  EdgeInsets get onlyRightPaddingMedium => EdgeInsets.only(right: mediumValue);
  EdgeInsets get onlyRightPaddingHigh => EdgeInsets.only(right: highValue);

  EdgeInsets get onlyBottomPaddingLow => EdgeInsets.only(bottom: lowValue);
  EdgeInsets get onlyBottomPaddingNormal =>
      EdgeInsets.only(bottom: normalValue);
  EdgeInsets get onlyBottomPaddingMedium =>
      EdgeInsets.only(bottom: mediumValue);
  EdgeInsets get onlyBottomPaddingHigh => EdgeInsets.only(bottom: highValue);

  EdgeInsets get onlyTopPaddingLow => EdgeInsets.only(top: lowValue);
  EdgeInsets get onlyTopPaddingNormal => EdgeInsets.only(top: normalValue);
  EdgeInsets get onlyTopPaddingMedium => EdgeInsets.only(top: mediumValue);
  EdgeInsets get onlyTopPaddingHigh => EdgeInsets.only(top: highValue);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => const SizedBox(width: 0.01);
  Widget get emptySizedWidthBoxNormal => const SizedBox(width: 0.03);
  Widget get emptySizedWidthBoxMedium => const SizedBox(width: 0.05);
  Widget get emptySizedWidthBoxHigh => const SizedBox(width: 0.1);

  Widget get emptySizedHeightBoxLow => const SizedBox(height: 0.01);
  Widget get emptySizedHeightBoxNormal => const SizedBox(height: 0.03);
  Widget get emptySizedHeightBoxMedium => const SizedBox(height: 0.05);
  Widget get emptySizedHeightBoxHigh => const SizedBox(height: 0.1);
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highRadius => Radius.circular(width * 0.1);
}

extension SizedBoxNum on BuildContext {
  SizedBox get sizedHeightBoxLow => SizedBox(height: constLowValue);
  SizedBox get sizedHeightBoxNormal => SizedBox(height: constNormalValue);
  SizedBox get sizedHeightBoxMedium => const SizedBox(height: 24);
  SizedBox get sizedHeightBoxHigh => const SizedBox(height: 32);
  SizedBox get sizedHeightBoxExtraHigh => const SizedBox(
        height: 80,
      );
  SizedBox get sizedHButton => const SizedBox(
        height: 50,
      );

  SizedBox get sizedWidthBoxLow => const SizedBox(width: 8);
  SizedBox get sizedWidthBoxNormal => const SizedBox(width: 16);
  SizedBox get sizedWidthBoxMedium => const SizedBox(width: 24);
  SizedBox get sizedWidthBoxHigh => const SizedBox(width: 32);
  SizedBox get sizedWButton => const SizedBox(
        width: 300,
      );
}