import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onMenuSelected;

  const CustomAppBar({Key? key, required this.onMenuSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.purple),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 36,
          ),
          SizedBox(width: 8),
          Text(
            'Colposcope',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        _buildPopupMenu(onMenuSelected),
        _buildProfileMenu(onMenuSelected),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget _buildPopupMenu(Function(String) onMenuSelected) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.settings, color: Color(0xFF8B44F7)),
      offset: Offset(0, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      shadowColor: Color(0xFF8B44F7),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'wifi',
          child: _buildPopupMenuItem(Icons.wifi, 'Wifi'),
        ),
        PopupMenuItem<String>(
          value: 'microphone',
          child: _buildPopupMenuItem(Icons.mic, 'Microphone'),
        ),
        PopupMenuItem<String>(
          value: 'bluetooth',
          child: _buildPopupMenuItem(Icons.bluetooth, 'Bluetooth'),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: _buildPopupMenuItem(Icons.logout, 'Logout'),
        ),
      ],
      onSelected: onMenuSelected,
    );
  }

  Widget _buildProfileMenu(Function(String) onMenuSelected) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.person_outline, color: Color(0xFF8B44F7)),
      offset: Offset(0, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      shadowColor: Color(0xFF8B44F7),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'profile',
          child: _buildPopupMenuItem(Icons.person_outline, 'Profile'),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          child: _buildPopupMenuItem(Icons.settings_outlined, 'Settings'),
        ),
        PopupMenuItem<String>(
          value: 'support',
          child: _buildPopupMenuItem(Icons.help_outline, 'Customer support'),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: _buildPopupMenuItem(Icons.logout, 'Logout'),
        ),
      ],
      onSelected: onMenuSelected,
    );
  }

  Widget _buildPopupMenuItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}