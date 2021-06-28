import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsi_mobile/cubit/carrier/carrier_cubit.dart';
import 'package:tsi_mobile/cubit/cart/cart_cubit.dart';
import 'package:tsi_mobile/cubit/diesease/disease_cubit.dart';
import 'package:tsi_mobile/cubit/payment_method/payment_method_cubit.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/main_page.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoad = true;

  bool hidePassword = true;

  String password,
      email,
      name,
      nik,
      idSertifikat,
      phoneNumber,
      ktp,
      address,
      confirmPassword,
      username;

  ProvinceModel provinsi;
  LocationModel kota, kabupaten, kecamatan, location;

  Widget widgetSignIn, widgetSignUp1, widgetSignUp2, widgetSignUp3;

  @override
  void initState() {
    super.initState();

    cekLogin();
  }

  Icon iconNextWidget() {
    return Icon(
      UniconsLine.arrow_right,
      color: textLight2,
    );
  }

  void cekLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("UserId");

    getLocation();
    if (userId == null) {
      setState(() {
        isLoad = false;
        widgetSignIn = iconNextWidget();
        widgetSignUp1 = iconNextWidget();
        widgetSignUp2 = iconNextWidget();
        widgetSignUp3 = iconNextWidget();
      });
    } else {
      await context.read<UserCubit>().getProfile(userId);
      await context
          .read<MemberTerapisCubit>()
          .getTerapis(id: userId.toString());
      context.read<CourseOfflineCubit>().getCoursesOffline();
      context.read<CourseOnlineCubit>().getCoursesOnline();
      context.read<BannerCubit>().getBanners();
      context.read<ProductCubit>().getAllProducts();
      context.read<DiseaseCubit>().getDisease();
      context.read<CarrierCubit>().getCarrier();
      context.read<PaymentMethodCubit>().getPaymentMethod();
      context.read<CartCubit>().getCart(userId.toString());
      context.read<StoryCubit>().getStories(body: {
        "story": "",
      });
      context.read<TerapisCubit>().getTerapis(body: {
        "terapis": "",
      });
      context.read<BlogCubit>().getBlogs(body: {
        "blog": "",
      });
      Get.off(MainPage());
    }
  }

  Future<Null> getLocation() async {
    await context.read<ProvinceCubit>().getProvinces();
    provinsi =
        (context.read<ProvinceCubit>().state as ProvinceLoaded).provinces[0];

    await context.read<CityCubit>().getCity(provinsi.id);
    kota = (context.read<CityCubit>().state as CityLoaded).citys[0];

    await context.read<DistrictCubit>().getDistrict(kota.id);
    kabupaten =
        (context.read<DistrictCubit>().state as DistrictLoaded).districts[1];

    await context.read<SubdistrictCubit>().getSubdistrict(kabupaten.id);
    kecamatan = (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
        .subdistricts[0];

    await context.read<LocationCubit>().getLocation(kecamatan.id);
    location = (context.read<LocationCubit>().state as LocationLoaded).location;
  }

  final _formKeySignIn = GlobalKey<FormState>();
  final _formKeySignUp1 = GlobalKey<FormState>();
  final _formKeySignUp2 = GlobalKey<FormState>();
  final _formKeySignUp3 = GlobalKey<FormState>();
  final _formKeyForgotPassword = GlobalKey<FormState>();
  final _formKeyChangePassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgLight1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              buildImage(),
              (isLoad)
                  ? Padding(
                      padding: EdgeInsets.only(top: 72.h),
                      child: loadingIndicator(size: 30),
                    )
                  : buildButtonLoginRegister(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtonLoginRegister() {
    return Padding(
      padding: EdgeInsets.only(top: 131.h),
      child: Column(
        children: [
          ButtonWidget(
            label: "Masuk",
            textStyle: buttonTextNoneStyle,
            onTap: () => buildBottomSheetSignIn(),
          ),
          SizedBox(
            height: 24.h,
          ),
          ButtonWidget(
            label: "Daftar",
            textStyle: buttonTextNoneStyle,
            textColor: secondary2,
            borderColor: secondary2,
            backgroundColor: Colors.white,
            onTap: () => buildBottomSheetSignUp1(),
          )
        ],
      ),
    );
  }

  Image buildImage() {
    return Image.asset(
      "assets/images/logo.png",
      fit: BoxFit.cover,
      height: 83.h,
      // width: 164.w,
    );
  }

  void buildBottomSheetSignIn({String title}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: buildRoundedRectangleBorder(),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, state) {
            return Form(
              key: _formKeySignIn,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 28.h, left: 28.w),
                        child: IconButton(
                          icon: Icon(UniconsLine.multiply),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Center(
                        child: Text(
                          "Masuk",
                          style: header1Style.copyWith(
                              fontSize: 24.sp, color: textDark1),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: buildEmailFormField(state),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: buildPasswordFormField(state),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          buildBottomSheetForgotPassword();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 31.w),
                          child: Text(
                            "Lupa Password?",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: primary1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 44.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: ButtonWidget(
                          label: "Masuk",
                          textStyle: buttonTextNoneStyle,
                          onTap: () async {
                            if (!_formKeySignIn.currentState.validate()) {}
                            _formKeySignIn.currentState.save();
                            onLoading("login");
                          },
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      buildButtonTidakPunyaAkun(),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Center buildButtonTidakPunyaAkun() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Saya belum mempunyai akun?",
            style: ralewayTextStyle.copyWith(fontSize: 14.sp, color: textDark2),
          ),
          GestureDetector(
            onTap: () => buildBottomSheetSignUp1(),
            child: Text(
              " Daftar",
              style:
                  ralewayTextStyle.copyWith(fontSize: 14.sp, color: primary1),
            ),
          )
        ],
      ),
    );
  }

  RoundedRectangleBorder buildRoundedRectangleBorder() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)));
  }

  void buildBottomSheetSignUp1() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: buildRoundedRectangleBorder(),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: heightSignUp,
              child: Form(
                key: _formKeySignUp1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: buildPaddingViewInsetsBottomSignUp(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 28.h, 28.w, 0),
                          child: buildHeaderSignUpStep("1"),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        buildDaftarText(),
                        SizedBox(
                          height: 32.h,
                        ),
                        buildNameFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildNikFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildIdSertifikatFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildPhoneNumberFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        getKtp(state),
                        SizedBox(
                          height: 44.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildSudahPunyaAkun(),
                            buildButtonNextSignUp1(state),
                          ],
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  ButtonIconWidget buildButtonNextSignUp1(StateSetter state) {
    return ButtonIconWidget(
      label: Text("Next", style: buttonTextNoneStyle.copyWith(color: bgLight2)),
      iconRight: widgetSignUp1,
      onTap: () {
        updateWidgetSignUp1(isLoading: true, updateState: state);
        Timer(Duration(seconds: 2), () {
          updateWidgetSignUp1(isLoading: false, updateState: state);
          if (_formKeySignUp1.currentState.validate()) {
            if (ktp == null) {
              snackbarWidget(messageText: ktpEmpty, titleText: "KTP Kosong");
            } else {
              _formKeySignUp1.currentState.save();
              buildBottomSheetSignUp2();
            }
          }
        });
      },
    );
  }

  Center buildDaftarText() {
    return Center(
      child: Text(
        "Daftar",
        style: header1Style.copyWith(fontSize: 24.sp, color: textDark1),
      ),
    );
  }

  Row buildHeaderSignUpStep(String step) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconButtonClose(),
        RichText(
            text: TextSpan(
                text: "Step ",
                style: ralewayTextStyle.copyWith(
                    fontSize: 14.sp, color: textDark2),
                children: <TextSpan>[
              TextSpan(
                  text: "$step/3",
                  style: ralewayTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: primary1,
                      fontWeight: FontWeight.bold))
            ]))
      ],
    );
  }

  IconButton buildIconButtonClose() {
    return IconButton(
        icon: Icon(UniconsLine.multiply), onPressed: () => Get.back());
  }

  void buildBottomSheetSignUp2() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: buildRoundedRectangleBorder(),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: heightSignUp,
              child: Form(
                key: _formKeySignUp2,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: buildPaddingViewInsetsBottomSignUp(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 28.h, 28.w, 0),
                          child: buildHeaderSignUpStep("2"),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        buildDaftarText(),
                        SizedBox(
                          height: 32.h,
                        ),
                        buildDropdownProvinsi(context, state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildDropdownCity(context, state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildDropdownDistrict(context, state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildDropdownSubdistrict(context, state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildContainerTextField(location.postCode),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildContainerTextField(location.address),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildSudahPunyaAkun(),
                            buildButtonNextSignUp2(state),
                          ],
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  ButtonIconWidget buildButtonNextSignUp2(StateSetter state) {
    return ButtonIconWidget(
      label: Text("Next", style: buttonTextNoneStyle.copyWith(color: bgLight2)),
      iconRight: widgetSignUp2,
      onTap: () {
        updateWidgetSignUp2(isLoading: true, updateState: state);
        Timer(Duration(seconds: 2), () {
          updateWidgetSignUp2(isLoading: false, updateState: state);
          if (_formKeySignUp2.currentState.validate()) {
            _formKeySignUp2.currentState.save();

            buildBottomSheetSignUp3();
          }
        });
      },
    );
  }

  Container buildContainerTextField(String label) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(color: textDark3)),
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(label,
                style: ralewayTextStyle.copyWith(
                    color: textDark1, fontSize: 16.sp))));
  }

  Container buildDropdownSubdistrict(BuildContext context, StateSetter state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: buildBoxDecorationDropdown(),
      child: DropdownButton(
        isExpanded: true,
        value: kecamatan,
        underline: SizedBox(),
        icon: buildIconDropdown(),
        items: (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
            .subdistricts
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.subdistrict,
                    style: ralewayTextStyle.copyWith(
                        color: textDark1, fontSize: 16.sp),
                  )),
            )
            .toList(),
        onChanged: (item) {
          updateKecamatan(state, item);
        },
        selectedItemBuilder: (val) {
          return (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
              .subdistricts
              .map((e) {
            return Container(
              padding: EdgeInsets.only(left: 15.w),
              alignment: Alignment.centerLeft,
              child: Text(e.subdistrict,
                  style: ralewayTextStyle.copyWith(
                      color: textDark1, fontSize: 16.sp)),
            );
          }).toList();
        },
      ),
    );
  }

  BoxDecoration buildBoxDecorationDropdown() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: textDark3));
  }

  Icon buildIconDropdown() {
    return Icon(
      UniconsLine.direction,
      color: textDark3,
    );
  }

  Container buildDropdownDistrict(BuildContext context, StateSetter state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: buildBoxDecorationDropdown(),
      child: DropdownButton(
        isExpanded: true,
        value: kabupaten,
        underline: SizedBox(),
        icon: buildIconDropdown(),
        items: (context.read<DistrictCubit>().state as DistrictLoaded)
            .districts
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.district,
                    style: ralewayTextStyle.copyWith(
                        color: textDark1, fontSize: 16.sp),
                  )),
            )
            .toList(),
        onChanged: (item) {
          updateKabupaten(state, item);
        },
        selectedItemBuilder: (val) {
          return (context.read<DistrictCubit>().state as DistrictLoaded)
              .districts
              .map((e) {
            return Container(
              padding: EdgeInsets.only(left: 15.w),
              alignment: Alignment.centerLeft,
              child: Text(e.district,
                  style: ralewayTextStyle.copyWith(
                      color: textDark1, fontSize: 16.sp)),
            );
          }).toList();
        },
      ),
    );
  }

  Container buildDropdownCity(BuildContext context, StateSetter state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: buildBoxDecorationDropdown(),
      child: DropdownButton(
        isExpanded: true,
        value: kota,
        underline: SizedBox(),
        icon: buildIconDropdown(),
        items: (context.read<CityCubit>().state as CityLoaded)
            .citys
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.cityName,
                    style: ralewayTextStyle.copyWith(
                        color: textDark1, fontSize: 16.sp),
                  )),
            )
            .toList(),
        onChanged: (item) {
          updateKota(state, item);
        },
        selectedItemBuilder: (val) {
          return (context.read<CityCubit>().state as CityLoaded).citys.map((e) {
            return Container(
              padding: EdgeInsets.only(left: 15.w),
              alignment: Alignment.centerLeft,
              child: Text(e.cityName,
                  style: ralewayTextStyle.copyWith(
                      color: textDark1, fontSize: 16.sp)),
            );
          }).toList();
        },
      ),
    );
  }

  Container buildDropdownProvinsi(BuildContext context, StateSetter state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: buildBoxDecorationDropdown(),
      child: DropdownButton(
        isExpanded: true,
        value: provinsi,
        underline: SizedBox(),
        icon: buildIconDropdown(),
        items: (context.read<ProvinceCubit>().state as ProvinceLoaded)
            .provinces
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                    style: ralewayTextStyle.copyWith(
                        color: textDark1, fontSize: 16.sp),
                  )),
            )
            .toList(),
        onChanged: (item) {
          updateProvinsi(state, item);
        },
        selectedItemBuilder: (val) {
          return (context.read<ProvinceCubit>().state as ProvinceLoaded)
              .provinces
              .map((e) {
            return Container(
              padding: EdgeInsets.only(left: 15.w),
              alignment: Alignment.centerLeft,
              child: Text(e.name,
                  style: ralewayTextStyle.copyWith(
                      color: textDark1, fontSize: 16.sp)),
            );
          }).toList();
        },
      ),
    );
  }

  EdgeInsets buildPaddingViewInsetsBottomSignUp(BuildContext context) {
    return EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: defaultMargin,
        right: defaultMargin);
  }

  void buildBottomSheetSignUp3() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: buildRoundedRectangleBorder(),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: heightSignUp,
              child: Form(
                key: _formKeySignUp3,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: buildPaddingViewInsetsBottomSignUp(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 28.h, 28.w, 0),
                          child: buildHeaderSignUpStep("3"),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        buildDaftarText(),
                        SizedBox(
                          height: 32.h,
                        ),
                        buildUsernameFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildEmailFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildPasswordFormField(state),
                        SizedBox(
                          height: 16.h,
                        ),
                        buildConfirmPasswordFormField(state),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildSudahPunyaAkun(),
                            buildButtonNextSignUp3(state),
                          ],
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  ButtonIconWidget buildButtonNextSignUp3(StateSetter state) {
    return ButtonIconWidget(
      label: Text("Next", style: buttonTextNoneStyle.copyWith(color: bgLight2)),
      iconRight: widgetSignUp3,
      onTap: () {
        // updateWidgetSignUp3(isLoading: true, updateState: state);
        // Timer(Duration(seconds: 2), () {
        // updateWidgetSignUp3(isLoading: false, updateState: state);
        if (_formKeySignUp3.currentState.validate()) {
          _formKeySignUp3.currentState.save();

          onLoading("register");
        }
        // });
      },
    );
  }

  Column buildSudahPunyaAkun() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sudah punya akun?",
          style: ralewayTextStyle.copyWith(fontSize: 14.sp, color: textDark2),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Masuk",
            style: ralewayTextStyle.copyWith(fontSize: 14.sp, color: primary1),
          ),
        )
      ],
    );
  }

  void buildBottomSheetForgotPassword() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: buildRoundedRectangleBorder(),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, state) {
            return Form(
              key: _formKeyForgotPassword,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 28.h, left: 28.w),
                        child: buildIconButtonClose(),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Center(
                        child: Text(
                          "Lupa Password",
                          style: header1Style.copyWith(
                              fontSize: 24.sp,
                              color: textDark1,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: buildEmailFormField(state),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: ButtonWidget(
                          label: "Lupa Password",
                          textStyle: buttonTextNoneStyle,
                          onTap: () {
                            if (_formKeyForgotPassword.currentState
                                .validate()) {
                              _formKeyForgotPassword.currentState.save();
                              Navigator.pop(context);
                              buildBottomSheetChangePassword();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void buildBottomSheetChangePassword() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: buildRoundedRectangleBorder(),
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, state) {
            return Form(
              key: _formKeyChangePassword,
              child: SingleChildScrollView(
                child: Padding(
                  padding: buildPaddingViewInsetsBottomSignUp(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 28.h, left: 12.w),
                        child: buildIconButtonClose(),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Center(
                        child: Text(
                          "Password Baru",
                          style: header1Style.copyWith(
                              fontSize: 24.sp,
                              color: textDark1,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      buildPasswordFormField(state),
                      SizedBox(
                        height: 16.h,
                      ),
                      buildConfirmPasswordFormField(state),
                      SizedBox(
                        height: 32.h,
                      ),
                      ButtonWidget(
                        label: "Password baru",
                        textStyle: buttonTextNoneStyle,
                        onTap: () {
                          if (_formKeyChangePassword.currentState.validate()) {
                            _formKeyChangePassword.currentState.save();
                            Navigator.pop(context);
                            awesomeDialog(
                              title: 'Ganti Password Berhasil',
                              body:
                                  "Password baru telah diperbaharui,\nsilahkan login menggunakan password baru anda saat ini.",
                              onPress: () {
                                // Get.back();
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void onLoading(String target) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return customLoadingIndicator;
      },
    );
    if (target == "login") {
      await context.read<UserCubit>().login(email, password);

      UserState state = context.read<UserCubit>().state;

      if (state is UserLoaded) {
        Navigator.pop(context);
        setUserId(state.user.id);
        cekLogin();
      } else {
        Navigator.pop(context);
        snackbarWidget(
            messageText: (state as UserLoadingFailed).message,
            titleText: "Gagal Masuk");
      }
    } else if (target == "register") {
      await context.read<UserCubit>().register(
          name: name,
          nik: nik,
          idCertificate: idSertifikat,
          email: email,
          phone: phoneNumber,
          location: location.id.toString(),
          address: location.address,
          ktpUrl: ktp,
          username: username,
          password: password);

      UserState state = context.read<UserCubit>().state;

      if (state is UserLoaded) {
        Get.back();
        awesomeDialog(
          title: 'Pendaftaran Berhasil',
          body:
              "Admin akan mengecek kesesuaian \ndata yang kamu input dengan data yang ada di pusat TSI",
          onPress: () {
            // Get.back();
          },
        );
      } else {
        Get.back();
        snackbarWidget(
            messageText: (state as UserLoadingFailed).message,
            titleText: "Gagal Membuat akun");
      }
    }
  }

  AwesomeDialog awesomeDialog({String title, String body, Function onPress}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: "",
      btnOkOnPress: () => onPress(),
      btnOkIcon: UniconsLine.signin,
      btnOkText: "Login",
      btnOkColor: secondary2,
      headerAnimationLoop: false,
      buttonsTextStyle:
          ralewayTextStyle.copyWith(color: bgLight2, fontSize: 16.sp),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Text(title ?? "",
                textAlign: TextAlign.center,
                style: playfairDisplayTextStyle.copyWith(
                    color: primary1,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp)),
            SizedBox(height: 24.h),
            Text(body ?? "",
                textAlign: TextAlign.center,
                style: ralewayTextStyle.copyWith(
                    color: textDark2, fontSize: 14.sp))
          ],
        ),
      ),
      desc: "",
    )..show();
  }

  Future<Null> passwordVisibility(StateSetter updateState) async {
    updateState(() {
      hidePassword = !hidePassword;
    });
  }

  Future<Null> updateWidgetSignUp1(
      {StateSetter updateState, bool isLoading}) async {
    updateState(() {
      if (isLoading) {
        widgetSignUp1 = SpinKitCircle(
          size: 30,
          color: textLight2,
        );
      } else {
        widgetSignUp1 = iconNextWidget();
      }
    });
  }

  Future<Null> updateWidgetSignUp2(
      {StateSetter updateState, bool isLoading}) async {
    updateState(() {
      if (isLoading) {
        widgetSignUp2 = SpinKitCircle(
          size: 30,
          color: textLight2,
        );
      } else {
        widgetSignUp2 = iconNextWidget();
      }
    });
  }

  Future<Null> updateWidgetSignUp3(
      {StateSetter updateState, bool isLoading}) async {
    updateState(() {
      if (isLoading) {
        widgetSignUp3 = SpinKitCircle(
          size: 30,
          color: textLight2,
        );
      } else {
        widgetSignUp3 = iconNextWidget();
      }
    });
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

    await context.read<DistrictCubit>().getDistrict(kota.id);
    updateState(() {
      kabupaten =
          (context.read<DistrictCubit>().state as DistrictLoaded).districts[0];
    });

    await context.read<SubdistrictCubit>().getSubdistrict(kabupaten.id);
    updateState(() {
      kecamatan = (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
          .subdistricts[0];
    });

    await context.read<LocationCubit>().getLocation(kecamatan.id);
    updateState(() {
      location =
          (context.read<LocationCubit>().state as LocationLoaded).location;
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
    updateState(() {
      kabupaten =
          (context.read<DistrictCubit>().state as DistrictLoaded).districts[0];
    });

    await context.read<SubdistrictCubit>().getSubdistrict(kabupaten.id);
    updateState(() {
      kecamatan = (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
          .subdistricts[0];
    });

    await context.read<LocationCubit>().getLocation(kecamatan.id);
    updateState(() {
      location =
          (context.read<LocationCubit>().state as LocationLoaded).location;
    });

    Get.back();
  }

  Future<Null> updateKabupaten(
      StateSetter updateState, LocationModel newKabupaten) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return customLoadingIndicator;
      },
    );
    updateState(() {
      kabupaten = newKabupaten;
    });

    await context.read<SubdistrictCubit>().getSubdistrict(kabupaten.id);
    updateState(() {
      kecamatan = (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
          .subdistricts[0];
    });

    await context.read<LocationCubit>().getLocation(kecamatan.id);
    updateState(() {
      location =
          (context.read<LocationCubit>().state as LocationLoaded).location;
    });

    Get.back();
  }

  Future<Null> updateKecamatan(
      StateSetter updateState, LocationModel newKecamatan) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return customLoadingIndicator;
      },
    );
    updateState(() {
      kecamatan = newKecamatan;
    });

    await context.read<LocationCubit>().getLocation(kecamatan.id);
    updateState(() {
      location =
          (context.read<LocationCubit>().state as LocationLoaded).location;
    });

    print(location.id);

    Get.back();
  }

  Future<Null> updateWidgetGetKtp(
      StateSetter updateState, String newKtp) async {
    updateState(() {
      ktp = newKtp;
    });
  }

  TextFormField buildUsernameFormField(StateSetter updateState) {
    return TextFormField(
        onSaved: (newValue) {
          return updateUsernameFormField(updateState, newValue);
        },
        onChanged: (value) {
          if (value.isEmpty) {
            return "";
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            return usernameEmpty;
          }
          updateUsernameFormField(updateState, value);
          return null;
        },
        decoration: InputDecoration(
          hintText: "Input Username",
          labelText: "Input Username",
        ));
  }

  TextFormField buildPasswordFormField(StateSetter updateState) {
    return TextFormField(
      obscureText: hidePassword,
      onSaved: (newValue) {
        updatePasswordFormField(updateState, newValue);
      },
      onChanged: (value) {
        if (value.isEmpty) {
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return passwordEmpty;
        }
        updatePasswordFormField(updateState, value);
        return null;
      },
      decoration: InputDecoration(
          hintText: "Input Password",
          labelText: "Input Password",
          suffixIcon: IconButton(
              icon: Icon(
                hidePassword ? UniconsLine.eye_slash : UniconsLine.eye,
                color: textDark3,
              ),
              onPressed: () {
                passwordVisibility(updateState);
              })),
    );
  }

  TextFormField buildConfirmPasswordFormField(StateSetter updateState) {
    return TextFormField(
      obscureText: hidePassword,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (password != value) {
          return "";
        }
        return null;
      },
      validator: (value) {
        print(password);
        if (password != value) {
          return passwordConfirmEmpty;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Input Password",
          labelText: "Input Password",
          suffixIcon: IconButton(
              icon: Icon(
                hidePassword ? UniconsLine.eye_slash : UniconsLine.eye,
                color: textDark3,
              ),
              onPressed: () {
                passwordVisibility(updateState);
              })),
    );
  }

  TextFormField buildEmailFormField(StateSetter updateState) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        updateEmailFormField(updateState, newValue);
      },
      onChanged: (value) {
        if (value.isEmpty) {
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return emailEmpty;
        }

        updateEmailFormField(updateState, value);
        return null;
      },
      decoration: InputDecoration(
        hintText: "Input Email",
        labelText: "Input Email",
      ),
    );
  }

  TextFormField buildNameFormField(StateSetter updateState) {
    return TextFormField(
      onSaved: (newValue) {
        updateNameFormField(updateState, newValue);
      },
      onChanged: (value) {
        if (value.isEmpty) {
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return nameEmpty;
        }

        updateNameFormField(updateState, value);
        return null;
      },
      decoration: InputDecoration(
        hintText: "Name",
        labelText: "Input your name",
      ),
    );
  }

  TextFormField buildNikFormField(StateSetter updateState) {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        updateNikFormField(updateState, newValue);
      },
      onChanged: (value) {
        if (value.isEmpty) {
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return nikEmpty;
        }

        updateNikFormField(updateState, value);
        return null;
      },
      decoration: InputDecoration(
        hintText: "NIK",
        labelText: "Input nik",
      ),
    );
  }

  TextFormField buildIdSertifikatFormField(StateSetter updateState) {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        updateIdSertifikatFormField(updateState, newValue);
      },
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        updateIdSertifikatFormField(updateState, value);
        return null;
      },
      decoration: InputDecoration(
        hintText: "ID Sertifikat",
        labelText: "Input ID Sertifikat",
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(StateSetter updateState) {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        updatePhoneNumberFormField(updateState, newValue);
      },
      onChanged: (value) {
        if (value.isEmpty) {
          return "";
        }

        updatePhoneNumberFormField(updateState, value);
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return phoneNumberEmpty;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "No. Telephone",
        labelText: "Input No. Telephone",
      ),
    );
  }

  Future<Null> updateNameFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      name = newValue;
    });
  }

  Future<Null> updateNikFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      nik = newValue;
    });
  }

  Future<Null> updateIdSertifikatFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      idSertifikat = newValue;
    });
  }

  Future<Null> updatePhoneNumberFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      phoneNumber = newValue;
    });
  }

  Future<Null> updateUsernameFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      username = newValue;
    });

    print(username);
  }

  Future<Null> updateEmailFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      email = newValue;
    });
  }

  Future<Null> updatePasswordFormField(
      StateSetter updateState, String newValue) async {
    updateState(() {
      password = newValue;
    });
  }

  GestureDetector getKtp(StateSetter updateState) {
    return GestureDetector(
      onTap: () {
        pickKtp(updateState);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: textDark3,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                ktp != null ? ktp.split('/').last : "Upload KTP",
                overflow: TextOverflow.clip,
                style: ralewayTextStyle.copyWith(
                    color: textDark1, fontSize: 16.sp),
              ),
            ),
            Icon(
              UniconsLine.paperclip,
              color: textDark3,
            )
          ],
        ),
      ),
    );
  }

  pickKtp(StateSetter updateState) async {
    String result;
    try {
      // setState(() {
      //   filePath = '-';
      //   _pickFileInProgress = true;
      // });

      // FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      //   allowedFileExtensions: _checkByCustomExtension
      //       ? _extensionController.text
      //           .split(' ')
      //           .where((x) => x.isNotEmpty)
      //           .toList()
      //       : null,
      //   allowedUtiTypes: _iosPublicDataUTI
      //       ? null
      //       : _utiController.text
      //           .split(' ')
      //           .where((x) => x.isNotEmpty)
      //           .toList(),
      //   allowedMimeTypes: _checkByMimeType
      //       ? _mimeTypeController.text
      //           .split(' ')
      //           .where((x) => x.isNotEmpty)
      //           .toList()
      //       : null,
      // );

      result = await FlutterDocumentPicker.openDocument();
    } catch (e) {
      print(e);
      result = 'Error: $e';
    } finally {
      // setState(() {
      //   _pickFileInProgress = false;
      // });
    }

    if (result != null) {
      updateWidgetGetKtp(updateState, result);
    }
  }

  setUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('UserId', userId);
  }
}
