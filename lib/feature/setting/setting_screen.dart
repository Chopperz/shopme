import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme/core/extensions/extensions.dart';
import 'package:shopme/core/models/models.dart';
import 'package:shopme/core/providers/user_bloc/user_bloc.dart';

part 'widgets/general_menu_view.dart';

part 'widgets/account_menu_view.dart';

part 'widgets/setting_app_bar_view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingAppBarView(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                const SettingAccountMenuView(),
                const SizedBox(height: 15),
                const SettingGeneralMenuView(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(const UserLogoutEvent());
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll<Size>(
                      Size(context.deviceSize.width, 45),
                    ),
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.redAccent),
                    shape: WidgetStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.logout, color: Colors.grey.shade200),
                      const SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
