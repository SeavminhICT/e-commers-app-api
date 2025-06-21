import 'dart:convert';
import 'dart:io'; // Required for File
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:e_commers_app/module/api_service/api_service.dart'; // Import ApiService
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Required for ImagePicker


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _username = 'YourUsername';
  String _emailOrPhone = 'your@email.com';
  String _avatarUrlFromStorage = ''; // To store the avatar URL loaded from storage
  bool _isLoading = false; // For loading state
  File? _selectedImageFile; // To store the newly picked image file

  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }

  @override
  void initState() {
    super.initState();
    _usernameController.text = _username;
    _emailController.text = _emailOrPhone;
    _loadProfileData(); // Initial load: tries server then local
  }

  Future<void> _loadProfileData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      await _fetchProfileFromServerAndUpdateState();
    } catch (e) {
      debugPrint("Failed to load profile from server, trying local storage: $e");
      await _loadProfileFromLocalAndUpdateState();
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _fetchProfileFromServerAndUpdateState() async {
    if (!mounted) return;
    final language = context.read<LanguageLogic>().language; // Get language data

    try {
      final token = await StorageService.
      read(key: 'token');
      if (token == null) {
        // Handle case where token is not found, perhaps navigate to login
        debugPrint('Authentication token not found. User might not be logged in.');
        throw Exception('Authentication token not found.');
      }
      final userProfileData = await ApiService().getUserProfile(token);

      if (mounted) {
        setState(() {
          _username = userProfileData['name'] ?? _username;
          _emailOrPhone = userProfileData['email'] ?? _emailOrPhone;
          _avatarUrlFromStorage = userProfileData['avatar'] ?? _avatarUrlFromStorage;

          _usernameController.text = _username;
          _emailController.text = _emailOrPhone;
        });
        // Save fresh data to local storage
        await StorageService.write(key: 'user', value: jsonEncode(userProfileData));
      }
    } catch (e) {
      debugPrint('Failed to fetch/update user profile from API: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${language.Error_loadi} Profile Data')),
        );
      }
      rethrow; // Important to rethrow so _loadProfileData can try local fallback
    }
  }

  Future<void> _loadProfileFromLocalAndUpdateState() async {
    final userJson = await StorageService.read(key: 'user');
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      if (mounted) {
        setState(() {
          _username = userMap['name'] ?? 'YourUsername';
          _emailOrPhone = userMap['email'] ?? 'your@email.com';
          _avatarUrlFromStorage = userMap['avatar'] ?? ''; // Expecting a URL or empty
          _usernameController.text = _username;
          _emailController.text = _emailOrPhone;
        });
      }
    }
  }

  Future<void> _saveProfileChanges() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final languageData = context.read<LanguageLogic>().language;

    try {
      final token = await StorageService.read(key: 'token');
      if (token == null) {
        throw Exception('Authentication token not found.');
      }

      final updatedUserData = await ApiService().updateUserProfile(
        token: token,
        name: _usernameController.text,
        avatarFile: _selectedImageFile,
      );

      if (mounted) {
        setState(() {
          _username = updatedUserData['name'] ?? _username;
          _emailOrPhone = updatedUserData['email'] ?? _emailOrPhone; // Assuming email might be returned
          _avatarUrlFromStorage = updatedUserData['avatar'] ?? _avatarUrlFromStorage;
          _usernameController.text = _username;
          _emailController.text = _emailOrPhone;
          _selectedImageFile = null; // Clear selected image after successful upload
        });

        // Save updated user data to local storage
        await StorageService.write(key: 'user', value: jsonEncode(updatedUserData));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(languageData.Profile_Updated_Successfully)),
        );
      }
    } catch (e) {
      debugPrint('Failed to save profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${languageData.Error_Saving_Profile}: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (mounted) {
        setState(() {
          _selectedImageFile = File(image.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(context, languageData),
      body: _buildBody(context, languageData),
      bottomNavigationBar: _buildSaveButton(context, languageData),
    );
  }

  // Removed duplicate _buildAppBar with no parameters.

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.deepPurple),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildLinkedAccount() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/google_logo.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          const Text(
            'Google',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Icon(
            Icons.link,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Language languageData) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        languageData.Edit_Profile, // Use translated string
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Language languageData) {
    ImageProvider<Object> getAvatarImageProvider() {
      if (_selectedImageFile != null) {
        return FileImage(_selectedImageFile!);
      }
      if (_avatarUrlFromStorage.isNotEmpty && _avatarUrlFromStorage.startsWith('http')) {
        return NetworkImage(fixUrl(_avatarUrlFromStorage));
      }
      return const AssetImage('images/profile.png'); // Default placeholder
    }

    return RefreshIndicator(
      onRefresh: _fetchProfileFromServerAndUpdateState, // Call server fetch on refresh
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(), // Ensure scroll even if content is small
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: getAvatarImageProvider(),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle image loading errors, e.g., by showing a default
                    debugPrint('Error loading avatar: $exception');
                    if (mounted) {
                    }
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
              ),
          ),
          const SizedBox(height: 32),
          _buildSectionTitle(languageData.Username), // Use translated string
          _buildTextField(
            controller: _usernameController,
            icon: Icons.person_outline,
            hintText: languageData.Username, // Use translated string
          ),
          const SizedBox(height: 24),
          _buildSectionTitle(languageData.Email_or_Phone_Number), // Use translated string
          _buildTextField(
            controller: _emailController,
            icon: Icons.email_outlined,
            hintText: languageData.Email_or_Phone_Number, // Use translated string
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle(languageData.Account_Linked_With), // Use translated string
          _buildLinkedAccount(), 
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, Language languageData) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfileChanges, // Call _saveProfileChanges
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          minimumSize: const Size.fromHeight(48),
          disabledBackgroundColor: Colors.deepPurple.withOpacity(0.5), // For loading state
        ),
        child: _isLoading
            ? const SizedBox( // Show loader when _isLoading is true
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                languageData.Save_Changes, // Use translated string
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
