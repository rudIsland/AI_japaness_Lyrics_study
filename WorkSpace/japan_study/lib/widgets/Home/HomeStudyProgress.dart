import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 1. 추가
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/utils/app_size.dart';

class HomeStudyProgress extends StatelessWidget {
  const HomeStudyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 2. [Outer] 로그인 상태 변경 감지
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, _) {
        // 🔥 3. [Inner] 상태가 변하면 Future를 다시 호출해서 데이터를 갱신함
        return FutureBuilder<int>(
          future: RudDatabase().getTodayCompletedCount(),
          initialData: 0,
          builder: (context, snapshot) {
            final int completed = snapshot.data ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 15.h),
                  child: Text(
                    "공부 할당량",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "오늘의 목표",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$completed / 10 곡 완료",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        LinearProgressIndicator(
                          value: completed / 10,
                          minHeight: 10.h,
                          backgroundColor: Colors.white,
                          valueColor: const AlwaysStoppedAnimation(Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
