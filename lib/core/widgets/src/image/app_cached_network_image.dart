import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopme/core/extensions/extensions.dart';

part 'image_builder.dart';

class AppCachedNetworkImage extends StatefulWidget {
  const AppCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.imageAsset,
    this.assets,
    this.httpHeaders,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.cacheManager,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.errorHeight,
    this.imageRatio = 2,
    this.onTap,
  }) : super(key: key);

  final BaseCacheManager? cacheManager;

  /// The target image that is displayed.
  final String? imageUrl;

  /// Optional path even if [imageUrl] is empty or null.
  final String? imageAsset;

  /// Optional path even if [imageAsset] is empty or null.
  final Widget? assets;

  /// The target image's cache key.
  final String? cacheKey;

  /// Optional builder to further customize the display of the image.
  final ImageWidgetBuilder? imageBuilder;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final Widget Function(BuildContext, String, Object)? errorWidget;

  /// The duration of the fade-in animation for the [placeholder].
  final Duration? placeholderFadeInDuration;

  /// The duration of the fade-out animation for the [placeholder].
  final Duration? fadeOutDuration;

  /// The curve of the fade-out animation for the [placeholder].
  final Curve fadeOutCurve;

  /// The duration of the fade-in animation for the [imageUrl].
  final Duration fadeInDuration;

  /// The curve of the fade-in animation for the [imageUrl].
  final Curve fadeInCurve;

  /// If non-null, require the image to have this width.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio. This may result in a sudden change if the size of the
  /// placeholder widget does not match that of the target image. The size is
  /// also affected by the scale factor.
  final double? width;

  /// If non-null, require the image to have this height.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio. This may result in a sudden change if the size of the
  /// placeholder widget does not match that of the target image. The size is
  /// also affected by the scale factor.
  final double? height;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, a [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while a
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final Alignment alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  /// Whether to paint the image in the direction of the [TextDirection].
  ///
  /// If this is true, then in [TextDirection.ltr] contexts, the image will be
  /// drawn with its origin in the top left (the "normal" painting direction for
  /// children); and in [TextDirection.rtl] contexts, the image will be drawn with
  /// a scaling factor of -1 in the horizontal direction so that the origin is
  /// in the top right.
  ///
  /// This is occasionally used with children in right-to-left environments, for
  /// children that were designed for left-to-right locales. Be careful, when
  /// using this, to not flip children with integral shadows, text, or other
  /// effects that will look incorrect when flipped.
  ///
  /// If this is true, there must be an ambient [Directionality] widget in
  /// scope.
  final bool matchTextDirection;

  /// Optional headers for the http request of the image url
  final Map<String, String>? httpHeaders;

  /// When set to true it will animate from the old image to the new image
  /// if the url changes.
  final bool useOldImageOnUrlChange;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  /// Used to combine [color] with this image.
  ///
  /// The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is
  /// the source and this image is the destination.
  ///
  /// See also:
  ///
  ///  * [BlendMode], which includes an illustration of the effect of each blend mode.
  final BlendMode? colorBlendMode;

  /// Target the interpolation quality for image scaling.
  ///
  /// If not given a value, defaults to FilterQuality.low.
  final FilterQuality filterQuality;

  /// Will resize the image in memory to have a certain width using [ResizeImage]
  final int? memCacheWidth;

  /// Will resize the image in memory to have a certain height using [ResizeImage]
  final int? memCacheHeight;

  /// Will resize the image and store the resized image in the disk cache.
  final int? maxWidthDiskCache;

  /// Will resize the image and store the resized image in the disk cache.
  final int? maxHeightDiskCache;

  /// Height size of error in case
  final double? errorHeight;

  /// AspectRatio size of image in DataSavingFeature
  final double imageRatio;

  /// Optional If you want to do something, you can click to do it in this action/function.
  final void Function()? onTap;

  @override
  State<AppCachedNetworkImage> createState() => _AppCachedNetworkImageState();
}

class _AppCachedNetworkImageState extends State<AppCachedNetworkImage> {
  int get valueNotifier => widget.cacheKey?.hashCode ?? widget.imageUrl.hashCode;

  late final ValueNotifier<int> _networkNotifier = ValueNotifier<int>(valueNotifier);
  String defaultAssetUrl = 'assets/images/avatar/avatar_default.png';

  @override
  Widget build(BuildContext context) {
    String _imageUrl = widget.imageUrl.isNotEmptyOrNull
        ? widget.imageUrl!
        : "https://www.anelto.com/wp-content/uploads/2021/08/placeholder-image.png";

    return GestureDetector(
      onTap: widget.onTap,
      child: CachedNetworkImage(
        cacheKey: "Cache-${_imageUrl}-${_networkNotifier.value.toString()}",
        imageUrl: _imageUrl,
        fit: widget.fit,
        fadeOutDuration: widget.fadeOutDuration,
        fadeOutCurve: widget.fadeOutCurve,
        fadeInDuration: widget.fadeInDuration,
        fadeInCurve: widget.fadeInCurve,
        width: widget.width,
        height: widget.height,
        alignment: widget.alignment,
        repeat: widget.repeat,
        matchTextDirection: widget.matchTextDirection,
        color: widget.color,
        filterQuality: widget.filterQuality,
        colorBlendMode: widget.colorBlendMode,
        placeholderFadeInDuration: widget.placeholderFadeInDuration,
        memCacheWidth: widget.memCacheWidth,
        memCacheHeight: widget.memCacheHeight,
        progressIndicatorBuilder: widget.progressIndicatorBuilder ??
            (context, url, downloadProgress) {
              return Center(
                child: CircularProgressIndicator.adaptive(value: downloadProgress.progress),
              );
            },
        imageBuilder: widget.imageBuilder ??
            (context, imageProvider) => ImageBuilder(provider: imageProvider),
        errorWidget: widget.errorWidget ??
            (context, url, error) {
              if (_networkNotifier.value > valueNotifier + 2) {
                return CacheImage(
                  url: _imageUrl,
                  imageFit: BoxFit.contain,
                  errorHeight: widget.errorHeight,
                );
              }

              if (_networkNotifier.value == valueNotifier) {
                return FutureBuilder(
                  future: autoIncrement(),
                  builder: (_, __) => const ShimmerImage(),
                );
              }

              return IconButton(
                onPressed: () {
                  print("cache_key: ${_networkNotifier.value}");
                  increment.call();
                },
                icon: Icon(Icons.refresh, color: context.theme.primaryColor),
              );
            },
      ),
    );
  }

  Future<void> autoIncrement() async {
    await Future.delayed(const Duration(seconds: 1), () => increment());
  }

  void increment() => setState(() => _networkNotifier.value++);
}
