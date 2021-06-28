import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/cubit/update_story/update_story_cubit.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:dio/dio.dart' as dio;

class EditStoryScreen extends StatefulWidget {
  final StoryModel storyModel;

  const EditStoryScreen({Key key, this.storyModel}) : super(key: key);

  @override
  _EditStoryScreenState createState() => _EditStoryScreenState();
}

class _EditStoryScreenState extends State<EditStoryScreen> {
  final ScrollController controller = ScrollController();

  double pixels = 0;

  dynamic imageUrl;

  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  final picker = ImagePicker();

  final updateStory = UpdateStoryCubit();

  bool loading = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
      });
    });

    titleTextController.text = widget.storyModel.title;
    contentTextController.text = widget.storyModel.description;
    imageUrl = widget.storyModel.cover;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        listener: (context, state) {
          if (state is UpdateStoryLoaded) {
            setState(() {
              loading = false;
            });

            Get.back();
          }

          if (state is UpdateStoryLoadingFailed) {
            setState(() {
              loading = false;
            });
            print("state.message ${state.message}");
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedAppbarWidget(
              pixels: pixels,
              title: Row(
                children: [],
              ),
              showHideIn: 50.h,
              secondPrefix: Container(),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Judul",
                        style: playfairDisplayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Judul Story',
                          hintStyle: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark3),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.w),
                        ),
                        controller: titleTextController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Gambar",
                        style: playfairDisplayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: Colors.black.withOpacity(0.1)),
                        width: double.infinity,
                        height: 160.h,
                        child: imageUrl != null
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.contain,
                              )
                            : SizedBox(),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                final pickedFile = await picker.getImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  if (pickedFile != null) {
                                    imageUrl = File(pickedFile.path);
                                  } else {
                                    print('No image selected.');
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Edit",
                                    style: ralewayTextStyle.copyWith(
                                        fontSize: 12.sp, color: primary1),
                                  ),
                                  SizedBox(
                                    width: 2.sp,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    size: 12.sp,
                                    color: primary1,
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 14.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                imageUrl = null;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Delete",
                                  style: ralewayTextStyle.copyWith(
                                      fontSize: 12.sp, color: Colors.red),
                                ),
                                SizedBox(
                                  width: 2.sp,
                                ),
                                Icon(
                                  Icons.delete_outline,
                                  size: 12.sp,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text(
                        "Konten",
                        style: playfairDisplayTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: textDark1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        padding: EdgeInsets.all(12.sp),
                        child: TextFormField(
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Konten',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: ralewayTextStyle.copyWith(
                                fontSize: 12.sp, color: textDark2),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0.w),
                          ),
                          style: ralewayTextStyle.copyWith(
                              fontSize: 12.sp, color: textDark2),
                          controller: contentTextController,
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      if (loading)
                        SpinKitCircle(
                          size: 30,
                          color: primary1,
                        )
                      else
                        ButtonIconWidget(
                          onTap: () async {
                            dio.FormData formData = dio.FormData();

                            if (imageUrl is String) {
                              formData = dio.FormData.fromMap({
                                "story": widget.storyModel.id,
                                "user": (context.read<UserCubit>().state
                                        as UserLoaded)
                                    .user
                                    .id
                                    .toString(),
                                "title": titleTextController.text,
                                "content": contentTextController.text,
                                "image": imageUrl,
                              });
                            } else {
                              formData = dio.FormData.fromMap({
                                "story": widget.storyModel.id,
                                "user": (context.read<UserCubit>().state
                                        as UserLoaded)
                                    .user
                                    .id
                                    .toString(),
                                "title": titleTextController.text,
                                "content": contentTextController.text,
                                "image": await dio.MultipartFile.fromFile(
                                  imageUrl.path,
                                  filename: 'image.png',
                                ),
                              });
                            }

                            setState(() {
                              loading = true;
                            });
                            updateStory.updateStory(body: formData);
                          },
                          label: Text(
                            "Update Story",
                            style: ralewayTextStyle.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        cubit: updateStory,
      ),
    );
  }
}
