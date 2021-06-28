import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';

class DiagnosePasienFragment extends StatefulWidget {
  final ScrollController controller;
  final GestureTapCallback next;

  final ValueChanged onVisual;
  final Map<String, dynamic> visual;

  final ValueChanged onPubis;
  final Map<String, dynamic> pubis;

  final ValueChanged onAnomali;
  final Map<String, dynamic> anomali;

  const DiagnosePasienFragment(
      {Key key,
      this.controller,
      this.next,
      this.visual,
      this.onVisual,
      this.onPubis,
      this.pubis,
      this.onAnomali,
      this.anomali})
      : super(key: key);

  @override
  _DiagnosePasienFragmentState createState() => _DiagnosePasienFragmentState();
}

class _DiagnosePasienFragmentState extends State<DiagnosePasienFragment> {
  //Cisual
  String varianKaki;
  String kakiKanan;
  String kakiKiri;

  String varianPundak;
  String pundakKanan;
  String pundakKiri;

  //anomati
  String thorax;
  String lumbar;

  //pubis1
  final pubis1KakiKananDepanSize = TextEditingController(text: "0");
  final pubis1KakiKananSampingSize = TextEditingController(text: "0");
  final pubis1KakiKananAtasSize = TextEditingController(text: "0");
  final pubis1KakiKananBawahSize = TextEditingController(text: "0");

  final pubis1KakiKiriDepanSize = TextEditingController(text: "0");

  final pubis1KakiKiriSampingSize = TextEditingController(text: "0");

  final pubis1KakiKiriAtasSize = TextEditingController(text: "0");

  final pubis1KakiKiriBawahSize = TextEditingController(text: "0");

  //pubis2
  String pubis2KakiKananDepanSamping;
  final pubis2KakiKananDepanSampingSize = TextEditingController(text: "0");
  String pubis2KakiKiriKanan;
  final pubis2KakiKiriKananSize = TextEditingController(text: "0");

  String pubis2KakiKananAtasBawah;
  final pubis2KakiKananAtasBawahSize = TextEditingController(text: "0");
  String pubis2KakiKiriKananBawah;
  final pubis2KakiKiriKananBawahSize = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Diagnosa",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "Visual",
            style: ralewayTextStyle.copyWith(
                color: textDark2, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: grey,
              ),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Visual",
                  style: ralewayTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: grey,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: DropdownButton(
                    value: varianKaki,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Varian Bungkuk",
                          style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                        ),
                        value: "bungkuk",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "Ndegeg",
                          style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                        ),
                        value: "ndegeg",
                      ),
                    ],
                    underline: Container(),
                    isExpanded: false,
                    onChanged: (value) {
                      setState(() {
                        varianKaki = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kaki Kanan",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: kakiKanan,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Mendekat",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "mendekat",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Menjauh",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "lebih_jauh",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: false,
                              onChanged: (value) {
                                setState(() {
                                  kakiKanan = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kaki Kiri",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: kakiKiri,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Mendekat",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "mendekat",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Menjauh",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "lebih_jauh",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: false,
                              onChanged: (value) {
                                setState(() {
                                  kakiKiri = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Text(
                  "Varian Pundak",
                  style: ralewayTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: grey,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: DropdownButton(
                    value: varianPundak,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Varian Lurus",
                          style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                        ),
                        value: "lurus",
                      ),
                    ],
                    underline: Container(),
                    isExpanded: false,
                    onChanged: (value) {
                      setState(() {
                        varianPundak = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pundak Kanan",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: pundakKanan,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Tinggi",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "tinggi",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Rendah",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "rendah",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: false,
                              onChanged: (value) {
                                setState(() {
                                  pundakKanan = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pundak Kiri",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: pundakKiri,
                              onChanged: (value) {
                                setState(() {
                                  pundakKiri  = value;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Tinggi",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "tinggi",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Rendah",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "rendah",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "Pubis",
            style: ralewayTextStyle.copyWith(
                color: textDark2, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: grey,
              ),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pubis 1",
                  style: ralewayTextStyle.copyWith(
                      color: textDark2,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "Kaki Kanan",
                  style: ralewayTextStyle.copyWith(fontSize: 12.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            padding: EdgeInsets.all(10.sp),
                            child: Text(
                              "Depan",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                              controller: pubis1KakiKananDepanSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            padding: EdgeInsets.all(10.sp),
                            child: Text(
                              "Samping",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                              textAlign: TextAlign.center,
                              controller: pubis1KakiKananSampingSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            padding: EdgeInsets.all(10.sp),
                            child: Text(
                              "Atas",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                              textAlign: TextAlign.center,
                              controller: pubis1KakiKananAtasSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            padding: EdgeInsets.all(10.sp),
                            child: Text(
                              "Bawah",
                              style: ralewayTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                              textAlign: TextAlign.center,
                              controller: pubis1KakiKananBawahSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Text(
                  "Pubis 2",
                  style: ralewayTextStyle.copyWith(
                      color: textDark2,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Depan atau Samping",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  child: DropdownButton(
                                    value: pubis2KakiKananDepanSamping,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          "Depan",
                                          style: ralewayTextStyle.copyWith(
                                              fontSize: 12.sp),
                                        ),
                                        value: "depan",
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "Samping",
                                          style: ralewayTextStyle.copyWith(
                                              fontSize: 12.sp),
                                        ),
                                        value: "samping",
                                      ),
                                    ],
                                    underline: Container(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        pubis2KakiKananDepanSamping = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: pubis2KakiKananDepanSampingSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kiri/Kanan",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: pubis2KakiKiriKanan,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Kiri",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "kiri",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Kanan",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "Kanan",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  pubis2KakiKiriKanan = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Atas atau Bawah",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  child: DropdownButton(
                                    value: pubis2KakiKananAtasBawah,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          "Atas",
                                          style: ralewayTextStyle.copyWith(
                                              fontSize: 12.sp),
                                        ),
                                        value: "atas",
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "Bawah",
                                          style: ralewayTextStyle.copyWith(
                                              fontSize: 12.sp),
                                        ),
                                        value: "bawah",
                                      ),
                                    ],
                                    underline: Container(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        pubis2KakiKananAtasBawah = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: pubis2KakiKananAtasBawahSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kiri/Kanan",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: pubis2KakiKiriKananBawah,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Kiri",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "kiri",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Kanan",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "Kanan",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  pubis2KakiKiriKananBawah = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "Anomali",
            style: ralewayTextStyle.copyWith(
                color: textDark2, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: grey,
              ),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thorax",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: thorax,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Ada Patahan",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "ada",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Tidak Ada Patahan",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "tidak-ada",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  thorax = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lumbar",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey,
                              ),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton(
                              value: lumbar,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Masuk",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "masuk",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "Keluar",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                  value: "keluar",
                                ),
                              ],
                              underline: Container(),
                              isExpanded: false,
                              onChanged: (value) {
                                setState(() {
                                  lumbar = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          ButtonWidget(
            label: "Lanjutkan",
            textStyle: buttonTextNoneStyle,
            onTap: () async {
              widget.onVisual({
                "kaki": {
                  "variant": varianKaki,
                  "kanan": kakiKanan,
                  "kiri": kakiKiri
                },
                "pundak": {
                  "variant": varianPundak,
                  "kanan": pundakKanan,
                  "kiri": pundakKiri,
                }
              });
              widget.onAnomali({"thorax": thorax, "lumbar": lumbar});
              widget.onPubis({
                "data1": {
                  "kanan": {
                    "depan": pubis1KakiKananDepanSize.text,
                    "samping": pubis1KakiKananSampingSize.text,
                    "hasil_depan_samping": "menutup",
                    "atas": pubis1KakiKananAtasSize.text,
                    "bawah": pubis1KakiKananBawahSize.text,
                    "hasil_atas_bawah": "kedepan"
                  },
                  "kiri": {
                    "depan": pubis1KakiKiriDepanSize.text,
                    "samping": pubis1KakiKiriSampingSize.text,
                    "hasil_depan_samping": "menutup",
                    "atas": pubis1KakiKiriAtasSize.text,
                    "bawah": pubis1KakiKiriBawahSize.text,
                    "hasil_atas_bawah": "kedepan"
                  }
                },
                "data2": [
                  {
                    "bagian": pubis2KakiKananDepanSamping,
                    "value": pubis2KakiKananAtasBawahSize.text,
                    "sebelah": pubis2KakiKiriKanan
                  },
                  {
                    "bagian": pubis2KakiKananAtasBawah,
                    "value": pubis2KakiKananAtasBawahSize.text,
                    "sebelah": pubis2KakiKiriKananBawah
                  }
                ]
              });
              widget.next();
            },
          ),
        ],
      ),
    );
  }
}
