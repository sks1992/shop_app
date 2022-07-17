import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ui/screens/edit_product_screen.dart';

import '../../core/providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String price;

  const UserProductItem(
      {Key? key,
        required this.title,
        required this.imageUrl,
        required this.id,
        required this.description,
        required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);

    final scaffold = ScaffoldMessenger.of(context);

    return Material(
      elevation: 10,
      type: MaterialType.card,
      shadowColor: Colors.grey,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(price, style: const TextStyle(fontSize: 14)),
          ],
        ),
        subtitle: Text(description),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              // Text(price),
              IconButton(
                onPressed: () async {
                  try {
                    productsData.deleteProduct(id);
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text("Deleting Product Failed, $error"),
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                    rethrow;
                  }
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName,
                      arguments: id);
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
