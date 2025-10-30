import 'package:flutter/material.dart';

class BannersCarousel extends StatefulWidget {
  final List<String> bannerAssets;
  const BannersCarousel({super.key, required this.bannerAssets});

  @override
  State<BannersCarousel> createState() => _BannersCarouselState();
}

class _BannersCarouselState extends State<BannersCarousel> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.bannerAssets.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    widget.bannerAssets[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12, // 12 pixels de baixo
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.bannerAssets.length,
              (index) => _buildDot(context, index: index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(BuildContext context, {required int index}) {
    final bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8, // Bolinha ativa é mais comprida
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
