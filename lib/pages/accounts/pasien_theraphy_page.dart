import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class TerapisWithPasienPage extends StatefulWidget {
  final String id;
  final Terapis terapis;
  final int type;

  const TerapisWithPasienPage({Key key, this.id, this.terapis, this.type})
      : super(key: key);

  @override
  _TerapisWithPasienPageState createState() => _TerapisWithPasienPageState();
}

class _TerapisWithPasienPageState extends State<TerapisWithPasienPage> {
  final pasienCubit = MemberGetCubit();
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
    pasienCubit.getMemberPasien(
        body: {"pasien": param, "type": widget?.type ?? 1, "user": widget.id});
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
                          "Pasien Saya",
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
        if (state is MemberGetLoaded) if (state.pasiens != null)
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
                  if(widget.type == 0)
                    return MemberWillTerapiItem(
                      pasien: state.pasiens[index],
                    );
                  return MemberTerapiItem(
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
        else if (state is MemberGetLoadingFailed) {
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
                widget.type == 1 ? "Pasien" : "Pasien Yang Akan Diterapi",
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
