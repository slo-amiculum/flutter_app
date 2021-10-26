import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/user.dart';
import '../providers/documents.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_profile_home.dart';
import '../widgets/documents_grid.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Documents>(context).fetchAndSetFiles().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<User>(context).fetchUser();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        // title: const Text('My Dashboard'),
        // actions: <Widget>[
        //   PopupMenuButton(
        //     onSelected: (FilterOptions selectedValue) {
        //       setState(() {
        //         if (selectedValue == FilterOptions.Favorites) {
        //           _showOnlyFavorites = true;
        //         } else {
        //           _showOnlyFavorites = false;
        //         }
        //       });
        //     },
        //     icon: Icon(
        //       Icons.more_vert,
        //     ),
        //     itemBuilder: (_) => [
        //       PopupMenuItem(
        //         child: Text('Only Favorites'),
        //         value: FilterOptions.Favorites,
        //       ),
        //       PopupMenuItem(
        //         child: Text('Show All'),
        //         value: FilterOptions.All,
        //       ),
        //     ],
        //   ),
        //   Consumer<Cart>(
        //     builder: (_, cart, ch) => Badge(
        //       child: ch!,
        //       value: cart.itemCount.toString(),
        //     ),
        //     child: IconButton(
        //       icon: Icon(
        //         Icons.shopping_cart,
        //       ),
        //       onPressed: () {
        //         Navigator.of(context).pushNamed(CartScreen.routeName);
        //       },
        //     ),
        //   ),
        // ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          // : DocumentsGrid(_showOnlyFavorites),
          : Column(
              children: <Widget>[
                UserProfileHome(),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'What\'s New',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: DocumentsGrid(_showOnlyFavorites),
                  ),
                ),
              ],
            ),
    );
  }
}
