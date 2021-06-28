import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/add_pasien/add_pasien_cubit.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/pages/pasien/form/data_pasien.dart';
import 'package:tsi_mobile/pages/pasien/form/diagnose.dart';
import 'package:tsi_mobile/pages/pasien/form/result.dart';
import 'package:tsi_mobile/pages/pasien/form/story_pasien.dart';
import 'package:tsi_mobile/pages/pasien/form/visualisasi.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasienFormScreen extends StatefulWidget {
  @override
  _PasienFormScreenState createState() => _PasienFormScreenState();
}

class _PasienFormScreenState extends State<PasienFormScreen> {
  final AddPasienCubit addPasienCubit = AddPasienCubit();

  final ScrollController controller = ScrollController();

  double pixels = 0;

  int currentIndex = 0;

  //form
  String type;
  String user;
  String schedule;
  Map<String, dynamic> personal;
  Map<String, dynamic> address;
  String penyakit;
  String keluhan;
  Map<String, dynamic> visual;
  Map<String, dynamic> pubis;
  Map<String, dynamic> anomali;
  Map<String, dynamic> detail;
  Map<String, dynamic> release;
  Map<String, dynamic> story;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });
    user = ((context.read<UserCubit>().state as UserLoaded)).user.id.toString();
    super.initState();
  }

  void next() {
    if (currentIndex < 4) {
      setState(() {
        currentIndex = currentIndex + 1;
      });
    } else {
      dio.FormData _pasien = dio.FormData();


       _pasien = dio.FormData.fromMap({
         "type": penyakit != null ? 1 : 0,
         "user": user,
         "schedule": schedule,
         "personal": jsonEncode(personal),
         "address": jsonEncode(address),
         "penyakit": penyakit,
         "keluhan": keluhan,
         "visual": jsonEncode(visual),
         "pubis": jsonEncode(pubis),
         "anomali": jsonEncode(anomali),
         "detail": jsonEncode(detail),
         "release": jsonEncode(release),
       });

      dio.FormData formData = dio.FormData();

      formData = dio.FormData.fromMap(story);

      addPasienCubit.addPasien(story: formData, pasien: _pasien);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        cubit: addPasienCubit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: AnimatedAppbarWidget(
                firstTitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Tambah Pasien",
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
                pixels: pixels,
                secondSuffix: Container(),
                firstSuffix: Container(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Tambah Pasien",
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
            Expanded(
              child: Stepper(
                controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
                    Container(),
                type: StepperType.horizontal,
                currentStep: currentIndex,
                onStepCancel: () {
                  if (currentIndex > 0) {
                    setState(() {
                      currentIndex -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (currentIndex <= 0) {
                    setState(() {
                      currentIndex += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                steps: [
                  Step(
                    title: Text(""),
                    isActive: currentIndex == 0 ? true : false,
                    state: currentIndex == 0
                        ? StepState.editing
                        : currentIndex < 2
                            ? StepState.disabled
                            : StepState.complete,
                    content: DataPasienFragment(
                      controller: controller,
                      next: next,
                      personal: personal,
                      onPersonalChange: (value) {
                        setState(() {
                          personal = value;
                        });
                      },
                      address: address,
                      onAddressChange: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                      penyakit: penyakit,
                      onPenyakitChange: (value) {
                        setState(() {
                          penyakit = value;
                        });
                      },
                      keluhan: keluhan,
                      oKeluhanChange: (value) {
                        setState(() {
                          keluhan = value;
                        });
                      },
                      schedule: schedule,
                      onScheduleChange: (value) {
                        setState(() {
                          schedule = value;
                        });
                      },
                    ),
                  ),
                  Step(
                    title: Text(""),
                    isActive: currentIndex == 1 ? true : false,
                    state: currentIndex == 1
                        ? StepState.editing
                        : currentIndex < 1
                            ? StepState.disabled
                            : StepState.complete,
                    content: DiagnosePasienFragment(
                      controller: controller,
                      next: next,
                      anomali: anomali,
                      onAnomali: (value) {
                        setState(() {
                          anomali = value;
                        });
                      },
                      pubis: pubis,
                      onPubis: (value) {
                        setState(() {
                          pubis = value;
                        });
                      },
                      visual: visual,
                      onVisual: (value) {
                        setState(() {
                          visual = value;
                        });
                      },
                    ),
                  ),
                  Step(
                    title: Text(""),
                    isActive: currentIndex == 2 ? true : false,
                    state: currentIndex == 2
                        ? StepState.editing
                        : currentIndex < 3
                            ? StepState.disabled
                            : StepState.complete,
                    content: VisualisasiPasienFragment(
                      controller: controller,
                      next: next,
                      detail: detail,
                      onDetail: (value) {
                        setState(() {
                          detail = value;
                        });
                      },
                    ),
                  ),
                  Step(
                    title: Text(""),
                    isActive: currentIndex == 3 ? true : false,
                    state: currentIndex == 3
                        ? StepState.editing
                        : currentIndex < 4
                            ? StepState.disabled
                            : StepState.complete,
                    content: ResultPasienFragment(
                      controller: controller,
                      next: next,
                      release: release,
                      onRelease: (value) {
                        setState(() {
                          release = value;
                        });
                      },
                    ),
                  ),
                  Step(
                    title: Text(""),
                    isActive: currentIndex == 4 ? true : false,
                    state: currentIndex == 4
                        ? StepState.editing
                        : currentIndex < 5
                            ? StepState.disabled
                            : StepState.complete,
                    content: StoryPasienFragment(
                      controller: controller,
                      next: next,
                      story: story,
                      onStory: (value) {
                        setState(() {
                          story = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        listener: (context, state) {
          if (state is AddPasienLoaded) {
            Get.back();
          }

          if (state is AddPasienLoadingFailed) {
            print("state.message ${state.message}");
          }
        },
      ),
    );
  }
}
