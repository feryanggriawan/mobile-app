import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tsi_mobile/cubit/confirmation_payment/confirmation_payment_cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationSectionWidget extends StatefulWidget {
  final String orderId;
  final BuildContext bottomSheetContex;
  final Function callBackFunction;
  final String date;
  final String image;

  const ConfirmationSectionWidget(
      {Key key,
      this.orderId,
      this.bottomSheetContex,
      this.callBackFunction,
      this.date,
      this.image})
      : super(key: key);

  @override
  _ConfirmationSectionWidgetState createState() =>
      _ConfirmationSectionWidgetState();
}

class _ConfirmationSectionWidgetState extends State<ConfirmationSectionWidget> {
  final paymentConfirmation = ConfirmationPaymentCubit();

  String pickedFile;
  String date;

  @override
  void initState() {
    pickedFile = widget.image ?? null;
    date = widget.date ?? null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: paymentConfirmation,
      builder: (context, state) {
        if (state is ConfirmationPaymentLoading) {
          return SpinKitCircle(
            color: primary1,
          );
        }

        if (state is ConfirmationPaymentLoaded) {
          return Column(
            children: [
              Icon(
                Icons.check_circle,
                color: primary1,
                size: 100.w,
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "Konfirmasi Pembayaran Berhasil",
                style: header1Style.copyWith(fontSize: 20.sp, color: primary1),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.sp,
              ),
              Text(
                "Konfirmasi pembayaran akan ditinjau kembali oleh admin. Terima kasih",
                style: header1Style.copyWith(fontSize: 12.sp, color: textDark2),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.sp,
              ),
              GestureDetector(
                onTap: () {
                  widget.callBackFunction();
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: secondary1,
                      borderRadius: BorderRadius.circular(20.sp)),
                  padding: EdgeInsets.symmetric(
                    vertical: 15.sp,
                    horizontal: 2.sp,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lihat Konfirmasi",
                        style: ralewayTextStyle.copyWith(
                            fontSize: 12.sp, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.sp,
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Konfirmasi Pembayaran",
                    style:
                        header1Style.copyWith(fontSize: 16.sp, color: primary1),
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                GestureDetector(
                  child: Icon(UniconsLine.multiply),
                  onTap: () => Get.back(),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: grey2,
                ),
                borderRadius: BorderRadius.circular(50.sp),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      date ?? "DD/MM/YYYY",
                      style: ralewayTextStyle.copyWith(
                          color: date != null ? textDark1 : grey),
                    ),
                  ),
                  IconButton(
                      icon: Icon(UniconsLine.calendar_alt),
                      onPressed: () async {
                        if (widget.date == null) {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));
                          if (picked != null)
                            setState(() {
                              date = DateFormat("yyyy-MM-dd").format(picked);
                            });
                        }
                      })
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            if (widget.image == null)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: grey2,
                  ),
                  borderRadius: BorderRadius.circular(50.sp),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pickedFile?.split("/")?.last ?? "Upload Bukti Transfer",
                        style: ralewayTextStyle.copyWith(
                            color: pickedFile != null ? textDark1 : grey),
                      ),
                    ),
                    IconButton(
                        icon: Icon(UniconsLine.file_alt),
                        onPressed: () async {
                          final result =
                              await FlutterDocumentPicker.openDocument();
                          if (result != null)
                            setState(() {
                              pickedFile = result;
                            });
                        })
                  ],
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
              )
            else
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bukti Transfer"),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Image.network(
                      widget.image,
                      width: 120.sp,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 20.h,
            ),
            if (widget.date == null)
              GestureDetector(
                onTap: () {
                  paymentConfirmation.confirmation(
                    orderId: widget.orderId,
                    date: date,
                    file: pickedFile,
                  );

                  print(widget.orderId);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: secondary1,
                      borderRadius: BorderRadius.circular(20.sp)),
                  padding: EdgeInsets.symmetric(
                    vertical: 15.sp,
                    horizontal: 2.sp,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Konfirmasi",
                        style: ralewayTextStyle.copyWith(
                            fontSize: 12.sp, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 32.h,
            ),
          ],
        );
      },
    );
  }
}
