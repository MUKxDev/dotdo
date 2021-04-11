// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:dotdo/core/router_constants.dart';

import 'package:dotdo/views/splash/splash_view.dart' as view0;
import 'package:dotdo/views/login/login_view.dart' as view1;
import 'package:dotdo/views/register/register_view.dart' as view2;
import 'package:dotdo/views/today/today_view.dart' as view3;
import 'package:dotdo/views/social/social_view.dart' as view4;
import 'package:dotdo/views/home/home_view.dart' as view5;
import 'package:dotdo/views/authpage/authpage_view.dart' as view6;
import 'package:dotdo/views/discover/discover_view.dart' as view7;
import 'package:dotdo/views/profile/profile_view.dart' as view8;
import 'package:dotdo/views/task_details/task_details_view.dart' as view9;
import 'package:dotdo/views/new_challange/new_challange_view.dart' as view10;
import 'package:dotdo/views/challange_details/challange_details_view.dart'
    as view11;
import 'package:dotdo/views/ctask_details/ctask_details_view.dart' as view12;

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
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view5.HomeView());
      case authpageViewRoute:
        return MaterialPageRoute(builder: (_) => view6.AuthpageView());
      case discoverViewRoute:
        return MaterialPageRoute(builder: (_) => view7.DiscoverView());
      case profileViewRoute:
        return MaterialPageRoute(builder: (_) => view8.ProfileView());
      case taskDetailsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view9.TaskDetailsView(
                  taskId: settings.arguments,
                ));
      case newChallangeViewRoute:
        return MaterialPageRoute(
            builder: (_) => view10.NewChallangeView(
                  challangeId: settings.arguments,
                ));
      case challangeDetailsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view11.ChallangeDetailsView(
                  args: settings.arguments,
                ));
      case ctaskDetailsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view12.CtaskDetailsView(
                  args: settings.arguments,
                ));
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
