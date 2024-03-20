import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/ordersScreen.dart';
import '../screen/userProductsScreen.dart';

import '../providers/auth.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false, //뒤로가기 버튼 지우기
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () {
                //다음 페이지 이동이 아닌 현재 페이지 교체
                Navigator.of(context).pushReplacementNamed('/');
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Orders'),
              onTap: () {
                //다음 페이지 이동이 아닌 현재 페이지 교체
                Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
                /* Navigator.of(context).pushReplacement(
                  CustomRoute(
                    builder: (ctx) => const OrdersScreen(),
                  ),
                ); */
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Manage Products'),
              onTap: () {
                //다음 페이지 이동이 아닌 현재 페이지 교체
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
