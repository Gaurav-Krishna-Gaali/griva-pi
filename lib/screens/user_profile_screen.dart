import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserProfileScreen extends StatefulWidget {
  final String userEmail;

  const UserProfileScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = await _userService.getUserByEmail(widget.userEmail);
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.purple[300],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(child: Text('User not found'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Header
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.purple[100],
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.purple[600],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _user!.fullName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _user!.role.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Profile Information
                      _buildInfoSection('Personal Information', [
                        _buildInfoRow('Full Name', _user!.fullName),
                        _buildInfoRow('Email', _user!.email),
                        if (_user!.phoneNumber != null)
                          _buildInfoRow('Phone', _user!.phoneNumber!),
                      ]),

                      const SizedBox(height: 24),

                      _buildInfoSection('Medical Information', [
                        _buildInfoRow('Medical License', _user!.medicalLicense),
                        _buildInfoRow('Hospital/Clinic', _user!.hospital),
                        if (_user!.specialization != null)
                          _buildInfoRow('Specialization', _user!.specialization!),
                        if (_user!.department != null)
                          _buildInfoRow('Department', _user!.department!),
                      ]),

                      const SizedBox(height: 24),

                      _buildInfoSection('Account Information', [
                        _buildInfoRow('Status', _user!.isActive ? 'Active' : 'Inactive'),
                        _buildInfoRow('Role', _user!.role),
                        if (_user!.createdAt != null)
                          _buildInfoRow('Member Since', 
                            '${_user!.createdAt!.day}/${_user!.createdAt!.month}/${_user!.createdAt!.year}'),
                        if (_user!.lastLogin != null)
                          _buildInfoRow('Last Login', 
                            '${_user!.lastLogin!.day}/${_user!.lastLogin!.month}/${_user!.lastLogin!.year}'),
                      ]),

                      const SizedBox(height: 32),

                      // Action Buttons
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement edit profile functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Edit profile functionality coming soon!')),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[300],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 