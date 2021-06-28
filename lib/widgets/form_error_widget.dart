import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormErrorWidget extends StatelessWidget {
  const FormErrorWidget({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(errors.length,
            (index) => formErrorWidgetText(error: errors[index])));
  }

  Row formErrorWidgetText({String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: 14.w,
          width: 14.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(error)
      ],
    );
  }
}
