import 'package:flutter/material.dart';
import 'package:flutter_for_nasa/models/Planets.dart';

class PlanetsDataTableSource extends DataTableSource {
  List<PlanetModel> _listOfPlanets;
  PlanetsDataTableSource(List<PlanetModel> list) {
    _listOfPlanets = list;
  }
  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: _listOfPlanets[index]
          .values
          .map(
            (e) => DataCell(
              SelectableText((e == "") ? "N/A" : e),
            ),
          )
          .toList(),
    );
  }

  @override
  int get rowCount => _listOfPlanets.length;
  @override
  int get selectedRowCount => 0;
  @override
  bool get isRowCountApproximate => false;
}
