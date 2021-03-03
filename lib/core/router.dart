// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:dotdo/core/router_constants.dart';

import 'package:dotdo/views/splash/splash_view.dart' as view0;
import 'package:dotdo/views/login/login_view.dart' as view1;
import 'package:dotdo/views/register/register_view.dart' as view2;
import 'package:dotdo/views/today/today_view.dart' as view3;
import 'package:dotdo/views/social/social_view.dart' as view4;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => view1.LoginView());
      case registerViewRoute:
        return MaterialPageRoute(builder: (_) => view2.RegisterView());
      case todayViewRoute:
        return MaterialPageRoute(builder: (_) => view3.TodayView());
      case socialViewRoute:
        return MaterialPageRoute(builder: (_) => view4.SocialView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}