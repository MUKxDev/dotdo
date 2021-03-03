import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'bottom_nav_bar_view_model.dart';

class BottomNavBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavBarViewModel>.reactive(
      builder:
          (BuildContext context, BottomNavBarViewModel viewModel, Widget _) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 20,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: viewModel.selectedIndex,
              onTap: (index) => viewModel.updateSelectedNavbarItem(index),
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.black38
                      : Colors.white38,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.today),
                  label: 'Today',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Social',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.flash_on),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      child: Image(
                        image: AssetImage('assets/pp.png'),
                        fit: BoxFit.fill,
                      ),
                      width: 24,
                      height: 24,
                      decoration: viewModel.selectedIndex == 3
                          ? BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            )
                          : BoxDecoration(),
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => BottomNavBarViewModel(),
    );
  }
}
