import 'package:flutter/material.dart';
import 'package:japan_study/utils/app_size.dart';
import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';

class YoutubeResultList extends StatefulWidget {
  final List<YoutubeVideo> videos;
  final bool isLoading;
  final String query; // RUD: 현재 검색어 표시를 위해 추가
  final Function(YoutubeVideo) onSongSelected;
  final Function(String) onSearch; // RUD: 재검색 로직 실행을 위한 콜백

  const YoutubeResultList({
    super.key,
    required this.videos,
    required this.isLoading,
    required this.query,
    required this.onSongSelected,
    required this.onSearch,
  });

  @override
  State<YoutubeResultList> createState() => _YoutubeResultListState();
}

class _YoutubeResultListState extends State<YoutubeResultList> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. 상단 재검색 바 (고정 영역)
        _buildSearchBar(),

        // 2. 검색 결과 및 리스트 (스크롤 영역)
        Expanded(
          child: widget.isLoading
              ? _buildLoadingIndicator()
              : _buildScrollableBody(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      color: Colors.white,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "다시 검색할 내용을 입력하세요",
          prefixIcon: const Icon(Icons.search, color: Colors.red),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send_rounded, color: Colors.red),
            onPressed: () => widget.onSearch(_searchController.text),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
        onSubmitted: (value) => widget.onSearch(value),
      ),
    );
  }

  Widget _buildScrollableBody() {
    if (widget.videos.isEmpty && !widget.isLoading) {
      return Center(
        child: Text(
          "검색 결과가 없습니다.",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      );
    }

    // RUD: 결과 문구와 리스트가 함께 스크롤되도록 구조화
    return CustomScrollView(
      slivers: [
        // 결과 문구 헤더
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 10.h),
            child: Text(
              "'${widget.query}'에 대한 검색 결과",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        // 비디오 리스트
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final video = widget.videos[index];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 8.h,
              ),
              leading: _buildThumbnail(video.thumbnailUrl),
              title: Text(
                video.title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                video.artist,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              onTap: () => widget.onSongSelected(video),
            );
          }, childCount: widget.videos.length),
        ),
        // 하단 여백 추가
        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator(color: Colors.red));
  }

  Widget _buildThumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Image.network(
        url,
        width: 100.w,
        height: 60.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 100.w,
          height: 60.h,
          color: Colors.grey.shade200,
          child: const Icon(Icons.error),
        ),
      ),
    );
  }
}
