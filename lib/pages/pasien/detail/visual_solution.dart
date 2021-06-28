import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/no_data.dart';
import 'package:tsi_mobile/widgets/terapis/terapis.dart';

class VisualSolutionFragment extends StatefulWidget {
  final Release release;

  const VisualSolutionFragment({Key key, this.release}) : super(key: key);

  @override
  _VisualSolutionFragmentState createState() => _VisualSolutionFragmentState();
}

class _VisualSolutionFragmentState extends State<VisualSolutionFragment> {
  Release release;
  final checkSuggest = CheckSuggestCubit();

  @override
  void initState() {
    release = widget.release;
    getCheckSuggest();
    super.initState();
  }

  void getCheckSuggest() {
    final body = {
      "pubis": jsonEncode(release.pubis.toJson()),
      "anomali": jsonEncode(release.anomali.toJson()),
    };

    checkSuggest.checkSuggest(body: body);
  }

  @override
  void didUpdateWidget(covariant VisualSolutionFragment oldWidget) {
    if (release != widget.release) {
      getCheckSuggest();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visual Penyimpangan",
            style: ralewayTextStyle.copyWith(
              fontSize: 20.sp,
              color: textDark1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 18.sp,
          ),
          BlocBuilder(
            builder: (context, state) {
              print(state);
              if (state is CheckSuggestLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAreaTerapisWidget(
                      title: "Jenis",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.visualisasi?.penyimpangan?.jenis ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Kaki Kanan",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.detail?.kakiKanan?.depanSamping ?? "-"}, ${state.suggest?.detail?.kakiKanan?.atasBawah ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Kaki Kiri",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.detail?.kakiKiri?.depanSamping ?? "-"}, ${state.suggest?.detail?.kakiKiri?.atasBawah ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Varian",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.visualisasi?.penyimpangan?.variant ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Anomali",
                      rightWidget: Row(
                        children: [
                          Text(
                            "Lumbar ${release?.anomali?.lumbar ?? "-"}",
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
                );
              }

              return Center(
                child: NoDataWidget(
                  message: "Tidak Ada Data",
                ),
              );
            },
            cubit: checkSuggest,
          ),
          SizedBox(
            height: 30.sp,
          ),
          Text(
            "Visual Solusi",
            style: ralewayTextStyle.copyWith(
              fontSize: 20.sp,
              color: textDark1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 18.sp,
          ),
          BlocBuilder(
            builder: (context, state) {
              print(state);
              if (state is CheckSuggestLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAreaTerapisWidget(
                      title: "Jenis",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.visualisasi?.solusi?.jenis ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Kaki Kanan",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.detail?.kakiKanan?.depanSamping ?? "-"}, ${state.suggest?.detail?.kakiKanan?.atasBawah ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Kaki Kiri",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.detail?.kakiKiri?.depanSamping ?? "-"}, ${state.suggest?.detail?.kakiKiri?.atasBawah ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Varian",
                      rightWidget: Row(
                        children: [
                          Text(
                            "${state.suggest?.visualisasi?.solusi?.variant ?? "-"}",
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
                      height: 8.sp,
                    ),
                    TextAreaTerapisWidget(
                      title: "Anomali",
                      rightWidget: Row(
                        children: [
                          Text(
                            "Lumbar ${release?.anomali?.lumbar ?? "-"}",
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
                );
              }

              return Center(
                child: NoDataWidget(
                  message: "Tidak Ada Data",
                ),
              );
            },
            cubit: checkSuggest,
          ),
        ],
      ),
    );
  }
}
