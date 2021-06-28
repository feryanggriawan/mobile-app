import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsi_mobile/models/location_model/location_model.dart';
import 'package:tsi_mobile/models/location_model/province_model.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class TerapisMainScreen extends StatefulWidget {
  @override
  _TerapisMainScreenState createState() => _TerapisMainScreenState();
}

class _TerapisMainScreenState extends State<TerapisMainScreen> {
  final terapisCubit = TerapisCubit();
  String searchType = "nama";

  ProvinceModel provinsi;
  LocationModel kota;

  @override
  void initState() {
    getTerapis("");
    super.initState();
  }

  void getTerapis(String seacrh) {
    terapisCubit.getSearchTerapis(body: {"search": seacrh, "type": searchType});
  }

  Future<Null> getLocation() async {
    await context.read<ProvinceCubit>().getProvinces();
    provinsi =
        (context.read<ProvinceCubit>().state as ProvinceLoaded).provinces[0];

    await context.read<CityCubit>().getCity(provinsi.id);
    kota = (context.read<CityCubit>().state as CityLoaded).citys[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 1.h,
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBarSearch(),
              buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget terapisBuilder() {
    return BlocBuilder(
      cubit: terapisCubit,
      builder: (_, state) {
        if (state is TerapisInitial) {
          return SpinKitCircle(
            color: primary1,
          );
        }
        if (state is TerapisLoaded) if (state.terapies != null)
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 19.h),
            itemCount: state.terapies.length,
            itemBuilder: (_, index) {
              printInfo(info: index.toString());
              return TerapiItemExpanded(
                terapis: state.terapies[index],
              );
            },
          );
        else
          return Center(
            child: NoDataWidget(
              message: "Belum Ada Terapis",
            ),
          );
        else if (state is TerapisLoadingFailed) {
          return Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                Text(
                  state?.message ?? "Data Tidak Ditemukan.",
                  textAlign: TextAlign.center,
                  style: ralewayTextStyle.copyWith(
                      fontSize: 13.sp,
                      color: error,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        } else {
          return loadingIndicator();
        }
      },
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.sp),
        Text(
          "Temukan terapis berkompeten disini",
          style: ralewayTextStyle.copyWith(
            fontSize: 14.sp,
            color: primary1,
          ),
        ),
        SizedBox(height: 5.sp),
        terapisBuilder(),
      ],
    );
  }

  Widget buildAppBarSearch() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Terapis",
            style: playfairDisplayTextStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: textDark1,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            buildBottomSheet(title: "Pilih Filter Berdasarkan");
          },
          child: Chip(
            label: Text(
              "Filter",
              style: ralewayTextStyle.copyWith(
                fontSize: 12.sp,
                color: textDark2,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            labelPadding: EdgeInsets.only(right: 10.w),
            avatar: Icon(
              Icons.filter_alt_outlined,
              color: textDark2,
              size: 16.sp,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        GestureDetector(
          child: Icon(
            Icons.search,
            color: textDark2,
            size: 26.sp,
          ),
        )
      ],
    );
  }

  RoundedRectangleBorder buildRoundedRectangleBorder() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)));
  }

  void buildBottomSheet({String title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: buildRoundedRectangleBorder(),
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 20.h,
                    left: defaultMargin,
                    right: defaultMargin),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(UniconsLine.multiply),
                      onTap: () => Get.back(),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      title,
                      style: header1Style.copyWith(
                          fontSize: 16.sp, color: textDark1),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    DropdownButtonFormField(
                      iconSize: 14.sp,
                      isDense: true,
                      isExpanded: true,
                      items: (context.read<ProvinceCubit>().state
                              as ProvinceLoaded)
                          .provinces
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name,
                                style:
                                    ralewayTextStyle.copyWith(fontSize: 14.sp),
                              ),
                            ),
                          )
                          .toList(),
                      decoration: InputDecoration(
                        hintText: 'Provinsi...',
                      ),
                      onChanged: (v) {
                        updateProvinsi(state, v);
                      },
                      value: provinsi,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    DropdownButtonFormField(
                      iconSize: 14.sp,
                      isDense: true,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: 'Kota...',
                      ),
                      items: (context.read<CityCubit>().state as CityLoaded)
                          .citys
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.cityName,
                                style:
                                    ralewayTextStyle.copyWith(fontSize: 14.sp),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        updateKota(state, v);
                      },
                      value: kota,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    if (kota != null || provinsi != null)
                      ButtonWidget(
                        label: "Reset",
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        borderColor: Colors.transparent,
                        textStyle: buttonTextNoneStyle,
                        onTap: () async {
                          setState(() {
                            searchType = "nama";
                            kota = null;
                            provinsi = null;
                          });
                          getTerapis("");

                          Get.back();
                        },
                      ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ButtonWidget(
                      label: "Terapkan",
                      textStyle: buttonTextNoneStyle,
                      onTap: () async {
                        if (kota != null) {
                          setState(() {
                            searchType = "kota";
                          });
                          getTerapis(kota.cityName);
                        }
                        if (provinsi != null) {
                          setState(() {
                            searchType = "kota";
                          });
                          getTerapis(kota.cityName);
                        } else {
                          setState(() {
                            searchType = "nama";
                          });
                          getTerapis("");
                        }
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Null> updateProvinsi(
      StateSetter updateState, ProvinceModel newProvinsi) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return customLoadingIndicator;
      },
    );
    updateState(() {
      provinsi = newProvinsi;
    });

    await context.read<CityCubit>().getCity(provinsi.id);
    updateState(() {
      kota = (context.read<CityCubit>().state as CityLoaded).citys[0];
    });
    Get.back();
  }

  Future<Null> updateKota(
      StateSetter updateState, LocationModel newKota) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return customLoadingIndicator;
      },
    );
    updateState(() {
      kota = newKota;
    });
    await context.read<DistrictCubit>().getDistrict(kota.id);

    Get.back();
  }
}
