part of '../login_screen.dart';

enum LoginAuthType { member, facebook, google, apple }

class LoginAuthSelectionView extends StatelessWidget {
  const LoginAuthSelectionView({super.key, required this.onSelectAuthDirection});

  final void Function(LoginAuthType) onSelectAuthDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Welcome to ShopMe",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 2),
        FittedBox(
          child: Text(
            "Discovery amazing thing near around You",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () => onSelectAuthDirection.call(LoginAuthType.member),
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll<Size>(
              Size(context.deviceSize.width - 60 - 40, 45),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll<Color>(context.theme.primaryColor),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () => context.goNamed(RouteName.register.name),
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll<Size>(
              Size(context.deviceSize.width - 60 - 40, 45),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(width: 2, color: context.theme.primaryColor),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Stack(
          alignment: Alignment.center,
          children: [
            const Divider(thickness: 1.2),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Or connect using',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          width: context.deviceSize.width,
          height: 35,
          alignment: Alignment.center,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                onSelectAuthDirection.call(LoginAuthType.values.elementAt(i + 1));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.5),
                child: Image.asset(
                  "assets/images/icons/${_socialImages.elementAt(i)}_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemCount: _socialImages.length,
          ),
        ),
      ],
    );
  }
}
