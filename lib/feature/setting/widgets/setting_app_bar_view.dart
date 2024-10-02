part of '../setting_screen.dart';

class SettingAppBarView extends StatelessWidget {
  const SettingAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, UserModel?>(
      selector: (state) => state.user,
      builder: (context, user) {
        return Container(
          color: context.theme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: kToolbarHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/backgrounds/app-splash.png",
                    width: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          //
                        },
                        color: Colors.grey.shade200,
                        icon: const Icon(Icons.notifications),
                      ),
                      IconButton(
                        onPressed: () {
                          //
                        },
                        color: Colors.grey.shade200,
                        icon: const Icon(Icons.support_agent),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user?.firstName} ${user?.lastName}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${user?.email}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
