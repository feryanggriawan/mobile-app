import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/pasien/detail/pubis_first.dart';
import 'package:tsi_mobile/pages/pasien/detail/pubis_second.dart';
import 'package:tsi_mobile/pages/pasien/detail/release.dart';
import 'package:tsi_mobile/pages/pasien/detail/visual.dart';
import 'package:tsi_mobile/pages/pasien/detail/visual_solution.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasienDetailScreen extends StatefulWidget {
  final Pasien pasien;

  const PasienDetailScreen({Key key, this.pasien}) : super(key: key);

  @override
  _PasienDetailScreenState createState() => _PasienDetailScreenState();
}

class _PasienDetailScreenState extends State<PasienDetailScreen> {
  final ScrollController controller = ScrollController();

  double pixels = 0;

  int currentIndex = 0;

  @override
  void initState() {
    print(widget.pasien.toJson());
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: AnimatedAppbarWidget(
              firstTitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pasien.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),

                        Text(
                          widget.pasien?.release[currentIndex].penyakit?.map<String>((e) => e)?.toString() ?? "-",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pixels: pixels,
              secondSuffix: Container(),
              firstSuffix: Container(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pasien.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),

                        Text(
                          widget.pasien?.release[currentIndex].penyakit?.map<String>((e) => e)?.toString() ?? "-",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: playfairDisplayTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              showHideIn: 50.h,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.sp,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (currentIndex > 0) {
                            setState(() {
                              currentIndex = currentIndex - 1;
                            });
                          }
                        },
                        child: Icon(Icons.keyboard_arrow_left),
                      ),
                      Text(
                          "${currentIndex + 1} / ${widget.pasien.release.length}"),
                      GestureDetector(
                        onTap: () {
                          if (currentIndex <
                              (widget.pasien.release.length - 1)) {
                            setState(() {
                              currentIndex = currentIndex + 1;
                            });
                          }
                        },
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  VisualFragment(release: widget.pasien?.release[currentIndex] ?? Release(),),
                  PubisFirstFragment(release: widget.pasien?.release[currentIndex] ?? Release(),),
                  PubisSecondFragment(release: widget.pasien?.release[currentIndex] ?? Release(),),
                  VisualSolutionFragment(release: widget.pasien?.release[currentIndex] ?? Release(),),
                  ReleaseFragment(release: widget.pasien?.release[currentIndex] ?? Release(),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
