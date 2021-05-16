import 'package:flutter/material.dart';
import 'package:gk_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import './edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(
      context,
      listen: false,
    ).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  id: productsData.items[index].id,
                  title: productsData.items[index].title,
                  imageUrl: productsData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
