import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/diesease/disease_cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';

class DataPasienFragment extends StatefulWidget {
  final ScrollController controller;
  final GestureTapCallback next;

  final ValueChanged onPersonalChange;
  final Map<String, dynamic> personal;

  final ValueChanged onAddressChange;
  final Map<String, dynamic> address;

  final ValueChanged onPenyakitChange;
  final String penyakit;

  final ValueChanged oKeluhanChange;
  final String keluhan;

  final ValueChanged onScheduleChange;
  final String schedule;

  const DataPasienFragment(
      {Key key,
      this.controller,
      this.next,
      this.onPersonalChange,
      this.personal,
      this.onAddressChange,
      this.address,
      this.onPenyakitChange,
      this.penyakit,
      this.oKeluhanChange,
      this.keluhan,
      this.onScheduleChange,
      this.schedule})
      : super(key: key);

  @override
  _DataPasienFragmentState createState() => _DataPasienFragmentState();
}

class _DataPasienFragmentState extends State<DataPasienFragment> {
  bool isNow = true;

  TextEditingController name = TextEditingController();
  TextEditingController usia = TextEditingController();
  String jenisKelamin;
  TextEditingController phone = TextEditingController();
  String kecamatan;
  TextEditingController address = TextEditingController();

  String penyakit;
  TextEditingController keluhan = TextEditingController();

  String date;
  String hour;
  String minute;

  TextEditingController dateString = TextEditingController();
  TextEditingController timeString = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        date = DateFormat("yyyy-MM-dd").format(picked);
        dateString.text = date;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        hour = picked.hour.toString();
        minute = picked.minute.toString();
        timeString.text = hour + ":" + minute;
      });
  }

  @override
  void initState() {
    date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    hour = TimeOfDay.now().hour.toString();
    minute = TimeOfDay.now().minute.toString();
    dateString.text = date;
    timeString.text = hour + ":" + minute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pasien Baru",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: RadioListTile<bool>(
                    title: Text('Terapi Sekarang',
                        style: ralewayTextStyle.copyWith(
                            color: textDark2, fontSize: 14.sp)),
                    value: true,
                    groupValue: isNow,
                    dense: true,
                    activeColor: primary1,
                    onChanged: (bool value) {
                      setState(() {
                        isNow = value;
                        date = DateFormat("yyyy-MM-dd").format(DateTime.now());
                        hour = TimeOfDay.now().hour.toString();
                        minute = TimeOfDay.now().minute.toString();
                        dateString.text = date;
                        timeString.text = hour + ":" + minute;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: RadioListTile<bool>(
                    title: Text('Terapi Nanti',
                        style: ralewayTextStyle.copyWith(
                            color: textDark2, fontSize: 14.sp)),
                    value: false,
                    groupValue: isNow,
                    activeColor: primary1,
                    dense: true,
                    onChanged: (bool value) {
                      setState(() {
                        isNow = value;
                      });

                      buildBottomSheet(title: "Tentutkan Tanggal & Jam");
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.sp,
          ),
          Text(
            "Data Pasien",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 15.sp,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Nama',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
            ),
            controller: name,
          ),
          SizedBox(
            height: 5.sp,
          ),
          TextFormField(
            controller: usia,
            decoration: InputDecoration(
              hintText: 'Usia',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          DropdownButtonFormField(
            iconSize: 12.sp,
            isDense: true,
            isExpanded: true,

            items: [
              DropdownMenuItem(
                value: "laki-laki",
                child: Text(
                  "Laki - Laki",
                  style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                ),
              ),
              DropdownMenuItem(
                value: "perempuan",
                child: Text(
                  "Perempuan",
                  style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                ),
              ),
            ],
            onChanged: (v) {
              setState(() {
                jenisKelamin = v;
              });
            },
            decoration: InputDecoration(
              hintText: 'Jenis Kelamin',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
            ),
            // value: search,
          ),
          SizedBox(
            height: 5.sp,
          ),
          TextFormField(
            controller: phone,
            decoration: InputDecoration(
              hintText: 'No HP',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          DropdownButtonFormField(
            iconSize: 12.sp,
            isDense: true,
            isExpanded: true,
            items: (context.read<SubdistrictCubit>().state as SubdistrictLoaded)
                .subdistricts
                .map(
                  (e) => DropdownMenuItem(
                    value: e.id.toString(),
                    child: Text(
                      e.subdistrict,
                      style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() {
                kecamatan = v.toString();
              });
            },
            decoration: InputDecoration(
              hintText: 'Kecamatan',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
            ),
            // value: search,
          ),
          SizedBox(
            height: 5.sp,
          ),
          TextFormField(
            controller: address,
            maxLines: null,
            minLines: 2,
            decoration: InputDecoration(
              hintText: 'Alamat Lengkap',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.w),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "Diagnosa Penyakit",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          DropdownButtonFormField(
            iconSize: 12.sp,
            isDense: true,
            isExpanded: true,
            items: (context.read<DiseaseCubit>().state as DiseaseLoaded)
                .diseases
                .map(
                  (e) => DropdownMenuItem(
                    value: e.name,
                    child: Text(
                      e.name,
                      style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() {
                penyakit = v;
              });
            },
            decoration: InputDecoration(
              hintText: 'Penyakit...',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
            ),
            // value: search,
          ),
          SizedBox(
            height: 10.sp,
          ),
          TextFormField(
            controller: keluhan,
            maxLines: null,
            minLines: 2,
            decoration: InputDecoration(
              hintText: 'Keluhan',
              hintStyle:
                  ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.w),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          ButtonWidget(
            label: "Lanjutkan",
            textStyle: buttonTextNoneStyle,
            onTap: () async {
              widget.onPersonalChange({
                "name": name.text,
                "usia": usia.text,
                "phone": phone.text,
                "jenis_kelamin": jenisKelamin
              });
              widget
                  .onAddressChange({"location": kecamatan ?? "", "detail": address.text});
              widget.onPenyakitChange(penyakit);
              widget.oKeluhanChange(keluhan.text);
              widget.onScheduleChange(date + " " + hour + ":" + minute);
              widget.next();
            },
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
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Tanggal Terapi',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.sp, horizontal: 15.w),
                          suffixIcon: Icon(
                            UniconsLine.calender,
                          ),
                        ),
                        enabled: false,
                        controller: dateString,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Jam Terapi',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.sp, horizontal: 15.w),
                          suffixIcon: Icon(
                            UniconsLine.clock,
                          ),
                        ),
                        enabled: false,
                        controller: timeString,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ButtonWidget(
                      label: "Terapkan",
                      textStyle: buttonTextNoneStyle,
                      onTap: () async {
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
