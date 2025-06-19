import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recent',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildNotificationItem(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Purchase Completed!',
                  message: 'You have successfully purchased J34 headphones, thank you and wait for your package to arrive✨',
                  time: '2m ago',
                  ),
                  Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  ),
                _buildNotificationItem(
                  icon: Icons.local_fire_department,
                  title: 'Flash Sale!',
                  message: 'Get 20% discount for first transaction in this month!🤩',
                  time: '2m ago',
                  ),
                  Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  ),
                _buildNotificationItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Package Sent',
                  message: 'Hi your package has been sent from new york',
                  time: '10m ago',
                  ),
                _buildNotificationItem(
                  icon: Icons.wallet_giftcard,
                  title: 'Loyalty Rewards!',
                  message: 'You\'ve earned 500 points from your last purchase 🎁',
                  time: '30m ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(
                  icon: Icons.event_available,
                  title: 'Limited Time Event',
                  message: 'Join our tech workshop this weekend - Free registration! 📱',
                  time: '1h ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(
                  icon: Icons.message_outlined,
                  isMessage: true,
                  title: 'Customer Support',
                  message: 'Hi, how can we assist you today? 😊',
                  time: '2h ago',
                  hasReply: true,
                ),
                _buildNotificationItem(
                  icon: Icons.update,
                  title: 'App Update Available',
                  message: 'Version 2.0 is now available with exciting new features! 🚀',
                  time: '3h ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(
                  icon: Icons.thumb_up_outlined,
                  title: 'Review Request',
                  message: 'Love our app? Rate us on the App Store! ⭐',
                  time: '4h ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(
                  icon: Icons.back_hand,
                  title: 'Welcome Back!',
                  message: 'We missed you! Check out what\'s new in our store 👋',
                  time: '5h ago',
                ),
            ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    IconData? icon,
    bool isMessage = false,
    required String title,
    required String message,
    required String time,
    bool hasReply = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: isMessage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'images/cs.png', // Replace with actual profile image
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(icon, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                if (hasReply) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Reply the message',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}