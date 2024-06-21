import 'package:flutter_challenge/linker.dart';
import '../dashboard/dashboardscreen.dart';
import 'component/customnotch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        [
          const DashboardScreen(),
          const ProfileScreen(),
          OptionDetail()
        ][_currentIndex],
        CustomButtomNav(
          currentIndex: _currentIndex,
          // action: () => OptionDetail(
          //   isNav: true,
          // ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade),
          onTap: (index) {
            _onTabTapped(index);
          },
        )
      ],
    ));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
