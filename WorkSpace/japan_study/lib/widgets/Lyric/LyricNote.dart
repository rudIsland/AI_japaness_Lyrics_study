import 'package:flutter/material.dart';
import 'package:japan_study/utils/app_size.dart';

class LyricNote extends StatelessWidget {
  final List<String> notes;

  const LyricNote({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) return const SizedBox.shrink();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notes.map((point) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
              child: Text(
                "• $point",
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.4,
                  color: Colors.black54,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
