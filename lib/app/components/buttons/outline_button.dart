// ignore: must_be_immutable
import 'package:indianfastfoodrecipes/app/export.dart';

// ignore: must_be_immutable
class OutlineBorderButton extends StatelessWidget {
  String? title;
  VoidCallback onPressed;
  VoidCallback? onLongPress;
  double? height;
  double? width;
  double? borderwidth;
  double? radius;
  double? fontSize;

  Color? textColor;
  Color? borderColor;
  Color? backgroundColor;
  ButtonTextTheme? textTheme;
  BorderRadiusGeometry? borderRadius;

  OutlineBorderButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.fontSize,
    this.radius,
    this.textColor,
    this.borderColor,
    this.onLongPress,
    this.textTheme,
    this.backgroundColor,
    this.borderwidth,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? circular30BorderRadius,
          ),
          backgroundColor:
              backgroundColor ?? secondaryButtonColor.withOpacity(0.3),
          side: BorderSide(
              color: borderColor ?? primaryWhite, width: borderwidth ?? 1),
        ),
        onPressed: onPressed,
        child: Text(
          title.toString(),
          style: AppTextStyle.normalBold18.copyWith(
              color: textColor ?? primaryWhite, fontSize: fontSize ?? 18),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OutlineIconButton extends StatelessWidget {
  String? title;
  VoidCallback onPressed;
  Color? color;
  Icon icon;

  OutlineIconButton({
    Key? key,
    this.color,
    required this.title,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
      label: Text(title.toString()),
      icon: icon,
      onPressed: onPressed,
    );
  }
}
