import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_route.dart';

class SharedPreferenceExample extends MyRoute {
  const SharedPreferenceExample(
      [String sourceFile = 'lib/routes/persistence_preference_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Shared preference';

  @override
  get description => 'Key-value pairs stored locally using shared_preference.';

  @override
  get links => {
        'Cookbook': 'https://flutter.io/docs/cookbook/persistence/key-value',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: _PreferenceDemo(),
      ),
    );
  }
}

class _PreferenceDemo extends StatefulWidget {
  @override
  _PreferenceDemoState createState() {
    return new _PreferenceDemoState();
  }
}

class _PreferenceDemoState extends State<_PreferenceDemo> {
  static const String kDemoNumberPrefKey = 'demo_number_pref';
  static const String kDemoBooleanPrefKey = 'demo_boolean_pref';
  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    _loadNumberPref();
    _loadBooleanPref();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Text('Number preference:'),
            Text('${this._numberPref}'),
            RaisedButton(
              child: Text('Increment'),
              onPressed: () => this._setNumberPref(this._numberPref + 1),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Text('Boolean preference:'),
            Text('${this._boolPref}'),
            RaisedButton(
              child: Text('Toggle'),
              onPressed: () => this._setBooleanPref(!this._boolPref),
            ),
          ],
        ),
      ],
    );
  }

  // Loads number preference into this._numberPref.
  Future<Null> _loadNumberPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      this._numberPref = prefs.getInt(kDemoNumberPrefKey) ?? 0;
    });
  }

  // Loads boolean preference into this._numberPref.
  Future<Null> _loadBooleanPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      this._boolPref = prefs.getBool(kDemoBooleanPrefKey) ?? false;
    });
  }

  Future<Null> _setNumberPref(int val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kDemoNumberPrefKey, val);
    await _loadNumberPref();
  }

  Future<Null> _setBooleanPref(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kDemoBooleanPrefKey, val);
    await _loadBooleanPref();
  }
}
