import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/terapis/terapis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicons/unicons.dart';

class TerapisDataWidget extends StatefulWidget {
  final Terapis terapis;
  final bool expanded;

  const TerapisDataWidget({Key key, this.terapis, this.expanded})
      : super(key: key);

  @override
  _TerapisDataWidgetState createState() => _TerapisDataWidgetState();
}

class _TerapisDataWidgetState extends State<TerapisDataWidget> {
  final storyCubit = StoryCubit();
  final pasienCubit = PasienCubit();

  bool expanded = false;

  @override
  void initState() {
    storyCubit.getSearchStories(
      body: {
        "user": widget.terapis.member.id,
        "search": "",
      },
    );
    pasienCubit.getSearchPasien(
      body: {
        "user": widget.terapis.member.id,
        "search": "",
        "type" : "penyakit"
      },
    );
    print(widget.terapis.member.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(),
      secondChild: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BlocBuilder(
                    cubit: pasienCubit,
                    builder: (context, state) {
                      if (state is PasienLoaded) {
                        return TextAreaTerapisWidget(
                          title: "Pasien (${state.pasiens.length})",
                          rightWidget: GestureDetector(
                            onTap: () => Get.to(
                              TerapisPasienPage(
                                id: widget.terapis.member.id.toString(),
                                terapis: widget.terapis,
                              ),
                            ),
                            child: Text(
                              "Lihat",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: primary1,
                              ),
                            ),
                          ),
                        );
                      }
                      return TextAreaTerapisWidget(
                        title: "Pasien (0)",
                        rightWidget: GestureDetector(
                          onTap: () => Get.to(
                            TerapisPasienPage(
                              id: widget.terapis.member.id.toString(),
                              terapis: widget.terapis,
                            ),
                          ),
                          child: Text(
                            "Lihat",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: primary1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: BlocBuilder(
                    cubit: storyCubit,
                    builder: (context, state) {
                      if (state is StoryLoaded) {
                        return TextAreaTerapisWidget(
                          title: "Story (${state.stories.length})",
                          rightWidget: GestureDetector(
                            onTap: () => Get.to(
                              TerapisStoryPage(
                                id: widget.terapis.member.id.toString(),
                                terapis: widget.terapis,
                              ),
                            ),
                            child: Text(
                              "Lihat",
                              style: ralewayTextStyle.copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: primary1,
                              ),
                            ),
                          ),
                        );
                      }
                      return TextAreaTerapisWidget(
                        title: "Story (0)",
                        rightWidget: GestureDetector(
                          onTap: () => Get.to(
                            TerapisStoryPage(
                              id: widget.terapis.member.id.toString(),
                              terapis: widget.terapis,
                            ),
                          ),
                          child: Text(
                            "Lihat",
                            style: ralewayTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: primary1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            TextAreaTerapisWidget(
                title: "No. Hp",
                rightWidget: Row(
                  children: [
                    Text(
                      "${widget.terapis?.phone ?? "-"}",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      child: Text(
                        "Copy",
                        style: ralewayTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: primary1,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 8.h,
            ),
            TextAreaTerapisWidget(
                title: "Contact",
                rightWidget: Row(
                  children: [
                    GestureDetector(
                        child: Icon(
                      UniconsLine.whatsapp,
                      color: textDark2,
                      size: 14.w,
                    )),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                        child: Icon(
                      UniconsLine.chat,
                      color: textDark2,
                      size: 14.w,
                    )),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                        child: Icon(
                      UniconsLine.phone,
                      color: textDark2,
                      size: 14.w,
                    )),
                  ],
                )),
            SizedBox(
              height: 15.h,
            ),
            TextAreaTerapisWidget(
                title: "Rumah Sehat",
                rightWidget: Row(
                  children: [
                    Text(
                      "${widget.terapis?.name ?? "-"}",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 8.h,
            ),
            TextAreaTerapisWidget(
              title: "Alamat Rumah Sehat",
              isVertical: true,
              rightWidget: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.terapis?.address ?? "-"}",
                      style: ralewayTextStyle.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextAreaTerapisWidget(
              title: "Menerima",
              rightWidget: Row(
                children: [
                  widget.terapis.noAccept != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: widget.terapis.accept
                              .map(
                                (e) => Text(
                                  "${e ?? "-"}",
                                  style: ralewayTextStyle.copyWith(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          "${"-"}",
                          style: ralewayTextStyle.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextAreaTerapisWidget(
              title: "Tidak Menerima",
              rightWidget: Row(
                children: [
                  widget.terapis.noAccept != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: widget.terapis.noAccept
                              .map(
                                (e) => Text(
                                  "${e ?? "-"}",
                                  style: ralewayTextStyle.copyWith(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          "${"-"}",
                          style: ralewayTextStyle.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextAreaTerapisWidget(
              title: "Pelatihan",
              rightWidget: Row(
                children: [
                  Text(
                    "${"-"}",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextAreaTerapisWidget(
              title: "Tingkat Release",
              rightWidget: Row(
                children: [
                  Text(
                    "${"-"}",
                    style: ralewayTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      crossFadeState: !widget.expanded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 300),
    );
  }
}
