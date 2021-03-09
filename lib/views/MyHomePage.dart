import 'package:flutter/material.dart';
import 'package:flutter_for_nasa/locator.dart';
import 'package:flutter_for_nasa/models/NASATables.dart';
import 'package:flutter_for_nasa/models/PlanetsViewModel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PlanetsViewModel _planetsViewModel;
  NASATables _tables;
  String _sqlTerms = "";
  @override
  void initState() {
    super.initState();
    _planetsViewModel = locator<PlanetsViewModel>();
    _tables = locator<NASATables>();
  }

  var boxDecoration = BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(20));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(boxDecoration),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(widget.title),
            padding: EdgeInsets.all(12),
          ),
          Container(
            child: TableSelectorWidget(),
            padding: EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }

  Center buildBody(BoxDecoration boxDecoration) {
    return Center(
      child: Row(
        children: [
          tableSelectionTab(boxDecoration),
          queryResultsTab(boxDecoration),
        ],
      ),
    );
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(Icons.help),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "You can modify your query here, the only limitation is your SQL knowledge! :)\nSyntax examples can be found at the following link: ",
                      textAlign: TextAlign.center,
                    ),
                    content: InkWell(
                      child: Text(
                        "Link",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        launch("https://exoplanetarchive.ipac.caltech.edu/docs/program_interfaces.html#examples");
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1000),
              child: Container(
                padding: EdgeInsets.all(6),
                child: TextFormField(
                  onChanged: (String s) {
                    saveSearchTerm(s);
                  },
                  decoration: InputDecoration(
                    isDense: false,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              child: Icon(Icons.send),
              onTap: () async {
                try {
                  _planetsViewModel.query(buildQuery()); // UI state affects query to API, build then request
                } catch (e) {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Please select atleast one column!"),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Expanded queryResultsTab(BoxDecoration boxDecoration) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Observer(
          builder: (context) => (_planetsViewModel.isLoading)
              ? Center(child: CircularProgressIndicator())
              : (_planetsViewModel.hadError)
                  ? centeredErrorMessage()
                  : queryTable(),
        ),
      ),
    );
  }

  Expanded tableSelectionTab(BoxDecoration boxDecoration) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: boxDecoration,
          child: Observer(
            builder: (context) => Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text("Select columns in ${_tables.tableNames[_tables.selectedTable]} table: "),
                  ),
                ),
                Divider(),
                selectableColumnsListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectableColumnsListView() {
    Map tableMap;
    switch (_tables.selectedTable) {
      case 0:
        tableMap = _tables.exoplanets;
        break;
      case 1:
        tableMap = _tables.compositePars;
        break;
      default:
        tableMap = _tables.exoplanets;
        break;
    }
    return Flexible(
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: (tableMap.length),
        itemBuilder: (context, index) => CheckboxListTile(
          value: _tables.selectedColumnIsChecked[index],
          title: Text(tableMap[index]),
          onChanged: (bool selected) => {
            setState(() {
              if (selected) {
                _tables.selectedColumns.add(index);
                _tables.selectedColumnIsChecked[index] = true;
              } else {
                _tables.selectedColumns.remove(index);
                _tables.selectedColumnIsChecked[index] = false;
              }
            }),
          },
        ),
      ),
    );
  }

  Widget centeredErrorMessage() {
    return Center(
      child: Text(_planetsViewModel.errorMessage, textAlign: TextAlign.center),
    );
  }

  Widget queryTable() {
    return (_planetsViewModel.planets.queryColumns == null)
        ? Container(
            child: Center(
              child: Text("Have fun navigating the stars!... in a database."),
            ),
          )
        : Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: PaginatedDataTable(
                columns: _planetsViewModel.planets.queryColumns
                    .map(
                      (e) => DataColumn(
                        label: Text(e),
                      ),
                    )
                    .toList(),
                source: _planetsViewModel.tableSource,
                //rowsPerPage: 12,
              ),
            ),
          );
  }

  void saveSearchTerm(String s) async {
    _sqlTerms = s;
    print(_sqlTerms);
  }

  String buildQuery() {
    // build query URL based of search term and filter options here

    if (_tables.selectedColumns.length == 0) {
      throw Exception();
    }
    return _tables.generateQuery(_sqlTerms);
  }
}

class TableSelectorWidget extends StatefulWidget {
  TableSelectorWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<TableSelectorWidget> {
  String dropdownValue = 'exoplanet';
  NASATables _tables;
  @override
  void initState() {
    super.initState();
    _tables = locator<NASATables>();
  }

  void changeTable() {
    switch (dropdownValue) {
      case "exoplanet":
        _tables.changeTable(0);
        break;
      case "compositepars":
        _tables.changeTable(1);
        break;
      default:
        _tables.changeTable(0);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      //style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          changeTable();
        });
      },
      items: <String>[
        'exoplanet',
        'compositepars',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
