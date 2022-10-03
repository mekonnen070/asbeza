import 'package:flutter/material.dart';

import 'components/custom_grid_widget.dart';
import 'components/notifications_widget.dart';
import 'components/profile_info_widget.dart';
import 'components/persistent_profile_header.dart';
import 'components/persistent_tabs_widget.dart';

const double leftPadding = 20.0;
const double initialScrollOffset = 250.0;
const double scrollDesiredPercent = 0.65;
const Duration duration = Duration(milliseconds: 100);

class ProfileHome extends StatefulWidget {
  const ProfileHome({Key? key}) : super(key: key);

  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: initialScrollOffset);

  void animateToMaxExtent() {
    scrollController.animateTo(
      50,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void animateToNormalExtent() {
    scrollController.animateTo(
      initialScrollOffset,
      duration: duration,
      curve: Curves.linear,
    );
  }

  bool get scrollStopped =>
      !scrollController.position.isScrollingNotifier.value;

  bool get mustExpand =>
      scrollController.offset < initialScrollOffset * scrollDesiredPercent;

  bool get mustRetract =>
      !mustExpand && scrollController.offset < initialScrollOffset;

  void _handleScrollingActivity() {
    if (scrollStopped) {
      if (mustRetract) {
        animateToNormalExtent();
      } else if (mustExpand) {
        animateToMaxExtent();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.position.isScrollingNotifier
          .addListener(_handleScrollingActivity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: PersistentProfileHeader(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ProfileInfoWidget(),
                Divider(
                  indent: leftPadding,
                  endIndent: leftPadding,
                  color: Colors.black,
                  thickness: 0.5,
                  height: 8,
                ),
                NotificationsWidget(),
                Divider()
              ],
            ),
          ),
          const PersistentTabsWidget(),
          const CustomGridWidget(),
          // TabBarSliverAppbar()
        ],
      ),
    );
  }
}

class TabBarSliverAppbar extends StatelessWidget {
  const TabBarSliverAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                const SliverAppBar(
                  // title: Text(MyApp.title),
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.map), text: 'Tab 1'),
                      Tab(icon: Icon(Icons.portrait), text: 'Tab 2'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                buildImages(),
                buildImages(),
              ],
            ),
          ),
        ),
      );

  Widget buildImages() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 20,
        itemBuilder: (context, index) => ImageWidget(index: index),
      );
}

class ImageWidget extends StatelessWidget {
  final int index;

  const ImageWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          child: Image.network(
            'https://source.unsplash.com/random?sig=$index',
            fit: BoxFit.cover,
          ),
        ),
      );
}
