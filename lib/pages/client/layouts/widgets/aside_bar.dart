import 'package:flutter/material.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/pages/client/home/home.dart';
import 'package:wave_odc/services/auth_service.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class AsideBar extends StatelessWidget {
  final User user;
  AsideBar({super.key, required this.user});
  final authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    String userName = user.name;
    String userRole = user.role;

    return Drawer(
      child: Container(
        color: AppColors.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppColors.primaryColor, size: 40),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userRole.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, Icons.dashboard_outlined, 'Tableau de bord', () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            }),
            _buildDrawerItem(context, Icons.swap_horiz_outlined, 'Transactions', () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.receipt_outlined, 'Factures', () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.account_balance_outlined, 'Banque', () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.card_giftcard_outlined, 'Cadeaux', () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.people_outline, 'Contacts', () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.settings_outlined, 'Paramètres', () {
              Navigator.pop(context);
            }),
            const Divider(color: Colors.grey),
            _buildDrawerItem(
              context,
              Icons.exit_to_app,
              'Déconnexion',
                  () async {
                if (context.mounted) {
                  await authService.logout(callback: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                          (route) => false,
                    );
                  }, removeUser: true);
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.secondaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
