import 'package:provider/provider.dart';
// import 'package:nb_utils/nb_utils.dart';
import '../../linker.dart';
import 'component/splashcom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      final optionsProvider =
          Provider.of<OptionsProvider>(context, listen: false);
      // Perform all the necessary functions like auth and update app and user config data from server if necessary
      //  CHECK ./navflow.yaml
      //
      optionsProvider.fetchContracts();
      const HomeScreen().launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extracted package
    return SplashComponent.fadeIn(
      childWidget: SizedBox(
        height: 200,
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset("assets/images/splash icon.jpg"))),
      ),
      duration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 1500),
      onAnimationEnd: () async => await init(),
      defaultNextScreen: () async {},
    );
  }
}
