import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildbody(),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Mega Mall',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'images/notification_icon.png',
                height: 20,
                width: 20,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset(
                'images/shopping_icon.png',
                height: 20,
                width: 20,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildbody() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [_build_search(), buildAutoSlideShow()],
        ),
      ),
    );
  }

  Widget _build_search() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search Product Name',
            hintStyle: TextStyle(color: Color(0xFFC4C5C4)),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 14), // <== add this line
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAutoSlideShow() {
    final List<String> _imagePaths = [
      'images/16987373017frli-photo-2023-10-31-14-17-09.jpg',
      'images/Visa-Promotion-ProEng.jpg',
      'images/Website-Booking.com-Promotion-Visa.png',
      'images/16987373017frli-photo-2023-10-31-14-17-09.jpg',
      'images/Visa-Promotion-ProEng.jpg',
    ];

    PageController _controller = PageController();
    int _currentIndex = 0;
    Timer? _timer;

    return StatefulBuilder(
      builder: (context, setState) {
        if (_timer == null) {
          _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
            int nextPage = _currentIndex + 1;
            if (nextPage >= _imagePaths.length) nextPage = 0;
            _controller.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _imagePaths[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_imagePaths.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 12 : 8,
                    height: _currentIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? Colors.blue : Colors.grey,
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }






}
