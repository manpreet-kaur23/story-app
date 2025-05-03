import 'package:bookpad/views/home/home_screen.dart';
import 'package:bookpad/views/home/search_screen.dart';
import 'package:bookpad/views/home/bookmark_screen.dart';
import 'package:bookpad/views/home/profile_screen.dart';
import 'package:bookpad/views/home/add_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> views = [HomeScreen(), SearchScreen(), AddScreen(), BookmarkScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){
              setState(() {
                _selectedIndex = 0;
              });
            }, icon: Icon(Icons.home_filled)),
            IconButton(onPressed: (){
              setState(() {
                _selectedIndex = 1;
              });
            }, icon: Icon(Icons.explore)),
            IconButton(onPressed: (){
              setState(() {
                _selectedIndex = 2;
              });
            }, icon: Icon(Icons.add)),
            IconButton(onPressed: (){
              setState(() {
                _selectedIndex = 3;
              });
            }, icon: Icon(Icons.menu_book)),
            IconButton(onPressed: (){
              setState(() {
                _selectedIndex = 4;
              });
            }, icon: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}
