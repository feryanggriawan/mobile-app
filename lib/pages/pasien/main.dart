import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsi_mobile/cubit/diesease/disease_cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasienFragment extends StatefulWidget {
  @override
  _PasienFragmentState createState() => _PasienFragmentState();
}

class _PasienFragmentState extends State<PasienFragment> {
  final pasienCubit = PasienCubit();
  final searchTextController = TextEditingController();
  String searchType = "penyakit";

  String search;

  @override
  void initState() {
    getPasien("");
    searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void getPasien(String param) {
    pasienCubit.getSearchPasien(body: {
      "search": param,
      "type": searchType,
      "user": (context.read<UserCubit>().state as UserLoaded).user.id
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAppBarSearch(),
            builListData(),
          ],
        ),
      ),
    );
  }

  Widget builListData() {
    return BlocBuilder(
      cubit: pasienCubit,
      builder: (_, state) {
        if(state is PasienInitial){
          return SpinKitCircle(color: primary1,);
        }
        if (state is PasienLoaded) if (state.pasiens != null)
          return Column(
            children: [
              buildFilter(state.pasiens.length.toString()),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 19.h),
                itemCount: state.pasiens.length,
                itemBuilder: (_, index) {
                  printInfo(info: index.toString());
                  return PasienItemExpanded(
                    pasien: state.pasiens[index],
                  );
                },
              ),
            ],
          );
        else
          return Center(
            child: NoDataWidget(
              message: "Belum Ada Pasien",
            ),
          );
        else if (state is PasienLoadingFailed) {
          return Padding(
            padding: EdgeInsets.all(10.w),
            child: Center(
              child: NoDataWidget(
                message: "Belum Ada Pasien",
              ),
            ),
          );
        } else {
          return loadingIndicator();
        }
      },
    );
  }

  Widget buildAppBarSearch() {
    return AppBarWithSearchWidget(
      onTap: () {
        if (searchTextController.text.isEmpty)
          return;
        else
          setState(
            () {
              searchType = "penyakit";
              searchTextController.clear();
              getPasien(searchTextController.text);
            },
          );
      },
      onFieldSubmitted: (value) {
        setState(() {
          searchType = "nama";
        });
        getPasien(searchTextController.text);
        return null;
      },
      textEditingController: searchTextController,
    );
  }

  Widget buildFilter(String length) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 5.h),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                "Terdapat",
                style: ralewayTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: textDark1),
              ),
              Text(
                " $length ",
                style: ralewayTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: primary1),
              ),
              Text(
                "Pasien",
                style: ralewayTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: textDark1),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () => buildBottomSheet(title: "Pilih Filter Berdasarkan"),
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
        ],
      ),
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
                      items:
                          (context.read<DiseaseCubit>().state as DiseaseLoaded)
                              .diseases
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(
                                    e.name,
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 14.sp),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (v) {
                        setState(() {
                          search = v;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Penyakit...',
                        // hintStyle:
                        // ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
                      ),
                      value: search,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    if (search != null)
                      ButtonWidget(
                        label: "Reset",
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        borderColor: Colors.transparent,
                        textStyle: buttonTextNoneStyle,
                        onTap: () async {
                          setState(() {
                            search = null;
                          });
                          getPasien("");
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
                        getPasien(search);
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: 70.h,
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
}
