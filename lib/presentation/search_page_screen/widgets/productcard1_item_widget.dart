import 'package:flutter/material.dart';
import 'package:likhith_s_application2/core/app_export.dart';
import 'package:likhith_s_application2/models/product_model.dart';
class ProductCardItemWidget extends StatelessWidget {
  final Product product;

  ProductCardItemWidget({Key? key, required this.product}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () {
        // Navigate to the Products Page for the selected category
        Navigator.pushNamed(
          context,
          AppRoutes.goForItPage, // Ensure this route name is correct
          arguments: {'categoryName': product.category}, // Passing the selected category as an argument
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Display the product name
            Text(
              'Category: ' + product.category,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Name: '+product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Display the product price
            Text(
              'Harmful Ingridents: '+product.harmfulIngridents,
              style: const TextStyle(fontSize: 16,color:Colors.red),
            ),
            const SizedBox(height: 8),
            // Display the product weight
            Text(
              'Health Risks: '+product.healthRisks,
              style: const TextStyle(fontSize: 16,color: Colors.teal),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}

}