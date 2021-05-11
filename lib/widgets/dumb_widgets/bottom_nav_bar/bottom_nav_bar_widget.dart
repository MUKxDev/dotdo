import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function onTap;
  final String userProfile;

  const BottomNavBarWidget(
      {Key key,
      @required this.currentIndex,
      @required this.onTap,
      @required this.userProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          currentIndex: currentIndex,
          onTap: (index) => onTap(index),
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black38
              : Colors.white38,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Social',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flash_on),
              label: 'Discover',
            ),
            // profile pic
            BottomNavigationBarItem(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  child: Image(
                    image: NetworkImage(userProfile),
                    fit: BoxFit.cover,
                  ),
                  width: 24,
                  height: 24,
                  decoration: this.currentIndex == 3
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
  }
}
