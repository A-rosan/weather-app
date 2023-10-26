import 'package:flutter/material.dart';
// import 'package:flutter_application_1_weather_app/shared/style/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defualtTxtForm({
  //carefull
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validator,
  void Function(String)? onSubmitted,
  void Function()? onTap,
  void Function(String)? onChanged,

  //icons
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixFunction,
  bool isClicAble = true,
  bool isRead = false,
  bool isPassword = false,
  Color iconColor = Colors.grey,
  Color textFormColor = Colors.white,
  Color fontFillColor = Colors.white,

  //style
  double radius = 0,
  double labelFontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  double? width,
  double? height,
  Color fontColor = Colors.white,
  Color borderColor = Colors.white,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        style: GoogleFonts.abel(
          color: fontColor,
          fontSize: labelFontSize,
          fontWeight: fontWeight,
        ),
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
        onTap: onTap,
        enabled: isClicAble,
        validator: validator,
        obscureText: isPassword,
        readOnly: isRead,
        decoration: InputDecoration(
          focusColor: fontFillColor,
          fillColor: textFormColor,
          label: Text(
            label,
            style: GoogleFonts.abel(
              color: fontColor,
              fontSize: labelFontSize,
              fontWeight: fontWeight,
            ),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: borderColor,
              //width: 2.0,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixFunction,
                  icon: Icon(
                    suffixIcon,
                    color: iconColor,
                  ),
                )
              : null,
        ),
      ),
    );

//divider
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

//navigator.push
void moveTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void moveToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);
