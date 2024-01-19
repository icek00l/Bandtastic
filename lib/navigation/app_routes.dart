// coverage:ignore-file
part of 'app_pages.dart';

/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
abstract class Routes {
  static const splash = _Paths.splash;
  static const walkThrough = _Paths.walkThrough;
  static const login = _Paths.login;
  static const nameView = _Paths.nameView;
  static const emailView = _Paths.emailView;
  static const welcomeView = _Paths.welcomeView;
  static const trainingExplain = _Paths.trainingExplain;
  static const trainingTwoThree = _Paths.trainingTwoThree;
  static const restWeekScreen = _Paths.restWeekScreen;
  static const trainIntroVideo = _Paths.trainIntroVideo;
  static const bottomBar = _Paths.bottomBar;
  static const sessionPrepare = _Paths.sessionPrepare;
  
}

abstract class _Paths {
  static const splash = '/splash';
  static const walkThrough = '/walkThrough';
  static const login = '/login';
  static const nameView = '/nameView';
  static const emailView = '/emailView';
  static const welcomeView = '/welcomeView';
  static const trainingExplain = '/trainingExplain';
  static const trainingTwoThree = '/trainingTwoThree';
  static const restWeekScreen = '/restWeekScreen';
  static const trainIntroVideo = '/trainIntroVideo';
  static const bottomBar = '/bottomBar';
  static const sessionPrepare = '/sessionPrepare';
  
}
