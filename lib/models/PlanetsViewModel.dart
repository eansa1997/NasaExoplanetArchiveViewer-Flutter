import 'package:flutter_for_nasa/models/Planets.dart';
import 'package:flutter_for_nasa/views/PlanetsDataTableSource.dart';
import 'package:flutter_for_nasa/network/NasaNetwork.dart';
import 'package:mobx/mobx.dart';
part 'PlanetsViewModel.g.dart';

class PlanetsViewModel = PlanetsViewModelBase with _$PlanetsViewModel;

abstract class PlanetsViewModelBase with Store {
  @observable
  Planets planets;
  @observable
  bool isLoading = false;
  @observable
  bool hadError = false;
  String errorMessage = "";
  NasaNetwork _nasaNetwork;
  PlanetsDataTableSource tableSource;
  // ignore: non_constant_identifier_names
  PlanetsViewModelBase() {
    _nasaNetwork = NasaNetwork();
    planets = Planets();
  }

  @action
  Future<void> query(String url) async {
    isLoading = true;
    hadError = false;
    errorMessage = "";
    try {
      String response = await _nasaNetwork.getQuery(url);
      parseResponse(response);
    } catch (e) {
      hadError = true;
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  void parseResponse(String response) {
    planets.parseResponse(response);
    tableSource = PlanetsDataTableSource(planets.listOfPlanets);
  }
}
