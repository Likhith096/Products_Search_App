import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../search_page_screen/widgets/productcard1_item_widget.dart';
import 'package:likhith_s_application2/models/product_model.dart';

class SearchPageScreen extends StatefulWidget {
  SearchPageScreen({Key? key}) : super(key: key);

  @override
  _SearchPageScreenState createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (searchController.text.trim().isNotEmpty) {
      _searchProducts(searchController.text.trim());
    } else {
      setState(() => searchResults = []);
    }
  }

  Future<void> _searchProducts(String query) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('Name', isGreaterThanOrEqualTo: query)
        .where('Name', isLessThanOrEqualTo:query + '\uf8ff')
        .get();

        querySnapshot.docs.forEach((doc) {
        print(doc.data());
        });

        print('Number of documents found: ${querySnapshot.docs.length}');

    List<Product> products = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Product(
          id: doc.id,
          category: data['Category'] ?? '',
          name: data['Name'] ?? '',
          harmfulIngridents: data['Harmful Ingredients'] ?? '',
          healthRisks: data['Health Risks '] ?? '',
      );
    }).toList();

    setState(() {
      searchResults = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return ProductCardItemWidget(product: searchResults[index]);
                    },
                  )
                : Center(child: Text('No products found')),
          ),
        ],
      ),
    );
  }
}
