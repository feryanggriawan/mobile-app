import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TerapisPasienPage extends StatefulWidget {
  final String id;
  final Terapis terapis;

  const TerapisPasienPage({Key key, this.id, this.terapis}) : super(key: key);

  @override
  _TerapisPasienPageState createState() => _TerapisPasienPageState();
}

class _TerapisPasienPageState extends State<TerapisPasienPage> {
  final pasienCubit = PasienCubit();
  final searchTextController = TextEditingController();

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
      "type": "penyakit",
      // "user" : 13,
      "user": widget.id
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: AnimatedAppbarWidget(
                  pixels: 51.h,
                  title: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          image: DecorationImage(
                            image: NetworkImage(widget.terapis?.photo ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 35.sp,
                        height: 35.sp,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Story",
                              overflow: TextOverflow.ellipsis,
                              style: playfairDisplayTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Text(
                              "By ${widget.terapis?.name ?? ""}".toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: ralewayTextStyle.copyWith(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w700,
                                  color: textDark1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  showHideIn: 50.h,
                ),
              ),
              buildAppBarSearch(),
              builListData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget builListData() {
    return BlocBuilder(
      cubit: pasienCubit,
      builder: (_, state) {
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
                  return TerapisPasienItemExpanded(
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10.h),
      child: TextFormField(
        onFieldSubmitted: (value) {
          getPasien(searchTextController.text);
          return null;
        },
        onSaved: (value) {},
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              if (searchTextController.text.isEmpty)
                getPasien(searchTextController.text);
              else
                setState(
                  () {
                    searchTextController.clear();
                    getPasien(searchTextController.text);
                  },
                );
            },
            child: Container(
              margin: EdgeInsets.all(6.h),
              child: Icon(
                searchTextController.text.isEmpty ? Icons.search : Icons.close,
                color: Colors.white,
                size: 12.h,
              ),
              decoration: BoxDecoration(
                color: searchTextController.text.isEmpty
                    ? Colors.orange
                    : Colors.red,
                borderRadius: BorderRadius.circular(50.h),
              ),
            ),
          ),
          hintText: 'Search...',
          hintStyle:
              ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
        ),
        controller: searchTextController,
      ),
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
        ],
      ),
    );
  }
}
