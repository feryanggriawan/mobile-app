import 'package:flutter/material.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/widgets/widgets.dart';

class StoryDetailPage extends StatefulWidget {
  final StoryModel storyModel;

  const StoryDetailPage({Key key, this.storyModel}) : super(key: key);

  @override
  _StoryDetailPageState createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  final ScrollController controller = ScrollController();

  double pixels = 0;

  StoryModel storyModel;

  @override
  void initState() {
    storyModel = widget.storyModel;
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
        children: [
          AnimatedAppbarWidget(
            pixels: pixels,
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    image: DecorationImage(
                      image: NetworkImage(storyModel.cover),
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
                        "${storyModel.title}",
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
                        "Publish By ${storyModel.terapis.name}".toUpperCase(),
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
                      title: storyModel.title,
                      date: toDateString(
                        DateTime.parse(
                          storyModel.created,
                        ),
                      ),
                      name: storyModel.terapis.name,
                      category: ["Jantung", "Diabetes"],
                      location: "Bandung",
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
                          image: NetworkImage(storyModel.cover),
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
                      parseHtmlExtension(storyModel.description),
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
