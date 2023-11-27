import 'package:flutter/material.dart';
import 'package:money_management/core/helpers/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
            child: Column(
              children: [
                // HEADER
                Row(
                  children: [
                    Text(
                      '${months[DateTime.now().month - 1]} ${DateTime.now().day}\n${days[DateTime.now().weekday - 1]}',
                      style: TextStyle(
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
                                    "https://via.placeholder.com/32x32"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              shadows: [
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
