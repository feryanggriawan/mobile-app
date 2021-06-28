import 'package:flutter/material.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';

class BlogDetailPage extends StatefulWidget {
  final Blog blog;

  const BlogDetailPage({Key key, this.blog}) : super(key: key);

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final ScrollController controller = ScrollController();

  double pixels = 0;

  Blog blog = Blog();

  @override
  void initState() {
    blog = widget.blog;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AnimatedAppbarWidget(
            pixels: pixels,
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    image: DecorationImage(
                      image: NetworkImage(blog?.cover ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 35.sp,
                  height: 35.sp,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${blog?.title ?? ""}",
                        overflow: TextOverflow.ellipsis,
                        style: playfairDisplayTextStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4.sp,
                      ),
                      Text(
                        "Publish By ${blog?.writer?.name ?? ""}".toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: ralewayTextStyle.copyWith(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                            color: textDark1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            showHideIn: 50.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  Padding(
                    child: StoryHeaderDetailWidget(
                      title: blog?.title ?? "",
                      date: toDateString(
                        DateTime.parse(
                          blog?.created ?? DateTime.now(),
                        ),
                      ),
                      name: blog?.writer?.name ?? "",
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.w,
                    ),
                  ),
                  Padding(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        image: DecorationImage(
                          image: NetworkImage(blog?.cover ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 220.sp,
                      width: double.infinity,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    child: Text(
                      parseHtmlExtension(blog?.description ?? ""),
                      style: playfairDisplayTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: textDark1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                  ),
                  Padding(
                    child: Divider(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
