import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryPage extends StatefulWidget {
  final String id;

  const StoryPage({Key key, this.id}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAppBarSearch(),
            buildList(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBarSearch() {
    return AppBarWithSearchWidget(
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
      onFieldSubmitted: (value) {
        getStoriesData(searchTextController.text);
        return null;
      },
      textEditingController: searchTextController,
    );
  }

  Widget buildList() {
    return BlocBuilder(
      cubit: storyCubit,
      builder: (context, state) {
        if (state is StoryLoaded) if (state.stories != null)
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.only(top: 10.h),
            itemCount: state.stories.length,
            itemBuilder: (_, index) {
              printInfo(info: index.toString());
              return GestureDetector(
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: 11.h, left: 11.h, right: 11.h),
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
                            return Image.asset("assets/images/placeholder.jpg");
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
                            // Row(
                            //   children: [
                            //     Icon(
                            //       UniconsLine.location_point,
                            //       size: 10.sp,
                            //       color: textDark2,
                            //     ),
                            //     SizedBox(
                            //       height: 5.h,
                            //     ),
                            //     Text("${state.stories[index].area}",
                            //         style: ralewayTextStyle.copyWith(
                            //             fontSize: 8.sp,
                            //             fontWeight: FontWeight.w400,
                            //             color: textDark2))
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 13.h,
                            // ),
                            // Row(
                            //   children: state.stories[index]
                            //       .tags
                            //       .map((e) => Container(
                            //           padding: EdgeInsets.symmetric(
                            //               vertical: 2.h, horizontal: 8.w),
                            //           margin: EdgeInsets.only(right: 4.w),
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(100.r),
                            //               color: textDark2),
                            //           child: Text("$e",
                            //               style: ralewayTextStyle.copyWith(
                            //                   fontSize: 8.sp,
                            //                   color: textLight2))))
                            //       .toList(),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Get.to(
                  StoryDetailPage(
                    storyModel: state.stories[index],
                  ),
                ),
              );
            },
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
