import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          languageData.Notifications, // Use translated string
          style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              languageData.Recents, // Use translated string
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildNotificationItem(context, languageData,
                  icon: Icons.shopping_cart_outlined,
                  title: languageData.Purchase_Completed, // Use translated string
                  message: languageData.Purchase_Message, // Use translated string
                  time: '2m ago',
                  ),
                  Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.local_fire_department,
                  title: languageData.Flash_Sale, // Use translated string
                  message: languageData.Flash_Sale_Message, // Use translated string
                  time: '2m ago',
                  ),
                  Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.local_shipping_outlined,
                  title: languageData.Package_Sent, // Use translated string
                  message: languageData.Package_Sent_Message, // Use translated string
                  time: '10m ago',
                  ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.wallet_giftcard,
                  title: languageData.Loyalty_Rewards, // Use translated string
                  message: languageData.Loyalty_Rewards_Message, // Use translated string
                  time: '30m ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.event_available,
                  title: languageData.Limited_Time_Event, // Use translated string
                  message: languageData.Limited_Time_Event_Message, // Use translated string
                  time: '1h ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(context, languageData,
                  isMessage: true,
                  title: languageData.Customer_Support, // Use translated string
                  message: languageData.Customer_Support_Message, // Use translated string
                  time: '2h ago',
                  hasReply: true,
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.update,
                  title: languageData.App_Update_Available, // Use translated string
                  message: languageData.App_Update_Message, // Use translated string
                  time: '3h ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.thumb_up_outlined,
                  title: languageData.Review_Request, // Use translated string
                  message: languageData.Review_Request_Message, // Use translated string
                  time: '4h ago',
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _buildNotificationItem(context, languageData,
                  icon: Icons.back_hand,
                  title: languageData.Welcome_Back, // Use translated string
                  message: languageData.Welcome_Back_Message, // Use translated string
                  time: '5h ago',
                ),
            ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, Language languageData, {
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
                    languageData.Reply_the_message, // Use translated string
                    style:  TextStyle(
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