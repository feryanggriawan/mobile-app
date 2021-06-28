
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

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ScrollController controller = ScrollController();

  double pixels = 0;

  final nameTextController = TextEditingController();
  final nikTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final idCertifiedController = TextEditingController();
  final emailTextController = TextEditingController();

  final updateProfile = UpdateProfileCubit();

  bool loading = false;

  @override
  void initState() {
    nameTextController.text =
        (context.read<UserCubit>().state as UserLoaded).user.name;
    nikTextController.text =
        (context.read<UserCubit>().state as UserLoaded).user.nik;
    phoneTextController.text =
        (context.read<UserCubit>().state as UserLoaded).user.phone;
    idCertifiedController.text =
        (context.read<UserCubit>().state as UserLoaded).user.certificateId;
    emailTextController.text =
        (context.read<UserCubit>().state as UserLoaded).user.email;
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
                      "Ubah Data Diri",
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
                        "Nama",
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
                        decoration: InputDecoration(
                          hintText: 'Nama',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: nameTextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "NIK",
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
                        decoration: InputDecoration(
                          hintText: 'NIK',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: nikTextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Email",
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
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: emailTextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "No.Hp",
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
                        decoration: InputDecoration(
                          hintText: 'No. HP',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: nikTextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "ID Sertifikat",
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
                        decoration: InputDecoration(
                          hintText: 'ID Sertifikat',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: idCertifiedController,
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
                              "name": nameTextController.text,
                              "user": (context.read<UserCubit>().state
                                      as UserLoaded)
                                  .user
                                  .id
                                  .toString(),
                              "nik": nikTextController.text,
                              "phone": phoneTextController.text,
                              "email": emailTextController.text,
                              "image": "",
                            });

                            setState(() {
                              loading = true;
                            });
                            updateProfile.updateProfile(body: formData);
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
