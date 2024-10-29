/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/svg
  $AssetsIconsSvgGen get svg => const $AssetsIconsSvgGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/png
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();

  /// Directory path: assets/images/svg
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsIconsSvgGen {
  const $AssetsIconsSvgGen();

  /// File path: assets/icons/svg/apple.svg
  String get apple => 'assets/icons/svg/apple.svg';

  /// File path: assets/icons/svg/bottom_pattern.svg
  String get bottomPattern => 'assets/icons/svg/bottom_pattern.svg';

  /// File path: assets/icons/svg/google.svg
  String get google => 'assets/icons/svg/google.svg';

  /// File path: assets/icons/svg/moon.svg
  String get moon => 'assets/icons/svg/moon.svg';

  /// File path: assets/icons/svg/sun.svg
  String get sun => 'assets/icons/svg/sun.svg';

  /// File path: assets/icons/svg/top_pattern.svg
  String get topPattern => 'assets/icons/svg/top_pattern.svg';

  /// List of all assets
  List<String> get values =>
      [apple, bottomPattern, google, moon, sun, topPattern];
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/png/app_logo.png');

  /// File path: assets/images/png/auth_bg.png
  AssetGenImage get authBg =>
      const AssetGenImage('assets/images/png/auth_bg.png');

  /// File path: assets/images/png/choose_mode_bg.png
  AssetGenImage get chooseModeBg =>
      const AssetGenImage('assets/images/png/choose_mode_bg.png');

  /// File path: assets/images/png/drawer_image.png
  AssetGenImage get drawerImage =>
      const AssetGenImage('assets/images/png/drawer_image.png');

  /// File path: assets/images/png/home_artist.png
  AssetGenImage get homeArtist =>
      const AssetGenImage('assets/images/png/home_artist.png');

  /// File path: assets/images/png/intro_bg.png
  AssetGenImage get introBg =>
      const AssetGenImage('assets/images/png/intro_bg.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [appLogo, authBg, chooseModeBg, drawerImage, homeArtist, introBg];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/home_top_card.svg
  String get homeTopCard => 'assets/images/svg/home_top_card.svg';

  /// File path: assets/images/svg/spotify_logo.svg
  String get spotifyLogo => 'assets/images/svg/spotify_logo.svg';

  /// List of all assets
  List<String> get values => [homeTopCard, spotifyLogo];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
