
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/exerciseLog_binding.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/exerciseLog_view.dart';
import 'package:bandapp/screen/UserData/emailScreen/emailScreen_binding.dart';
import 'package:bandapp/screen/UserData/emailScreen/emailScreen_view.dart';
import 'package:bandapp/screen/UserData/nameScreen/nameScreen_binding.dart';
import 'package:bandapp/screen/UserData/nameScreen/nameScreen_view.dart';
import 'package:bandapp/screen/DashboardScreens/bottomBarScreen/bottomBar_binding.dart';
import 'package:bandapp/screen/DashboardScreens/bottomBarScreen/bottomBar_view.dart';
import 'package:bandapp/screen/login/login_binding.dart';
import 'package:bandapp/screen/login/login_view.dart';
import 'package:bandapp/screen/selectdayandTraining/selectTrainingDay/selectDayScreen_binding.dart';
import 'package:bandapp/screen/selectdayandTraining/selectTrainingDay/selectDayScreen_view.dart';
import 'package:bandapp/screen/selectdayandTraining/trainingExplanation/trainingScreen_binding.dart';
import 'package:bandapp/screen/selectdayandTraining/trainingExplanation/trainingScreen_view.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/trainingIntroVideo/trainingIntro_binding.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/trainingIntroVideo/trainingIntro_view.dart';
import 'package:bandapp/screen/splash/splash.dart';
import 'package:bandapp/screen/splash/splash_binding.dart';
import 'package:bandapp/screen/walkthroughScreen/walkThrough.dart';
import 'package:bandapp/screen/walkthroughScreen/walkThrough_binding.dart';
import 'package:bandapp/screen/welcomeScreen/welcomeScreen_binding.dart';
import 'package:bandapp/screen/welcomeScreen/welcomeScreen_view.dart';
import 'package:get/route_manager.dart';

part 'app_routes.dart';

/// Contains the list of pages or routes taken across the whole application.
/// This will prevent us in using context for navigation. And also providing
/// the blocs required in the next named routes.
///
/// [pages] : will contain all the pages in the application as a route
/// and will be used in the material app.
/// Will be ignored for test since all are static values and would not change.
class AppPages {
  static var transitionDuration = const Duration(
    milliseconds: 250,
  );
  static const initial = Routes.splash;

  static final pages = [
    GetPage<dynamic>(
      name: _Paths.splash,
      transitionDuration: transitionDuration,
      page: SplashView.new,
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.walkThrough,
      transitionDuration: transitionDuration,
      page: WalkThroughView.new,
      binding: WalkThroughBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.login,
      transitionDuration: transitionDuration,
      page: LoginView.new,
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.nameView,
      transitionDuration: transitionDuration,
      page: NameScreenView.new,
      binding: NameScreenBinding(),
      transition: Transition.fadeIn,
    ),
GetPage<dynamic>(
      name: _Paths.emailView,
      transitionDuration: transitionDuration,
      page: EmailScreenView.new,
      binding: EmailScreenBinding(),
      transition: Transition.fadeIn,
    ), 
    GetPage<dynamic>(
      name: _Paths.welcomeView,
      transitionDuration: transitionDuration,
      page: WelcomeScreenView.new,
      binding: WelcomeBinding(),
      transition: Transition.fadeIn,
    ), 
    GetPage<dynamic>(
      name: _Paths.trainingExplain,
      transitionDuration: transitionDuration,
      page: TrainingScreenView.new,
      binding: TrainingBinding(),
      transition: Transition.fadeIn,
    ), 
   
    GetPage<dynamic>(
      name: _Paths.exerciseDaySelect,
      transitionDuration: transitionDuration,
      page: SelectDayScreenView.new,
      binding: SelectDayScreenBinding(),
      transition: Transition.fadeIn,
    ), 
    
   
    GetPage<dynamic>(
      
      name: _Paths.trainIntroVideo,
      transitionDuration: transitionDuration,
      page: TrainIntroView.new,
      binding: TrainIntroBinding(),
      transition: Transition.fadeIn,
    ), 
    GetPage<dynamic>(
      name: _Paths.bottomBar,
      transitionDuration: transitionDuration,
      page: BottomBarView.new,
      binding: BottomBarBinding(),
      transition: Transition.fadeIn,
    ), 
     GetPage<dynamic>(
      name: _Paths.sessionPrepare,
      transitionDuration: transitionDuration,
      page: ExerciseLogBandView.new,
      binding: ExerciseLogBinding(),
      transition: Transition.fadeIn,
    ), 
   

    
  ];
  
}
