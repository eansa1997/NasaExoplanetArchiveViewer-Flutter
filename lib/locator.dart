import 'package:flutter_for_nasa/models/NASATables.dart';
import 'package:flutter_for_nasa/models/PlanetsViewModel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<NASATables>(NASATables());
  locator.registerSingleton<PlanetsViewModel>(PlanetsViewModel());
}
