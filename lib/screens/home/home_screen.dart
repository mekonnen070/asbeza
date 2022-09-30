// ignore_for_file: must_be_immutable

import 'package:asbeza_app/helpers/quick_help.dart';
import 'package:asbeza_app/models/product.dart';
import 'package:asbeza_app/models/sub_category.dart';
import 'package:asbeza_app/screens/home/components/category_list.dart';
import 'package:asbeza_app/screens/home/components/itemCard.dart';
import 'package:asbeza_app/widgets/filter_sort_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final Function(String catId, List<SubCategory> subCats) onChangeCategory;
  final Function(Sort sort) onSort;
  final Function(String subCatId) onFilter;
  final Function(String value) onSearch;
  final Function() onClear;
  final String selectedCategoryId;
  final List<String> selectedFilters;
  final List<SubCategory> subCategories;
  final Sort? selectedSort;
  List<Product> product;
  final bool loading;

  HomeScreen({
    Key? key,
    required this.onChangeCategory,
    required this.onSort,
    required this.onFilter,
    required this.onSearch,
    required this.onClear,
    required this.selectedCategoryId,
    required this.selectedFilters,
    required this.subCategories,
    this.selectedSort,
    required this.product,
    required this.loading,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFetched = false;

  List<Product> fdp = [];

  dynamic result;

  void onSearch(String value) {
    fdp = widget.product;
    if (value != "") {
      List<Product> searchProducts = widget.product
          .where(
              (prod) => prod.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      setState(() {
        widget.product = searchProducts;
      });
    } else {
      setState(() {
        widget.product = fdp;
      });
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuickHelp.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/search.svg"),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: controller,
                            onChanged: (value) {
                              onSearch(value);
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return FilterSortScreen(
                        selectedSort: widget.selectedSort,
                        subCategories: widget.subCategories,
                        onClear: widget.onClear,
                        selectedFilters: widget.selectedFilters,
                        onSort: widget.onSort,
                        onFilter: widget.onFilter,
                      );
                    }),
                  ),
                  child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.grey.shade200, width: 1)),
                      child: SvgPicture.asset(
                        "assets/svg/filter.svg",
                        color: Colors.black,
                        width: 20,
                        height: 20,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 40,
              child: CategoryList(
                onChangeCategory: widget.onChangeCategory,
                selectedCategoryId: widget.selectedCategoryId,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.product.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ItemCard(
                      loading: widget.loading,
                      product: widget.product[index],
                      products: widget.product,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
