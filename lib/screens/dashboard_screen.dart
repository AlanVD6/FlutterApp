import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global_values.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(

    drawer: SidebarX(
    headerBuilder: (context, extended) {
    return const UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
      ),
      accountName: Text('Alansin'), 
      accountEmail: Text('Ghoul616@gmal.com')
    );
  },
  extendedTheme: const SidebarXTheme(
    width: 200
  ),
  controller: SidebarXController(selectedIndex: 0, extended: true),
  items: [
    SidebarXItem(
      onTap: (){ 
        Navigator.pop(context);
        Navigator.pushNamed(context, '/reto');
      },
      icon: Icons.shopping_bag, 
      label: 'Shop App'
    ),
    SidebarXItem(
      onTap: (){ 
        Navigator.pop(context);
        Navigator.pushNamed(context, '/contador');
      },
      icon: Icons.add, 
      label: 'Contador'
    ),
    SidebarXItem(
      onTap: (){ 
        Navigator.pop(context);
        Navigator.pushNamed(context, '/api');
      },
      icon: Icons.movie, 
      label: 'Popular Movies'
    ),
    SidebarXItem(
    icon: Icons.favorite,
    label: 'Favoritas',
    onTap: () {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/favorites');
  },
),
  ],
),


    appBar: AppBar(
      title: Text('panel de control'),
    ),
    body: HawkFabMenu(
      icon: AnimatedIcons.menu_arrow,
      body: Center(child: Text('excribe aqui :)'),
      ),
      items: [
        HawkFabMenuItem(
        label: 'Theme Light', 
        ontap: ()=> GlobalValues.themeMode.value = 1, 
        icon: const Icon(Icons.light_mode)
        ),
        HawkFabMenuItem(
        label: 'Theme Dark', 
        ontap: ()=> GlobalValues.themeMode.value = 0,
        icon: const Icon(Icons.dark_mode)
        ),
        HawkFabMenuItem(
        label: 'Theme Warm', 
        ontap: ()=> GlobalValues.themeMode.value = 2,
        icon: const Icon(Icons.hot_tub)
        )
      ],
    ),
    );

  }
}