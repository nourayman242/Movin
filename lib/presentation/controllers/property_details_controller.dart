import 'package:flutter/material.dart';


class PropertyDetailsController extends ChangeNotifier {
late PageController pageController;
bool _isFavorite = false;
int _selectedTab = 0;


bool get isFavorite => _isFavorite;
int get selectedTab => _selectedTab;


void init() {
pageController = PageController();
}


void dispose() {
pageController.dispose();
super.dispose();
}


void toggleFavorite() {
_isFavorite = !_isFavorite;
notifyListeners();
}


void selectTab(int index) {
if (_selectedTab == index) return;
_selectedTab = index;
notifyListeners();
}
}