import 'package:flutter/material.dart';
import 'package:tsi_mobile/cubit/cubit.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:tsi_mobile/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_mobile/cubit/pasien/pasien.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTherapyDone extends StatefulWidget {
  @override
  _HomeTherapyDoneState createState() => _HomeTherapyDoneState();
}

class _HomeTherapyDoneState extends State<HomeTherapyDone> {
  final pasienCubit = MemberGetCubit();

  @override
  void initState() {
    pasienCubit.getMemberPasien(body: {
      "pasien": "",
      "type" : 1,
      "user" : (context.read<UserCubit>().state as UserLoaded).user.id
    });
    super.initState();
  }

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: BlocBuilder(
        cubit: pasienCubit,
        builder: (context, state){
          return ListView.builder(
            itemCount: (state is MemberGetLoaded) ? state.pasiens.length : 0,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              if (state is MemberGetLoaded) {
                return SudahDiterapiWidget(
                    image:  state.pasiens[index].photo,
                    paddingLeft: defaultMargin,
                    paddingRight:
                    (index + 1 ==  state.pasiens.length) ? defaultMargin : 0,
                    age:  int.parse(state.pasiens[index].usia),
                    date:  DateFormat("dd MMMM yyyy").format(DateTime.parse(state.pasiens[index].release.last.schedule)),
                    hour:  DateFormat("HH:mm").format(DateTime.parse(state.pasiens[index].release.last.schedule)),
                    disease:  state.pasiens[index].release.last.penyakit.map((e) => e).toList(),
                    gender:  state.pasiens[index].jenisKelamin,
                    name:  state.pasiens[index].name,
                    onTap: () {
                      _launchURL("tel:${state.pasiens[index].phone}");
                    });
              } else {
                return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
