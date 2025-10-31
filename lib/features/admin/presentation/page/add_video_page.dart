import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../video/domain/entities/video.dart';
import '../provider/admin_provdier.dart'; 
class AddMovieScreen extends ConsumerStatefulWidget {
  final Video? video; // nếu null → thêm mới, khác null → sửa

  const AddMovieScreen({super.key, this.video});

  @override
  ConsumerState<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends ConsumerState<AddMovieScreen> {
  // Controllers
  final _tenPhimController = TextEditingController();
  final _anhController = TextEditingController();
  final _videoController = TextEditingController();
  final _danhGiaController = TextEditingController();
  final _moTaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Nếu đang sửa → điền dữ liệu cũ
    final video = widget.video;
    _tenPhimController.text = video?.title ?? '';
    _anhController.text = video?.imageUrl ?? '';
    _videoController.text = video?.videoUrl ?? '';
    _danhGiaController.text = video?.rating.toString() ?? '';
    _moTaController.text = video?.description ?? '';
  }

  @override
  void dispose() {
    _tenPhimController.dispose();
    _anhController.dispose();
    _videoController.dispose();
    _danhGiaController.dispose();
    _moTaController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _tenPhimController.text;
    final imageUrl = _anhController.text;
    final videoUrl = _videoController.text;
    final rating = double.tryParse(_danhGiaController.text) ?? 0.0;
    final description = _moTaController.text;
    final newVideo = Video(
      id: widget.video?.id ?? '',
      title: title,
      description: description,
      videoUrl: videoUrl,
      imageUrl: imageUrl,
      rating: rating
    );
    try {
      if (widget.video == null) {
        // Thêm mới
        await ref.read(addVideoProvider)(newVideo);
      } else {
        // Sửa
        await ref.read(updateVideoProvider)(newVideo);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.video == null ? 'Đã thêm phim' : 'Đã cập nhật phim',
          ),
        ),
      );

      Navigator.pop(
        context,
        true,
      ); // quay lại màn hình trước, trả về true để reload
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/Logo.svg', width: 30, height: 30),
            const SizedBox(width: 8),
            Text(
              widget.video == null ? "Thêm phim" : "Sửa phim",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Tên phim"),
              _buildTextField(controller: _tenPhimController),

              _buildLabel("Đường dẫn ảnh"),
              _buildTextField(controller: _anhController),

              _buildLabel("Đường dẫn video"),
              _buildTextField(controller: _videoController),

              _buildLabel("Đánh giá"),
              _buildTextField(
                controller: _danhGiaController,
                keyboardType: TextInputType.number,
              ),

              _buildLabel("Mô tả"),
              _buildTextField(controller: _moTaController, maxLines: 5),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.video == null ? "Thêm" : "Cập nhật",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Vui lòng không để trống';
        return null;
      },
    );
  }
}
