import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/carrier/carrier_cubit.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/diesease/disease_cubit.dart';
import 'package:tsi_mobile/cubit/payment_method/payment_method_cubit.dart';
import 'package:tsi_mobile/cubit/story_cubit/story_cubit.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserCubit()),
          BlocProvider(create: (_) => LocationCubit()),
          BlocProvider(create: (_) => ProvinceCubit()),
          BlocProvider(create: (_) => CityCubit()),
          BlocProvider(create: (_) => DistrictCubit()),
          BlocProvider(create: (_) => SubdistrictCubit()),
          BlocProvider(create: (_) => CourseOfflineCubit()),
          BlocProvider(create: (_) => CourseOnlineCubit()),
          BlocProvider(create: (_) => BannerCubit()),
          BlocProvider(create: (_) => ProductCubit()),
          BlocProvider(create: (_) => StoryCubit()),
          BlocProvider(create: (_) => TerapisCubit()),
          BlocProvider(create: (_) => BlogCubit()),
          BlocProvider(create: (_) => MemberTerapisCubit()),
          BlocProvider(create: (_) => DiseaseCubit()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => CarrierCubit()),
          BlocProvider(create: (_) => PaymentMethodCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: ThemeData(
            inputDecorationTheme: inputDecorationTheme(),
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.r),
      borderSide: BorderSide(color: textDark3),
      gapPadding: 10);
  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      enabledBorder: outlineInputBorder,
      hintStyle: ralewayTextStyle.copyWith(color: textDark3, fontSize: 16.sp),
      labelStyle: ralewayTextStyle.copyWith(color: textDark3, fontSize: 16.sp),
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder);
}
