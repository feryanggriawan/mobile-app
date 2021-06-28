
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/pages/blog/blog_detail.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final blogCubit = BlogCubit();
  final searchTextController = TextEditingController();

  @override
  void initState() {
    getBlogData("");
    searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void getBlogData(String param) {
    blogCubit.getSearchBlogs(body: {
      "search": param,
    });
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
          getBlogData(searchTextController.text);
        else
          setState(
            () {
              searchTextController.clear();
              getBlogData(searchTextController.text);
            },
          );
      },
      onFieldSubmitted: (value) {
        getBlogData(searchTextController.text);
        return null;
      },
      textEditingController: searchTextController,
    );
  }

  Widget buildList() {
    return BlocBuilder(
      cubit: blogCubit,
      builder: (context, state) {
        if (state is BlogLoaded) if (state.blogs != null)
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.only(top: 10.h),
              itemCount: state.blogs.length,
              itemBuilder: (_, index) {
                printInfo(info: index.toString());
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 11.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                    ),
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
                              state.blogs[index].cover,
                            ),
                            placeholderErrorBuilder: (_, s, v) {
                              return Image.asset(
                                  "assets/images/placeholder.jpg");
                            },
                            width: 80.w,
                            height: 80.w,
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
                              Text("${state.blogs[index].title}",
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
                                  Text(
                                    "${toDateString(
                                      DateTime.parse(
                                        state.blogs[index].created,
                                      ),
                                    )}",
                                    style: ralewayTextStyle.copyWith(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w400,
                                      color: textDark2,
                                    ),
                                  )
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
                                  Text("${state.blogs[index].writer.name}",
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
                    BlogDetailPage(
                      blog: state.blogs[index],
                    ),
                  ),
                );
              });
        else
          return SizedBox();
        else if (state is BlogLoadingFailed) {
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
