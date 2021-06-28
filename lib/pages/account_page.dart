import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String story = "0";
  String done = "0";
  String unDone = "0";

  final storyCubit = StoryCubit();
  final memberDoneCubit = MemberGetCubit();
  final memberWillCubit = MemberGetCubit();

  @override
  void initState() {
    storyCubit.getSearchStories(body: {
      "search": "",
      "user": (context.read<UserCubit>().state as UserLoaded).user.id
    });

    memberDoneCubit.getMemberPasien(body: {
      "pasien": "",
      "type": 1,
      "user": (context.read<UserCubit>().state as UserLoaded).user.id
    });

    memberWillCubit.getMemberPasien(body: {
      "pasien": "",
      "type": 0,
      "user": (context.read<UserCubit>().state as UserLoaded).user.id
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight3,
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            listener: (context, state) {
              if (state is StoryLoaded) {
                setState(() {
                  story = state.stories.length.toString();
                });
              }
            },
            cubit: storyCubit,
          ),
          BlocListener(
            listener: (context, state) {
              if (state is MemberGetLoaded) {
                setState(() {
                  done = state.pasiens.length.toString();
                });
              }
            },
            cubit: memberDoneCubit,
          ),
          BlocListener(
            listener: (context, state) {
              if (state is MemberGetLoaded) {
                setState(() {
                  unDone = state.pasiens.length.toString();
                });
              }
            },
            cubit: memberWillCubit,
          )
        ],
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildAppBar(),
                SizedBox(height: 79.h),
                buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack buildBody(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.03),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              buildAccountContent(
                label: "Story ($story)",
                widgetRight: buildTextLihat(
                  () {
                    Get.to(
                      TerapisMemberStoryPage(
                        id: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .id
                            .toString(),
                        terapis: Terapis(
                          name: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .name,
                          photo: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .photoUrl,
                          phone: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .phone,
                          member: Member(
                            photo:
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .photoUrl,
                            name:
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .name,
                            phone:
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .phone,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              buildAccountContent(
                label: "Pasien yang sudah diterapi ($done)",
                widgetRight: buildTextLihat(() {
                  Get.to(
                    TerapisWithPasienPage(
                      type: 1,
                      id: (context.read<UserCubit>().state as UserLoaded)
                          .user
                          .id
                          .toString(),
                      terapis: Terapis(
                        name: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .name,
                        photo: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .photoUrl,
                        phone: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .phone,
                        member: Member(
                          photo: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .photoUrl,
                          name: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .name,
                          phone: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .phone,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              buildAccountContent(
                label: "Pasien yang akan diterapi ($unDone)",
                widgetRight: buildTextLihat(() {
                  Get.to(
                    TerapisWithPasienPage(
                      type: 0,
                      id: (context.read<UserCubit>().state as UserLoaded)
                          .user
                          .id
                          .toString(),
                      terapis: Terapis(
                        name: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .name,
                        photo: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .photoUrl,
                        phone: (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .phone,
                        member: Member(
                          photo: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .photoUrl,
                          name: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .name,
                          phone: (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .phone,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              buildLabelText("History Transaksi"),
              buildAccountContent(
                onTap: () {
                  Get.to(
                    UserOrderHistory(),
                  );
                },
                label: "Order History",
                widgetRight: Container(
                    padding: EdgeInsets.all(5.w),
                    // decoration:
                    //     BoxDecoration(shape: BoxShape.circle, color: error),
                    child: SizedBox()),
              ),
              buildLabelText("Rumah Sehat",
                  widgetRight: buildButtonUbah(() {})),
              buildAccountContent(
                label: "Nama Rumah Sehat",
                widgetRight: buildTextSubtitle((context
                        .read<MemberTerapisCubit>()
                        .state as MemberTerapisLoaded)
                    .terapis
                    .name),
              ),
              buildAccountContentColumn(
                label: "Alamat Rumah Sehat",
                widget: buildTextSubtitle((context
                        .read<MemberTerapisCubit>()
                        .state as MemberTerapisLoaded)
                    .terapis
                    .address),
              ),
              buildAccountContent(
                label: "Menerima",
                widgetRight: Row(
                  children: [
                    (context.read<MemberTerapisCubit>().state
                                    as MemberTerapisLoaded)
                                .terapis
                                .accept !=
                            null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: (context.read<MemberTerapisCubit>().state
                                    as MemberTerapisLoaded)
                                .terapis
                                .accept
                                .map(
                                  (e) => Text(
                                    "${e ?? "-"}",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      color: textDark1,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : Text(
                            "${"-"}",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: textDark1,
                            ),
                          ),
                  ],
                ),
              ),
              buildAccountContent(
                label: "Tidak Menerima",
                widgetRight: Row(
                  children: [
                    (context.read<MemberTerapisCubit>().state
                                    as MemberTerapisLoaded)
                                .terapis
                                .noAccept !=
                            null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: (context.read<MemberTerapisCubit>().state
                                    as MemberTerapisLoaded)
                                .terapis
                                .noAccept
                                .map(
                                  (e) => Text(
                                    "${e ?? "-"}",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      color: textDark1,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : Text(
                            "${"-"}",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: textDark1,
                            ),
                          ),
                  ],
                ),
              ),
              buildAccountContent(
                label: "Tingkat Release",
                widgetRight: buildTextSubtitle("-"),
              ),
              buildLabelText("Data Diri", widgetRight: buildButtonUbah(() {
                Get.to(EditProfileScreen());
              })),
              buildAccountContent(
                label: "Nama",
                widgetRight: buildTextSubtitle(
                  (context.read<UserCubit>().state as UserLoaded).user.name ??
                      "-",
                ),
              ),
              buildAccountContent(
                  label: "NIK",
                  widgetRight: buildTextSubtitle(
                    (context.read<UserCubit>().state as UserLoaded).user.nik ??
                        "-",
                  )),
              buildAccountContent(
                  label: "No. Hp",
                  widgetRight: buildTextSubtitle(
                      (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .phone ??
                          "-")),
              buildAccountContent(
                  label: "ID Sertifikat",
                  widgetRight: buildTextSubtitle(
                    (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .certificateId ??
                        "-",
                  )),
              buildLabelText("Akun", widgetRight: buildButtonUbah(() {
                Get.to(EditAccountScreen());
              })),
              buildAccountContent(
                  label: "Email",
                  widgetRight: buildTextSubtitle(
                    (context.read<UserCubit>().state as UserLoaded)
                            .user
                            .email ??
                        "-",
                  )),
              SizedBox(height: 40.h),
              ButtonWidget(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove("UserId");

                  Get.off(SplashPage());
                },
                label: "Keluar",
                textColor: secondary1,
                textStyle: ralewayTextStyle,
                borderColor: secondary7,
                backgroundColor: secondary7,
              ),
              SizedBox(height: defaultMargin),
            ],
          ),
        ),
        buildImageAccount(context),
      ],
    );
  }

  GestureDetector buildButtonUbah(Function onTap) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Text("Ubah",
          style: ralewayTextStyle.copyWith(
              fontSize: 12.sp, color: primary1, fontWeight: FontWeight.w600)),
    );
  }

  Widget buildTextSubtitle(String subtitle,
      {TextAlign textAlign = TextAlign.end}) {
    return Container(
      child: Text(subtitle ?? "-",
          textAlign: textAlign,
          style: ralewayTextStyle.copyWith(color: textDark1, fontSize: 12.sp)),
    );
  }

  CustomAppBarWidget buildAppBar() {
    return CustomAppBarWidget(
      onTap: () {},
      widgetLeft: Text("Akun",
          style: playfairDisplayTextStyle.copyWith(
              fontSize: 24.sp, color: textDark1, fontWeight: FontWeight.w700)),
    );
  }

  Padding buildLabelText(String label, {Widget widgetRight}) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: ralewayTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: textDark1)),
          (widgetRight != null) ? widgetRight : SizedBox()
        ],
      ),
    );
  }

  Widget buildTextLihat(GestureTapCallback onTap) {
    return GestureDetector(
      child: Text("Lihat",
          style: ralewayTextStyle.copyWith(
              fontSize: 12.sp,
              color: primary1,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }

  Positioned buildImageAccount(BuildContext context) {
    return Positioned(
      top: -36.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: FadeInImage(
          height: 72.w,
          width: 72.w,
          placeholder: AssetImage("assets/images/placeholder.jpg"),
          image: NetworkImage(
            (context.read<UserCubit>().state as UserLoaded).user.photoUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  GestureDetector buildAccountContent(
      {String label, Widget widgetRight, Function onTap}) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
          margin: EdgeInsets.only(top: 8.h),
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8.h),
          decoration: BoxDecoration(
              color: bgLight1,
              border: Border.all(color: grey2),
              borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "$label",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: textDark2,
                  ),
                ),
              ),
              widgetRight
            ],
          )),
    );
  }

  GestureDetector buildAccountContentColumn(
      {String label, Widget widget, Function onTap}) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
          margin: EdgeInsets.only(top: 8.h),
          width: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8.h),
          decoration: BoxDecoration(
              color: bgLight1,
              border: Border.all(color: grey2),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$label",
                  style: ralewayTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: textDark2,
                  )),
              SizedBox(height: 8.h),
              widget
            ],
          )),
    );
  }
}
