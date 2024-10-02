part of '../setting_screen.dart';

enum _AccountMenuEnum { profile, address, favorite, changePassword, payment }

extension _AccountMenuEnumExtension on _AccountMenuEnum {
  String get title => switch (this) {
        _AccountMenuEnum.profile => "Profile",
        _AccountMenuEnum.address => "My Address",
        _AccountMenuEnum.favorite => "Favorites",
        _AccountMenuEnum.changePassword => "Change Password",
        _AccountMenuEnum.payment => "Payment Transactions",
      };

  IconData get icon => switch (this) {
        _AccountMenuEnum.profile => Icons.person,
        _AccountMenuEnum.address => Icons.location_on,
        _AccountMenuEnum.favorite => Icons.favorite,
        _AccountMenuEnum.changePassword => Icons.lock,
        _AccountMenuEnum.payment => Icons.payment,
      };
}

class SettingAccountMenuView extends StatelessWidget {
  const SettingAccountMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ACCOUNT",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) {
            _AccountMenuEnum menu = _AccountMenuEnum.values.elementAt(index);

            return ListTile(
              leading: Icon(
                menu.icon,
                color: Colors.grey.shade700,
                size: 18,
              ),
              contentPadding: const EdgeInsets.only(left: 5),
              title: Text(
                menu.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade700,
                size: 18,
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(height: 0, color: Colors.grey.shade300),
          itemCount: _AccountMenuEnum.values.length,
        ),
      ],
    );
  }
}
