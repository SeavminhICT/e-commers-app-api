import 'package:flutter/material.dart';

Widget buildOnboardingScreen(
  BuildContext context, {
  required Color? imageColor, // You can replace this with Image.asset() later
  required String title,
  required String subtitle,
  required int activeDotIndex,
  Widget? nextPage,
  bool isLast = false,
}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 30),
          Column(
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: imageColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: activeDotIndex == index ? 12 : 8,
                    height: activeDotIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: activeDotIndex == index
                          ? const Color(0xFF6C63FF)
                          : const Color(0xFFFFE0E0),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isLast) {
                      // Navigate to home or login
                    } else if (nextPage != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => nextPage),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isLast ? "GET STARTED" : "NEXT",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  // Skip to home or login
                },
                child:
                    const Text("Skip", style: TextStyle(color: Colors.black54)),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
