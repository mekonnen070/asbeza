import 'package:asbeza_app/screens/profilePage/profileHome.dart';
import 'package:flutter/material.dart';

const KappBarColor = Color(0xFF242F3D);
const KbodyColor = Color(0xFF0E1621);
const KmenuColor = Color(0xFF17212B);

class PersistentTabsWidget extends StatefulWidget {
  const PersistentTabsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PersistentTabsWidgetState createState() => _PersistentTabsWidgetState();
}

class _PersistentTabsWidgetState extends State<PersistentTabsWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> tabs = [
    const Tab(text: 'Media'),
    const Tab(text: 'Links'),
    const Tab(text: 'Voice'),
    const Tab(text: 'GIFs'),
    const Tab(text: 'Groups'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      // toolbarHeight: 25,
      flexibleSpace: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: KmenuColor,
            padding: const EdgeInsets.symmetric(horizontal: leftPadding),
            child: TabBar(
              controller: tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              indicatorColor: Colors.lightBlue,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.lightBlue,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: tabs,
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.8,
            height: 1,
          ),
        ],
      ),
    );
  }
}
