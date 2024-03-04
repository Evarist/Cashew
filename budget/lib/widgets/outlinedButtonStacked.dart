import 'package:budget/colors.dart';
import 'package:budget/functions.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/tappable.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:flutter/material.dart';

class OutlinedButtonStacked extends StatelessWidget {
  const OutlinedButtonStacked({
    super.key,
    required this.text,
    this.fontSize,
    required this.onTap,
    required this.iconData,
    this.afterWidget,
    this.alignLeft = false,
    this.padding,
    this.afterWidgetPadding,
    this.alignBeside,
    this.filled = false,
    this.transitionWhenFilled = true,
    this.infoButton,
    this.iconScale = 1,
    this.borderRadius,
  });
  final String text;
  final double? fontSize;
  final void Function()? onTap;
  final IconData iconData;
  final Widget? afterWidget;
  final bool alignLeft;
  final EdgeInsets? padding;
  final EdgeInsets? afterWidgetPadding;
  final bool? alignBeside;
  final bool filled;
  final bool transitionWhenFilled;
  final Widget? infoButton;
  final double iconScale;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    double borderRadiusValue =
        borderRadius ?? (getPlatform() == PlatformOS.isIOS ? 10 : 15);
    return Row(
      children: [
        Expanded(
          child: Tappable(
            onTap: onTap,
            borderRadius: borderRadiusValue,
            color: Colors.transparent,
            child: OutlinedContainer(
              filled: filled,
              borderRadius: borderRadiusValue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: padding ??
                        EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                    child: Column(
                      crossAxisAlignment: alignLeft
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        alignBeside != true
                            ? Column(
                                crossAxisAlignment: alignLeft
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale: iconScale,
                                    child: Icon(
                                      iconData,
                                      size: 35,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFont(
                                    text: text,
                                    fontSize: fontSize ?? 18,
                                    fontWeight: FontWeight.bold,
                                    maxLines: 2,
                                  ),
                                  infoButton ?? SizedBox.shrink()
                                ],
                              )
                            : HeaderWithIconAndInfo(
                                iconData: iconData,
                                iconScale: iconScale,
                                text: text,
                                infoButton: infoButton,
                                fontSize: fontSize,
                              ),
                        afterWidget == null
                            ? SizedBox.shrink()
                            : SizedBox(height: 8),
                        if (afterWidgetPadding == null)
                          afterWidget ?? SizedBox.shrink()
                      ],
                    ),
                  ),
                  if (afterWidgetPadding != null)
                    Padding(
                      padding: afterWidgetPadding ?? EdgeInsets.zero,
                      child: afterWidget ?? SizedBox.shrink(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OutlinedContainer extends StatelessWidget {
  const OutlinedContainer(
      {required this.child,
      this.filled = false,
      this.borderRadius,
      this.borderColor,
      this.enabled = true,
      super.key});
  final Widget child;
  final bool filled;
  final double? borderRadius;
  final Color? borderColor;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    if (enabled == false) return child;
    double borderRadiusValue =
        borderRadius ?? (getPlatform() == PlatformOS.isIOS ? 10 : 15);
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ??
              (appStateSettings["materialYou"]
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                  : getColor(context, "lightDarkAccentHeavy")),
          width: 2,
        ),
        color: filled == true
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
      child: child,
    );
  }
}

class HeaderWithIconAndInfo extends StatelessWidget {
  final IconData iconData;
  final double iconScale;
  final String text;
  final double? fontSize;
  final Widget? infoButton;
  final EdgeInsets padding;

  HeaderWithIconAndInfo({
    required this.iconData,
    this.iconScale = 1,
    required this.text,
    this.fontSize,
    this.infoButton,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Transform.scale(
            scale: iconScale,
            child: Icon(
              iconData,
              size: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFont(
              text: text,
              fontSize: fontSize ?? 22,
              fontWeight: FontWeight.bold,
              maxLines: 2,
            ),
          ),
          infoButton ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
