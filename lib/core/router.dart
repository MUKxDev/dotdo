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
import 'package:dotdo/views/new_challenge/new_challenge_view.dart' as view10;
import 'package:dotdo/views/challenge_details/challenge_details_view.dart' as view11;
import 'package:dotdo/views/ctask_details/ctask_details_view.dart' as view12;
import 'package:dotdo/views/new_routine/new_routine_view.dart' as view13;
import 'package:dotdo/views/routine_details/routine_details_view.dart' as view14;
import 'package:dotdo/views/rtask_details/rtask_details_view.dart' as view15;
import 'package:dotdo/views/pvp_details/pvp_details_view.dart' as view16;
import 'package:dotdo/views/another_profile/another_profile_view.dart' as view17;
import 'package:dotdo/views/new_pvp_challange/new_pvp_challange_view.dart' as view18;
import 'package:dotdo/views/pvp_challenge_details/pvp_challenge_details_view.dart' as view19;
import 'package:dotdo/views/p_c_task_details/p_c_task_details_view.dart' as view20;
import 'package:dotdo/views/pvp_pending/pvp_pending_view.dart' as view21;
import 'package:dotdo/views/global_routine/global_routine_view.dart' as view22;
import 'package:dotdo/views/search/search_view.dart' as view23;
import 'package:dotdo/views/likes/likes_view.dart' as view24;
import 'package:dotdo/views/pvp_history/pvp_history_view.dart' as view25;
import 'package:dotdo/views/following/following_view.dart' as view26;
import 'package:dotdo/views/followers/followers_view.dart' as view27;

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
        return MaterialPageRoute(builder: (_) => view9.TaskDetailsView());
      case newChallengeViewRoute:
        return MaterialPageRoute(builder: (_) => view10.NewChallengeView());
      case challengeDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view11.ChallengeDetailsView());
      case ctaskDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view12.CtaskDetailsView());
      case newRoutineViewRoute:
        return MaterialPageRoute(builder: (_) => view13.NewRoutineView());
      case routineDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view14.RoutineDetailsView());
      case rtaskDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view15.RtaskDetailsView());
      case pvpDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view16.PvpDetailsView());
      case anotherProfileViewRoute:
        return MaterialPageRoute(builder: (_) => view17.AnotherProfileView());
      case newPvpChallangeViewRoute:
        return MaterialPageRoute(builder: (_) => view18.NewPvpChallangeView());
      case pvpChallengeDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view19.PvpChallengeDetailsView());
      case pCTaskDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view20.PCTaskDetailsView());
      case pvpPendingViewRoute:
        return MaterialPageRoute(builder: (_) => view21.PvpPendingView());
      case globalRoutineViewRoute:
        return MaterialPageRoute(builder: (_) => view22.GlobalRoutineView());
      case searchViewRoute:
        return MaterialPageRoute(builder: (_) => view23.SearchView());
      case likesViewRoute:
        return MaterialPageRoute(builder: (_) => view24.LikesView());
      case pvpHistoryViewRoute:
        return MaterialPageRoute(builder: (_) => view25.PvpHistoryView());
      case followingViewRoute:
        return MaterialPageRoute(builder: (_) => view26.FollowingView());
      case followersViewRoute:
        return MaterialPageRoute(builder: (_) => view27.FollowersView());
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