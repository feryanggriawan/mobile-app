import 'package:flutter/material.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisualisasiPasienFragment extends StatefulWidget {
  final ScrollController controller;
  final GestureTapCallback next;
  final ValueChanged onDetail;
  final Map<String, dynamic> detail;

  const VisualisasiPasienFragment(
      {Key key, this.controller, this.next, this.onDetail, this.detail})
      : super(key: key);

  @override
  _VisualisasiPasienFragmentState createState() =>
      _VisualisasiPasienFragmentState();
}

class _VisualisasiPasienFragmentState extends State<VisualisasiPasienFragment> {
  final penyimpanganJenis = TextEditingController(text: "");
  String penyimpanganKakiKananSatu;
  String penyimpanganKakiKananDua;
  String penyimpanganKakiKiriSatu;
  String penyimpanganKakiKiriDua;

  final penyimpanganVarian = TextEditingController(text: "");
  final penyimpanganSebelah = TextEditingController(text: "");
  final penyimpanganAnomaliKiri = TextEditingController(text: "");
  final penyimpanganAnomaliKanan = TextEditingController(text: "");

  final solusiJenis = TextEditingController(text: "");
  String solusiKakiKananSatu;
  String solusiKakiKananDua;
  String solusiKakiKiriSatu;
  String solusiKakiKiriDua;

  final solusiVarian = TextEditingController(text: "");
  final solusiAnomali = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visualisasi",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "Penyimpangan",
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
                  "Jenis",
                  style: ralewayTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                  ),
                  controller: penyimpanganJenis,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
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
                                value: penyimpanganKakiKananSatu,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih membuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-membuka",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Kebuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "kebuka",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    penyimpanganKakiKananSatu = value;
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
                              "",
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
                                value: penyimpanganKakiKananDua,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "mundur",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-mundur",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    penyimpanganKakiKananDua = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    children: [
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
                                value: penyimpanganKakiKiriSatu,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih membuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-membuka",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Kebuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "kebuka",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    penyimpanganKakiKiriSatu = value;
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
                              "",
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
                                value: penyimpanganKakiKiriDua,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "mundur",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-mundur",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    penyimpanganKakiKiriDua = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                            "Varian",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                            controller: penyimpanganVarian,
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
                            "Sebelah",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                            controller: penyimpanganSebelah,
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
                            "Anomali",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                            controller: penyimpanganAnomaliKanan,
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
                            "",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                            controller: penyimpanganAnomaliKiri,
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
            "Solusi",
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
                  "Jenis",
                  style: ralewayTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                  ),
                  controller: solusiJenis,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
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
                                value: solusiKakiKananSatu,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih membuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-membuka",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Kebuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "kebuka",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    solusiKakiKananSatu = value;
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
                              "",
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
                                value: solusiKakiKananDua,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "mundur",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-mundur",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    solusiKakiKananDua = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    children: [
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
                                value: solusiKakiKiriSatu,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih membuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-membuka",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Kebuka",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "kebuka",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    solusiKakiKiriSatu = value;
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
                              "",
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
                                value: solusiKakiKiriDua,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "mundur",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Lebih Mundur",
                                      style: ralewayTextStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                    value: "lebih-mundur",
                                  ),
                                ],
                                underline: Container(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    solusiKakiKiriDua = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                            "Varian",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                            controller: solusiVarian,
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
                            "Anomali",
                            style: ralewayTextStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                            controller: solusiAnomali,
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
              widget.onDetail({
                "kaki_kanan": {
                  "depan_samping": penyimpanganKakiKananSatu,
                  "atas_bawah": penyimpanganKakiKananDua,
                },
                "kaki_kiri": {
                  "depan_samping": penyimpanganKakiKiriSatu,
                  "atas_bawah": penyimpanganKakiKiriDua,
                }
              });
              widget.next();
            },
          ),
        ],
      ),
    );
  }
}
