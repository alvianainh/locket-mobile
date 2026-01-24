// photo_card.dart
import 'package:flutter/material.dart';
import '../../models/photo.dart';

class PhotoCard extends StatefulWidget {
  final Photo photo;
  final List<Photo>? allPhotos;
  final int? initialIndex;

  const PhotoCard({
    super.key,
    required this.photo,
    this.allPhotos,
    this.initialIndex,
  });

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 200;
    const double cardHeight = 200;

    Widget content = GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PhotoFullscreenPage(
              photos: widget.allPhotos ?? [widget.photo],
              initialIndex: widget.initialIndex ?? 0,
            ),
          ),
        );
        setState(() {}); 
      },
      onTapDown: (_) {
        if (widget.photo.description.isNotEmpty) {
          setState(() => _isHovered = true);
        }
      },
      onTapUp: (_) {
        setState(() => _isHovered = false);
      },
      onTapCancel: () {
        setState(() => _isHovered = false);
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  widget.photo.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                offset: _isHovered ? Offset(0, 0) : Offset(1, 0),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD76C82).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.photo.description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) {
        if (widget.photo.description.isNotEmpty) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      child: content,
    );
  }
}



// FULLSCREEN PAGE
class PhotoFullscreenPage extends StatefulWidget {
  final List<Photo> photos;
  final int initialIndex;

  const PhotoFullscreenPage({
    super.key,
    required this.photos,
    this.initialIndex = 0,
  });

  @override
  State<PhotoFullscreenPage> createState() => _PhotoFullscreenPageState();
}

class _PhotoFullscreenPageState extends State<PhotoFullscreenPage> {
  late PageController _pageController;
  late int _currentIndex;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _textController = TextEditingController(
      text: widget.photos[_currentIndex].description,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveDescription() {
    setState(() {
      widget.photos[_currentIndex].description = _textController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deskripsi berhasil disimpan')),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _textController.text = widget.photos[_currentIndex].description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 40),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -0.8),
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD76C82),
                Color(0xFFF8F4EC),
              ],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Photo ${_currentIndex + 1}/${widget.photos.length}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xFFF8F4EC),
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.photos.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final p = widget.photos[index];
              return Center(
                child: Image.network(
                  p.imageUrl,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFD76C82),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: TextField(
                        controller: _textController,
                        maxLines: 4,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Tulis deskripsi...',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white54,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFD76C82),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.white, size: 32),
                        onPressed: _saveDescription,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
