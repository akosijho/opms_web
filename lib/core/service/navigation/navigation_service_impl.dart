import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_service.dart';

class NavigationServiceImpl extends NavigationService {
  @override
  GlobalKey<NavigatorState> get navigatorKey => Get.key;

  //  Pushes [routeName] onto the navigation stack
  @override
  Future? pushNamed(String routeName, {dynamic arguments}) {
    return Get.toNamed(routeName, arguments: arguments);
  }

  // Replaces the current route with the [routeName]
  @override
  Future? pushReplacementNamed(String routeName, {dynamic arguments}) {
    return Get.offNamed(routeName, arguments: arguments);
  }

  // Clears the entire back stack and shows [routeName]
  @override
  Future? popAllAndPushNamed(String routeName, {dynamic arguments}) {
    return Get.offAllNamed(routeName, arguments: arguments);
  }

  // Pops the navigation stack until there's 1 view left
  // then pushes [routeName] onto the stack
  @override
  Future? popUntilFirstAndPushNamed(String routeName, {dynamic arguments}) {
    _clearBackstackTillFirst();
    return pushNamed(routeName, arguments: arguments);
  }

  // Push route and clear stack until predicate is satisfied
  @override
  Future? pushNamedAndRemoveUntil(String routeName,
      {required RoutePredicate predicate, arguments, int? id}) {
    return Get.offAllNamed(routeName,
        predicate: predicate, arguments: arguments, id: id);
  }

  // Pops the back stack to a route name
  @override
  void popUntilNamed(String routeName) {
    Get.until(ModalRoute.withName(routeName));
  }

  // Pops the back stack until the predicate is satisfied
  @override
  void popUntilPredicate(RoutePredicate routePredicate) {
    Get.until(routePredicate);
  }

  // Pops the back stack the number of times you indicate with [popTimes]
  @override
  void popRepeated(int times, {int? id}) {
    Get.close(times, id);
  }

  // Pops the current scope and indicates if you can pop again
  @override
  bool pop({dynamic returnValue, int? id}) {
    Get.back(result: returnValue, id: id);
    return Get.key.currentState?.canPop() ?? false;
  }

  void _clearBackstackTillFirst() {
    Get.until((Route route) => route.isFirst);
  }

  @override
  void closeOverlay() {
    if (!Get.isOverlaysClosed) {
      Navigator.pop(Get.overlayContext!);
    }
  }
}
