import 'dart:io';
import 'package:flutter/material.dart';
import 'package:likhith_s_application2/presentation/go_for_it_page/go_for_it_page.dart';
import 'package:likhith_s_application2/presentation/no_go_page/no_go_page.dart';

class ProductResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> matchedProducts;
  final String imagePath;

  ProductResultsScreen(
      {required this.matchedProducts, required this.imagePath});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Results'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: matchedProducts.length,
              itemBuilder: (context, index) {
                var product = matchedProducts[index];
                print(product['Name']);
                return InkWell(
                  onTap: () {
                    // Use Navigator.pushNamed to navigate
                    if (product['Name'] == "Amul" ||
                        product['Name'] == "Pringles" ||
                        product['Name'] == "Parle")
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GoForItPage(productName: product['Name']),
                          ));
                    else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoGoPage(productName: product['Name']),
                          ));
                  },
                  child: Card(
                    child: ListTile(
                      leading: product['Image'] != null
                          ? Image.network(product['Image'],
                              width: 100, height: 100, fit: BoxFit.cover)
                          : null,
                      title: Text(product['Name'] ?? 'No name'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Category: ${product['Category'] ?? 'No category'}"),
                          Text(
                              "Harmful Ingredients: ${product['Harmful Ingredients'] ?? 'None listed'}"),
                          Text(
                              "Health Risks: ${product['Health Risks '] ?? 'No known risks'}"),
                        ],
                      ),
                      isThreeLine:
                          true, // Allow for additional space for the subtitle
                    ),
                  ),
                );
              },
            ),
          ),
          // Display the image taken for reference
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 300,
            child: imagePath.isNotEmpty
                ? Image.file(File(imagePath), fit: BoxFit.cover)
                : Container(),
          ),
        ],
      ),
    );
  }
}
