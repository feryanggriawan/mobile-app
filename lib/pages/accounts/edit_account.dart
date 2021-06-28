import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/update_profile/update_profile_cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:dio/dio.dart' as dio;
import 'package:unicons/unicons.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final ScrollController controller = ScrollController();

  double pixels = 0;

  final passwordTextController = TextEditingController();
  final newPasswordextController = TextEditingController();
  final confimrPasswordTextController = TextEditingController();

  final updateProfile = UpdateProfileCubit();

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void reGetProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("UserId");

    await context.read<UserCubit>().getProfile(userId);
    await context.read<MemberTerapisCubit>().getTerapis(id: userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        listener: (context, state) {
          if (state is UpdateProfileLoaded) {
            setState(() {
              loading = false;
            });

            reGetProfile();

            Get.back();
          }

          if (state is UpdateProfileLoadingFailed) {
            setState(() {
              loading = false;
            });
            snackbarWidget(
                messageText: state.message,
                titleText: "Gagal Update Data");
            print("state.message ${state.message}");
          }

          setState(() {
            loading = false;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedAppbarWidget(
              pixels: 51.h,
              secondSuffix: IconBtnWithCounter(
                icon: UniconsLine.share_alt,
                backgroundColor: Colors.transparent,
                numOfItems: 0,
                iconColors: Colors.transparent,
                shadow: false,
                onTap: () {},
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Ubah Akun",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: playfairDisplayTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              showHideIn: 50.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: playfairDisplayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: passwordTextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Password Baru",
                        style: playfairDisplayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password Baru',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: newPasswordextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Konfirmasi Password",
                        style: playfairDisplayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi Password',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: confimrPasswordTextController,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      if (loading)
                        SpinKitCircle(
                          size: 30,
                          color: primary1,
                        )
                      else
                        ButtonIconWidget(
                          onTap: () async {
                            dio.FormData formData = dio.FormData();
                            formData = dio.FormData.fromMap({
                              "password": passwordTextController.text,
                              "user": (context.read<UserCubit>().state
                                      as UserLoaded)
                                  .user
                                  .id
                                  .toString(),
                              "new_password": newPasswordextController.text,
                              "confirm_password":
                                  confimrPasswordTextController.text,
                            });

                            setState(() {
                              loading = true;
                            });
                            updateProfile.updateAccount(body: formData);
                          },
                          label: Text(
                            "Update Data Diri",
                            style: ralewayTextStyle.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        cubit: updateProfile,
      ),
    );
  }
}
