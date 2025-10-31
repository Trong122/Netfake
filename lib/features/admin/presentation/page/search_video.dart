import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../search/presentation/provider/search_provider.dart'; // provider search video
import 'admin_page.dart';
import '../provider/admin_provdier.dart';
import 'package:netfake/features/video/domain/provider/video_provider_domain.dart';
class SearchScreenAdmin extends ConsumerStatefulWidget {
  const SearchScreenAdmin({super.key});

  @override
  ConsumerState<SearchScreenAdmin> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreenAdmin> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // rebuild khi gõ
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim();

    // Lấy searchResult theo query từ FutureProvider.family
    final searchResult = ref.watch(searchVideoProvider(query));
    final deleteVideo = ref.read(deleteVideoUsecaseProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Nhập tên phim ...',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 8),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: searchResult.when(
          data: (videos) {
            if (query.isEmpty) {
              return const Center(
                child: Text(
                  'Nhập tên phim để tìm kiếm',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            if (videos.isEmpty) {
              return const Center(
                child: Text(
                  'Không tìm thấy phim nào 😢',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (contex, index) {
                final video = videos[index];
                return Card(
                  color: const Color(0xFF1A1A1A),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      video.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      video.description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              openForm(context, ref, video: video);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await deleteVideo(
                                videos[index].id,
                              ); // truyền id video cần xóa
                              ref.invalidate(
                                videoListProvider,
                              ); // reload danh sách
                            },
                          ),
                        ],
                      ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) => Center(
            child: Text('Lỗi: $err', style: const TextStyle(color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
