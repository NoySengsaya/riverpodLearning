import 'package:flutter/material.dart';

/// circle avarar profile with camera button
class AvatarUpload extends StatelessWidget {
  const AvatarUpload({
    super.key,
    this.source,
    this.radius = 20,
    this.onRefreshPressed,
    this.cameraButtonRadius = 15,
    this.cameraIconSize = 16,
    this.child,
  });

  /// image provider for avatar
  final ImageProvider<Object>? source;

  /// event onpress camera icon
  final Function()? onRefreshPressed;

  /// radius avatar
  final double radius;

  /// camera button radius
  final double cameraButtonRadius;

  /// camera icon size
  final double cameraIconSize;

  /// child widget
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: radius,
              foregroundImage: source,
              child: child,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(cameraButtonRadius),
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: InkWell(
              onTap: onRefreshPressed,
              borderRadius: BorderRadius.circular(cameraButtonRadius),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                radius: cameraButtonRadius,
                child: Icon(
                  Icons.refresh_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: cameraIconSize,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
