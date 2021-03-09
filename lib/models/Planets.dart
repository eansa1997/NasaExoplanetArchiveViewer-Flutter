class Planets {
  List<PlanetModel> listOfPlanets;
  List<String> queryColumns;
  void parseResponse(String response) {
    //print("hello");
    List<String> lines = response.split("\n");
    queryColumns = lines[0].split(",");
    listOfPlanets = List<PlanetModel>.empty(growable: true);
    int numOfCols = queryColumns.length;
    for (int i = 1; i < lines.length; i++) {
      PlanetModel planet = PlanetModel(lines[i], numOfCols);
      if (planet.isValidEntry) listOfPlanets.add(planet);
    }
  }
}

class PlanetModel {
  List<String> values;
  bool isValidEntry = true;
  PlanetModel(String columnValues, int numOfColumns) {
    values = columnValues.split(",");
    if (values.length != numOfColumns) isValidEntry = false;
  }
}
