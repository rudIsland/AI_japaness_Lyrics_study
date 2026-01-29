import 'package:flutter/material.dart';
import 'package:japan_study/utils/app_size.dart';

class LyricControlPanel extends StatelessWidget {
  final bool showFurigana;
  final bool showTranslation;
  final bool isAutoScrollEnabled;
  final VoidCallback onToggleFurigana;
  final VoidCallback onToggleTranslation;
  final VoidCallback onToggleFocus;

  const LyricControlPanel({
    super.key,
    required this.showFurigana,
    required this.showTranslation,
    required this.isAutoScrollEnabled,
    required this.onToggleFurigana,
    required this.onToggleTranslation,
    required this.onToggleFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _toggleBtn("후리가나", showFurigana, onToggleFurigana),
            SizedBox(width: 8.w),
            _toggleBtn("번역", showTranslation, onToggleTranslation),
            SizedBox(width: 8.w),
            _toggleBtn(
              "포커싱",
              isAutoScrollEnabled,
              onToggleFocus,
              isFocus: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleBtn(
    String label,
    bool isOn,
    VoidCallback onTap, {
    bool isFocus = false,
  }) {
    final Color bColor = isOn ? Colors.black : Colors.grey.shade100;
    final Color tColor = isOn ? Colors.white : Colors.grey.shade600;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: bColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isFocus) ...[
              Icon(
                Icons.center_focus_strong_outlined,
                size: 14.sp,
                color: tColor,
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: TextStyle(
                color: tColor,
                fontSize: 13.sp,
                fontWeight: isOn ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
