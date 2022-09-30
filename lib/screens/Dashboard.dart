import 'package:asbeza_app/app/colors.dart';
import 'package:asbeza_app/helpers/quick_help.dart';
import 'package:asbeza_app/models/category.dart';
import 'package:asbeza_app/models/product.dart';
import 'package:asbeza_app/models/sub_category.dart';
import 'package:asbeza_app/providers/counter_provider.dart';
import 'package:asbeza_app/screens/Bonus_screen.dart';
import 'package:asbeza_app/screens/history_screen.dart';
import 'package:asbeza_app/screens/home/home_screen.dart';
import 'package:asbeza_app/screens/profile_screen.dart';
import 'package:asbeza_app/services/category.dart';
import 'package:asbeza_app/services/product.dart';
import 'package:asbeza_app/widgets/components.dart';
import 'package:asbeza_app/widgets/filter_sort_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static int tabBonus = 2;
  static int tabHistory = 1;
  static int tabHome = 0;
  static int tabProfile = 3;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedCategoryId = "id_1";
  List<SubCategory> subCategories = [];
  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<String> selectedFilters = [];
  bool loading = false;
  Sort? selectedSort;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late ScrollController _scrollController;

  void onChangeCategory(String catId, List<SubCategory> subCats) async {
    setState(() {
      loading = true;
      selectedCategoryId = catId;
      subCategories = subCats;
    });
    getProducts(catId);
  }

  void getCategories() async {
    List<Category>? category = await CategoryService().categories();

    setState(() {
      selectedCategoryId = category![0].categoryId;
      subCategories = category[0].subCategories;
    });
  }

  void getProducts(String catId) async {
    List<Product>? prods = await ProductService.products(catId);
    if (prods != null) {
      setState(() {
        products = prods;
        filteredProducts = prods;
        loading = false;
      });
    }

    if (selectedSort != null) {
      onSort(selectedSort!);
    }
  }

  List<Product> getFilteredProducts(List<String> fils) {
    List<Product> filProducts = [];
    if (fils.isNotEmpty) {
      for (var fil in fils) {
        for (var prod in products) {
          if (fil == prod.subCategoryId) {
            filProducts = [...filProducts, prod];
          }
        }
      }
    } else {
      filProducts = products;
    }

    return filProducts;
  }

  void onFilter(String subCatId) {
    List<String> fils;
    if (selectedFilters.contains(subCatId)) {
      fils = selectedFilters.where((el) => el != subCatId).toList();
    } else {
      fils = [...selectedFilters, subCatId];
    }

    setState(() {
      selectedFilters = fils;
      filteredProducts = getFilteredProducts(fils);
    });

    if (selectedSort != null) {
      onSort(selectedSort!);
    }
  }

  void onSearch(String value) {
    if (value != "") {
      List<Product> searchProducts = products
          .where(
              (prod) => prod.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      setState(() {
        filteredProducts = searchProducts;
      });
    } else {
      setState(() {
        filteredProducts = products;
      });
    }
  }

  void onSort(Sort sort) {
    if (sort == Sort.discounts) {
      setState(() {
        filteredProducts.sort((a, b) => b.discount.compareTo(a.discount));
      });
    } else if (sort == Sort.bestSelling) {
      setState(() {
        filteredProducts.sort((a, b) => b.name.compareTo(a.name));
      });
    } else if (sort == Sort.priceLowToHigh) {
      setState(() {
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      });
    } else if (sort == Sort.priceHighToLow) {
      setState(() {
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      });
    }
    setState(() {
      selectedSort = sort;
    });
  }

  void onClear() {
    setState(() {
      filteredProducts = products;
      selectedFilters = [];
      selectedSort = null;
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    getCategories();
    getProducts(selectedCategoryId);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double iconSize = 28;

  BottomNavigationBar bottomNavBar(BuildContext context) {
    Color bgColor = QuickHelp.isDarkMode(context)
        ? kContentColorLightTheme
        : kContentColorDarkTheme;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: Component.buildNavIcon(
              SvgPicture.asset(
                'assets/svg/country.svg',
                height: iconSize,
                width: iconSize,
                color: context.watch<CountersProvider>().tabIndex ==
                        Dashboard.tabHome
                    ? kPrimaryColor
                    : kDisabledGrayColor,
              ),
              Dashboard.tabHome,
              context),
          label: "Home",
        ),
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: Component.buildNavIcon(
            SvgPicture.asset(
              'assets/svg/history.svg',
              height: iconSize,
              width: iconSize,
              color: context.watch<CountersProvider>().tabIndex ==
                      Dashboard.tabHistory
                  ? kPrimaryColor
                  : kDisabledGrayColor,
            ),
            Dashboard.tabHistory,
            context,
            color: kWelcomeColorUp,
          ),
          label: "History",
        ),
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: Component.buildNavIcon(
            SvgPicture.asset(
              'assets/svg/config.svg',
              height: 45,
              width: 45,
              color: context.watch<CountersProvider>().tabIndex ==
                      Dashboard.tabBonus
                  ? kPrimaryColor
                  : kDisabledGrayColor,
            ),
            Dashboard.tabBonus,
            context,
          ),
          label: "Bonus",
        ),
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: Component.buildNavIcon(
              SvgPicture.asset(
                'assets/svg/profile_active.svg',
                height: iconSize,
                width: iconSize,
                color: context.watch<CountersProvider>().tabIndex ==
                        Dashboard.tabProfile
                    ? kPrimaryColor
                    : kDisabledGrayColor,
              ),
              Dashboard.tabProfile,
              context),
          label: "Profile",
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: context.watch<CountersProvider>().tabIndex,
      selectedItemColor: kPrimaryColor,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      onTap: (index) => _onItemTapped(index),
    );
  }

  void _onItemTapped(int index) {
    context.read<CountersProvider>().setTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomeScreen(
        selectedCategoryId: selectedCategoryId,
        subCategories: subCategories,
        onSort: onSort,
        onClear: onClear,
        onFilter: onFilter,
        onSearch: onSearch,
        selectedFilters: selectedFilters,
        selectedSort: selectedSort,
        onChangeCategory: onChangeCategory,
        loading: loading,
        product: products,
      ),
      const HistoryScreen(),
      const BonusScreen(),
      const ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (context.watch<CountersProvider>().tabIndex != 0) {
          setState(() {
            context.watch<CountersProvider>().setTabIndex(0);
          });
          return false;
        } else {
          QuickHelp.appExitDialog(context);
        }
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        body:
            widgetOptions.elementAt(context.watch<CountersProvider>().tabIndex),
        bottomNavigationBar: bottomNavBar(context),
      )),
    );
  }
}
