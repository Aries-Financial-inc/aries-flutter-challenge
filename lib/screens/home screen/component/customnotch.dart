import '../../../linker.dart';

class RoundedRectangularNotch extends NotchedShape {
  final double notchRadius;

  RoundedRectangularNotch(this.notchRadius);

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final Path path = Path()
      ..moveTo(host.left, host.top)
      ..lineTo(guest.left - notchRadius, host.top)
      ..arcToPoint(
        Offset(guest.left, host.top + notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(guest.left, guest.bottom - notchRadius)
      ..arcToPoint(
        Offset(guest.left + notchRadius, guest.bottom),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(guest.right - notchRadius, guest.bottom)
      ..arcToPoint(
        Offset(guest.right, guest.bottom - notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(guest.right, host.top + notchRadius)
      ..arcToPoint(
        Offset(guest.right + notchRadius, host.top),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();

    return path;
  }
}

//
class CustomButtomNav extends StatefulWidget {
  CustomButtomNav({
    super.key,
    this.onTap,
    this.currentIndex = 0,
  });
  void Function(int index)? onTap;
  // void Function()? action;
  int currentIndex = 0;

  @override
  State<CustomButtomNav> createState() => _CustomButtomNavState();
}

class _CustomButtomNavState extends State<CustomButtomNav>
    with SingleTickerProviderStateMixin {
  bool _isClicked = false;
  double size = 40;
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  int oldindex = 0;
  void _onFabClicked() {
    setState(() {
      _isClicked = !_isClicked;
      if (_isClicked) {
        _animationController.forward();
        oldindex = widget.currentIndex;
        widget.onTap!(2);
      } else {
        widget.onTap!(oldindex);
        // widget.action;
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (!_isClicked)
            Container(
              // alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTab(
                    onTap: () => widget.onTap!(0),
                    icon: AppIcons.home,
                    size: 30,
                    isSelected: widget.currentIndex == 0,
                  ),
                  120.width,
                  CustomTab(
                    onTap: () => widget.onTap!(1),
                    icon: AppIcons.profile,
                    isSelected: widget.currentIndex == 1,
                    size: 30,
                  ),
                ],
              ),
            ),
          Align(
            alignment: const Alignment(0.0, -4),
            child: SizedBox(
              height: 55,
              width: 55,
              child: FloatingActionButton(
                onPressed: _onFabClicked,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: appButtonBackgroundColorGlobal,
                  progress: _animation,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  CustomTab(
      {super.key,
      this.onTap,
      required this.icon,
      this.size = 25,
      this.isSelected = false});

  AppIconData? icon;
  void Function()? onTap;
  bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppIcon(
        icon,
        color: isSelected ? appButtonBackgroundColorGlobal : unSelectedColor,
        size: size,
      ),
    );
  }
}
