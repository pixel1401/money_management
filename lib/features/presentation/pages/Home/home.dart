import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/bloc/user/user_cubit.dart';
import 'package:money_management/features/presentation/bloc/user/user_state.dart';
import 'package:money_management/features/presentation/shared/ui/PieChart/pie_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';

List<PieChartVM> mockData = [
  PieChartVM(title: 'Food', percent: 50),
  PieChartVM(title: 'Work', percent: 50),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var SheetState = context.watch<SheetCubit>().state;
    bool isLoad = (SheetState.pieChartData ?? []).isEmpty;

    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is Authorized) {
        return Skeletonizer(
          enabled: isLoad,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.06, -1.00),
                  end: Alignment(0.06, 1),
                  colors: [Color(0xFFFFF6E5), Color(0x00F7ECD7)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${months[DateTime.now().month - 1]} ${DateTime.now().day}\n${days[DateTime.now().weekday - 1]}',
                        style: const TextStyle(
                          color: Color(0xFF0D0000),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      state.userData.photoUrl ?? ''),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0xFFAD00FF),
                                    blurRadius: 0,
                                    offset: Offset(0, 0),
                                    spreadRadius: 3,
                                  ),
                                  BoxShadow(
                                    color: Color(0xFFF5F5F5),
                                    blurRadius: 0,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Space(20, 0),
                  Text(
                    'Account Balance',
                    style: TextStyle(
                      color: Color(0xFF90909F),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    context.watch<SheetCubit>().state.totalPrice.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF161719),
                      fontSize: 40,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // _buildBtn(() {
                      //   Navigator.pushNamed(context, '/addTrans');
                      // }),
                      // _buildBtn( () => {

                      // } ,false),
                    ],
                  ),

                  PieChartSample2(
                    values: context.watch<SheetCubit>().state.pieChartData ??
                        mockData,
                  )
                  // Text(context.read<UserCubit>().state )
                ],
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  TextButton _buildBtn(Function onTap, [bool isExpenses = true]) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        width: 150,
        height: 80,
        decoration: ShapeDecoration(
          color: isExpenses ? Color(0xFFFD3C4A) : HexColor('#00A86B'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 72,
              top: 18,
              child: Text(
                'Expenses',
                style: TextStyle(
                  color: Color(0xFFFBFBFB),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 72,
              top: 39,
              child: Text(
                '11200',
                style: TextStyle(
                  color: Color(0xFFFBFBFB),
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 17,
              child: Container(
                width: 48,
                height: 48,
                decoration: ShapeDecoration(
                  color: Color(0xFFFBFBFB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 8.20,
                      top: 8,
                      child: Container(
                        width: 32,
                        height: 32,
                        padding: const EdgeInsets.only(
                          top: 1.99,
                          left: 4,
                          right: 4,
                          bottom: 2,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: isExpenses
                                  ? Color(0xFFFD3C4A)
                                  : HexColor('#00A86B'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
