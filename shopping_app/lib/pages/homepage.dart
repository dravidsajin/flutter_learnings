import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/global_variables.dart';

import '../widgets/product_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late String chipSelected;

  @override
  void initState() {
    super.initState();
    chipSelected = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Shoes\nCollections',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: borderStyle,
                      focusedBorder: borderStyle,
                      enabledBorder: borderStyle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final currentFilter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          chipSelected = currentFilter;
                        });
                      },
                      child: Chip(
                        elevation: 1,
                        label: Text(
                          currentFilter,
                        ),
                        backgroundColor: chipSelected == currentFilter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        // onSelected: (_) {
                        //   //
                        // },
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return ProductCard(
                    title: item['title'] as String,
                    price: item['price'] as double,
                    imageUrl: item['imageUrl'] as String,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
