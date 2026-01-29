import 'package:flutter/material.dart';
import 'package:japan_study/utils/app_size.dart';

class SearchRecommendList extends StatelessWidget {
  final List<String> hints;
  final Function(String) onSelected;

  const SearchRecommendList({
    super.key,
    required this.hints,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 300.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: hints.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.search, color: Colors.grey),
          title: Text(hints[index], style: TextStyle(fontSize: 14.sp)),
          onTap: () => onSelected(hints[index]),
        ),
      ),
    );
  }
}
