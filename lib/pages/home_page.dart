
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/pages/blog/blog_fragment.dart';
import 'package:tsi_mobile/pages/blog/blog_page.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight3,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLogoAndNotification(),
              buildBlogBanner(),
              buildLabel("Pasien"),
              buildPasienCard1(),
              buildPasienCard2(),
              buildPasienCard3(),
              buildLabel("Sudah Diterapi"),
              buildSudahDiterapiCard(),
              buildLabelPelatihan(),
              buildPelatihan(),
              buildLabelLihatSemua(
                label: "Story",
                onTap: () {
                  Get.to(StoryPage());
                },
              ),
              buildStory(),
              buildLabelLihatSemua(label: "Terapis", onTap: () {}),
              buildTerapis(),
              buildLabelLihatSemua(
                label: "Blog",
                onTap: () {
                  Get.to(BlogPage());
                },
              ),
              BlogHomeFragment(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTerapis() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Yuk  lihat terapis TSI dengan pasien terbanyak",
              style:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3)),
          BlocBuilder<TerapisCubit, TerapisState>(
            builder: (_, state) {
              if (state is TerapisLoaded) if (state.terapies != null)
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.only(top: 19.h),
                  itemCount:
                      state.terapies.length >= 5 ? 5 : state.terapies.length,
                  itemBuilder: (_, index) {
                    printInfo(info: index.toString());
                    return Container(
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.only(bottom: 16.h),
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
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              state.terapies[index].member.photo,
                              width: 58.w,
                              height: 58.w,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${state.terapies[index]?.member?.name ?? ""}",
                                        style:
                                            playfairDisplayTextStyle.copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: textDark1),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/verifikasi.svg",
                                      height: 12.w,
                                      width: 12.w,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${state.terapies[index].member?.jenisKelamin ?? "Tidak Disebutkan"}",
                                        style: ralewayTextStyle.copyWith(
                                            fontSize: 8.sp, color: textDark2)),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        height: 4.w,
                                        width: 4.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            color: textDark2)),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                    Text(
                                      "${personAge(
                                        state.terapies[index].member
                                                    ?.tanggalLahir !=
                                                null
                                            ? DateTime.parse(
                                                state.terapies[index].member
                                                    ?.tanggalLahir,
                                              )
                                            : null,
                                      )} Tahun",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 8.sp, color: textDark2),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text("${state.terapies[index].location}",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 8.sp, color: textDark2)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              else
                return SizedBox();
              else if (state is TerapisLoadingFailed) {
                return Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Text(
                    state?.message ?? "Data Tidak Ditemukan.",
                    textAlign: TextAlign.center,
                    style: ralewayTextStyle.copyWith(
                        fontSize: 13.sp,
                        color: error,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return loadingIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Padding buildStory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Yuk baca TSIStory hari ini",
              style:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3)),
          BlocBuilder<StoryCubit, StoryState>(
            builder: (_, state) {
              if (state is StoryLoaded) if (state.stories != null)
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.only(top: 19.h),
                  itemCount:
                      state.stories.length >= 5 ? 5 : state.stories.length,
                  itemBuilder: (_, index) {
                    printInfo(info: index.toString());
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          StoryDetailPage(
                            storyModel: state.stories[index],
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 11.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: FadeInImage(
                                placeholder:
                                    AssetImage("assets/images/placeholder.jpg"),
                                image: NetworkImage(
                                  state.stories[index].cover,
                                ),
                                placeholderErrorBuilder: (_, s, v) {
                                  return Image.asset(
                                      "assets/images/placeholder.jpg");
                                },
                                width: 80.w,
                                height: 92.w,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(11.w),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.stories[index].title}",
                                      style: playfairDisplayTextStyle.copyWith(
                                          fontSize: 12.sp, color: textDark1)),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        UniconsLine.calender,
                                        size: 10.sp,
                                        color: textDark2,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                        width: 2.h,
                                      ),
                                      Text(
                                          "${toDateString(
                                            DateTime.parse(
                                                state.stories[index].created),
                                          )}",
                                          style: ralewayTextStyle.copyWith(
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.w400,
                                              color: textDark2))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        UniconsLine.user,
                                        size: 10.sp,
                                        color: textDark2,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                        width: 2.h,
                                      ),
                                      Text(
                                          "${state.stories[index].terapis.name}",
                                          style: ralewayTextStyle.copyWith(
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.w400,
                                              color: textDark2)),
                                      SizedBox(
                                        height: 2.h,
                                        width: 2.h,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/verifikasi.svg",
                                        height: 8.w,
                                        width: 8.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              else
                return SizedBox();
              else if (state is StoryLoadingFailed) {
                return Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Text(
                    state?.message ?? "Data Tidak Ditemukan.",
                    textAlign: TextAlign.center,
                    style: ralewayTextStyle.copyWith(
                        fontSize: 13.sp,
                        color: error,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return loadingIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Padding buildLabelLihatSemua({String label, Function onTap}) {
    return buildLabelButton(
        label,
        GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Text("Lihat Semua",
              style: ralewayTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: primary1)),
        ));
  }

  Column buildPelatihan() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: CustomTabBarWidget(
            titles: ["All", "Terdekat"],
            selectedIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
        (selectedIndex == 0) ? PelatihanWidget() : PelatihanWidget(),
      ],
    );
  }

  Padding buildLabelPelatihan() {
    return buildLabelButton(
        "Pelatihan",
        IconButton(
          icon: Icon(
            UniconsLine.search,
            size: 15.sp,
            color: textDark2,
          ),
          onPressed: () {},
        ));
  }

  Widget buildSudahDiterapiCard() {
    return HomeTherapyDone();
  }

  Container buildPasienCard3() {
    return buildPasienCard(
      icon: Icon(
        UniconsLine.accessible_icon_alt,
        color: blue2,
        size: 15.sp,
      ),
      label: "Release",
      labelData: "87%",
      iconBgColor: blue1,
      subtitle: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
            text: "dari ",
            style: ralewayTextStyle.copyWith(fontSize: 8.sp, color: textDark3)),
        TextSpan(
            text: "80 ",
            style: ralewayTextStyle.copyWith(fontSize: 8.sp, color: primary1)),
        TextSpan(
            text: "pasien",
            style: ralewayTextStyle.copyWith(fontSize: 8.sp, color: textDark1))
      ])),
    );
  }

  Padding buildPasienCard2() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: buildPasienCard(
        icon: Icon(
          UniconsLine.clipboard_notes,
          color: orange2,
          size: 15.sp,
        ),
        label: "Hari Ini",
        labelData: "6",
        iconBgColor: orange1,
        subtitle: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "-3 kali ",
              style: ralewayTextStyle.copyWith(fontSize: 8.sp, color: red)),
          TextSpan(
              text: "dari kemarin",
              style:
                  ralewayTextStyle.copyWith(fontSize: 8.sp, color: textDark1))
        ])),
      ),
    );
  }

  Container buildPasienCard1() {
    return buildPasienCard(
      icon: Icon(
        UniconsLine.wheelchair,
        color: primary1,
        size: 15.sp,
      ),
      label: "Total",
      labelData: "80",
      iconBgColor: primary6,
      subtitle: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
            text: "+12 pasien ",
            style: ralewayTextStyle.copyWith(fontSize: 8.sp, color: primary1)),
        TextSpan(
            text: "dari kemarin",
            style: ralewayTextStyle.copyWith(fontSize: 8.sp, color: textDark1))
      ])),
    );
  }

  Container buildPasienCard(
      {Icon icon,
      Color iconBgColor,
      String label,
      String labelData,
      Text subtitle}) {
    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(100.r)),
                  child: icon),
              SizedBox(width: 7.w),
              Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "$label: ",
                    style: ralewayTextStyle.copyWith(
                        fontSize: 12.sp, color: textDark3)),
                TextSpan(
                    text: "$labelData",
                    style: ralewayTextStyle.copyWith(
                        fontSize: 16.sp,
                        color: textDark1,
                        fontWeight: FontWeight.w700))
              ])),
            ],
          ),
          subtitle
        ],
      ),
    );
  }

  Padding buildLabelButton(String label, Widget button) {
    return Padding(
      padding: EdgeInsets.fromLTRB(defaultMargin, 24.h, defaultMargin, 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? '',
            style: ralewayTextStyle.copyWith(
                fontSize: 16.sp, fontWeight: FontWeight.w700, color: textDark1),
          ),
          button
        ],
      ),
    );
  }

  Padding buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(defaultMargin, 24.h, defaultMargin, 8.h),
      child: Text(
        label ?? '',
        style: ralewayTextStyle.copyWith(
            fontSize: 16.sp, fontWeight: FontWeight.w700, color: textDark1),
      ),
    );
  }

  Padding buildBlogBanner() {
    return Padding(
      padding: EdgeInsets.only(top: 29.h),
      child: SizedBox(
        height: 140.h,
        child: BlocBuilder<BannerCubit, BannerState>(
          builder: (_, state) {
            if (state is BannerLoaded) {
              if (state.banners != null) {
                return SizedBox(
                  height: 125.h,
                  child: ListView.builder(
                    itemCount: state.banners.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return BlogBannerWidget(
                          image: state.banners[index].imageUrl,
                          label: state.banners[index].title,
                          paddingLeft: defaultMargin,
                          paddingRight: (index + 1 == state.banners.length)
                              ? defaultMargin
                              : 0,
                          onTap: () {});
                    },
                  ),
                );
              } else {
                return SizedBox();
              }
            } else if (state is BannerLoadingFailed) {
              return Padding(
                padding: EdgeInsets.all(10.w),
                child: Text(
                  state?.message ?? "Data Tidak Ditemukan.",
                  textAlign: TextAlign.center,
                  style: ralewayTextStyle.copyWith(
                      fontSize: 13.sp,
                      color: error,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return loadingIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildLogoAndNotification() {
    return CustomAppBarWidget(
      widgetLeft: Image.asset(
        "assets/images/logo.png",
        height: 38.h,
        width: 77.w,
        fit: BoxFit.contain,
      ),
      icon: UniconsLine.bell,
      onTap: () {},
    );
  }
}
