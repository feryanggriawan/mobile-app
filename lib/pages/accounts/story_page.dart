import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/pages/accounts/edit_story.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TerapisMemberStoryPage extends StatefulWidget {
  final String id;
  final Terapis terapis;

  const TerapisMemberStoryPage({Key key, this.id, this.terapis})
      : super(key: key);

  @override
  _TerapisMemberStoryPageState createState() => _TerapisMemberStoryPageState();
}

class _TerapisMemberStoryPageState extends State<TerapisMemberStoryPage> {
  final storyCubit = StoryCubit();
  final searchTextController = TextEditingController();

  @override
  void initState() {
    getStoriesData("");
    searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void getStoriesData(String param) {
    print(param);
    storyCubit
        .getSearchStories(body: {"search": param, "user": widget?.id ?? ""});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                        "Story Saya",
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
            buildList(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBarSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10.h),
      child: TextFormField(
        onFieldSubmitted: (value) {
          getStoriesData(searchTextController.text);
          return null;
        },
        onSaved: (value) {},
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              if (searchTextController.text.isEmpty)
                getStoriesData(searchTextController.text);
              else
                setState(
                  () {
                    searchTextController.clear();
                    getStoriesData(searchTextController.text);
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

  Widget buildList() {
    return BlocBuilder(
      cubit: storyCubit,
      builder: (context, state) {
        if (state is StoryLoaded) if (state.stories != null)
          return Column(
            children: [
              Padding(
                child: Row(
                  children: [
                    Text(
                      "Terdapat",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: textDark1),
                    ),
                    Text(
                      " ${state.stories.length} ",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: primary1),
                    ),
                    Text(
                      "Story",
                      style: ralewayTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: textDark1),
                    ),
                  ],
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 10.h),
                itemCount: state.stories.length,
                itemBuilder: (_, index) {
                  printInfo(info: index.toString());
                  return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 11.h, left: 11.h, right: 11.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: FadeInImage(
                              placeholder:
                                  AssetImage("assets/images/placeholder.jpg"),
                              image: NetworkImage(
                                state.stories[index].cover,
                              ),
                              placeholderErrorBuilder: (_, s, v) {
                                return Image.asset(
                                    "assets/images/placeholder.jpg");
                              },
                              width: 80.w,
                              height: 92.w,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(11.w),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${state.stories[index].title}",
                                    style: playfairDisplayTextStyle.copyWith(
                                        fontSize: 12.sp, color: textDark1)),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      UniconsLine.calender,
                                      size: 10.sp,
                                      color: textDark2,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                      width: 2.h,
                                    ),
                                    Text("${state.stories[index].created}",
                                        style: ralewayTextStyle.copyWith(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w400,
                                            color: textDark2))
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      UniconsLine.user,
                                      size: 10.sp,
                                      color: textDark2,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                      width: 2.h,
                                    ),
                                    Text("${state.stories[index].terapis.name}",
                                        style: ralewayTextStyle.copyWith(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w400,
                                            color: textDark2)),
                                    SizedBox(
                                      height: 2.h,
                                      width: 2.h,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/verifikasi.svg",
                                      height: 8.w,
                                      width: 8.w,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Get.to(
                      EditStoryScreen(
                        storyModel: state.stories[index],
                      ),
                    ),
                  );
                },
              )
            ],
          );
        else
          return SizedBox();
        else if (state is StoryLoadingFailed) {
          return Padding(
            padding: EdgeInsets.all(10.w),
            child: Text(
              state?.message ?? "Data Tidak Ditemukan.",
              textAlign: TextAlign.center,
              style: ralewayTextStyle.copyWith(
                  fontSize: 13.sp, color: error, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return loadingIndicator();
        }
      },
    );
  }
}
