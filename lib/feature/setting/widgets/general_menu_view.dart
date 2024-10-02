part of '../setting_screen.dart';

enum _GeneralMenuEnum { language, theme, secure }

extension _GeneralMenuEnumExtension on _GeneralMenuEnum {
  String get title => switch (this) {
        _GeneralMenuEnum.language => "Language",
        _GeneralMenuEnum.theme => "Theme",
        _GeneralMenuEnum.secure => "Security",
      };

  IconData get icon => switch (this) {
        _GeneralMenuEnum.language => Icons.translate,
        _GeneralMenuEnum.theme => Icons.color_lens,
        _GeneralMenuEnum.secure => Icons.security,
      };
}

class SettingGeneralMenuView extends StatelessWidget {
  const SettingGeneralMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GENERAL",
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
            _GeneralMenuEnum menu = _GeneralMenuEnum.values.elementAt(index);

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
              trailing: menu == _GeneralMenuEnum.theme
                  ? Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade700,
                      size: 18,
                    ),
            );
          },
          separatorBuilder: (_, __) => Divider(height: 0, color: Colors.grey.shade300),
          itemCount: _GeneralMenuEnum.values.length,
        ),
      ],
    );
  }
}
