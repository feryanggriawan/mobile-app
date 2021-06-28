import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StoryPasienFragment extends StatefulWidget {
  final ScrollController controller;
  final GestureTapCallback next;
  final Map<String, dynamic> story;
  final ValueChanged onStory;

  const StoryPasienFragment(
      {Key key, this.controller, this.next, this.story, this.onStory})
      : super(key: key);

  @override
  _StoryPasienFragmentState createState() => _StoryPasienFragmentState();
}

class _StoryPasienFragmentState extends State<StoryPasienFragment> {
  double pixels = 0;

  dynamic imageUrl;

  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  final picker = ImagePicker();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Story",
            style: ralewayTextStyle.copyWith(
                color: primary1, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
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
          ButtonWidget(
            label: "Selesai",
            textStyle: buttonTextNoneStyle,
            onTap: () async {
              if (imageUrl == null) {
                widget.onStory({
                  "user": (context
                      .read<UserCubit>()
                      .state
                  as UserLoaded)
                      .user
                      .id
                      .toString(),
                  "title": titleTextController.text,
                  "content": contentTextController.text,
                  "image": imageUrl,
                });
              } else {
                widget.onStory({
                  "user": (context
                      .read<UserCubit>()
                      .state
                  as UserLoaded)
                      .user
                      .id
                      .toString(),
                  "title": titleTextController.text,
                  "content": contentTextController.text,
                  "image": await MultipartFile.fromFile(
                    imageUrl.path,
                    filename: 'image.png',
                  ),
                });
              }
              widget.next();
            },
          ),
        ],
      ),
    );
  }
}
