import 'package:flutter/material.dart';
import 'package:flutter_security_checker/flutter_security_checker.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool _isChecking = false;

  bool _isRooted;
  bool _isRealDevice;
  bool _hasCorrectlyInstalled;

  void _onCheckButtonPressed() async {
    setState(() => _isChecking = true);

    _isRooted = await FlutterSecurityChecker.isRooted;
    _isRealDevice = await FlutterSecurityChecker.isRealDevice;
    _hasCorrectlyInstalled = await FlutterSecurityChecker.hasCorrectlyInstalled;

    setState(() => _isChecking = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Security Checker'),
          centerTitle: true
        ),
        body: _buildContentView()
      ),
    );
  }

  Widget _buildContentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _buildResultTable()),
        _buildCheckButton()
      ],
    );
  }

  Widget _buildResultTable() {
    final cellsBuilder = (String method, bool result, [bool negative = false]) {
      final resultStyle = (result != null) ? TextStyle(
        color: result
            ? negative ? Colors.red : Colors.blue
            : negative ? Colors.blue : Colors.red
      ) : TextStyle();

      return [
        DataCell(Text(method)),
        DataCell(Text(result.toString(), style: resultStyle))
      ];
    };

    return DataTable(
      columns: [
        DataColumn(label: Text('method')),
        DataColumn(label: Text('result'))
      ],
      rows: [
        DataRow(cells: cellsBuilder('isRooted', _isRooted, true)),
        DataRow(cells: cellsBuilder('isRealDevice', _isRealDevice)),
        DataRow(cells: cellsBuilder('hasCorrectlyInstalled', _hasCorrectlyInstalled))
      ],
    );
  }

  Widget _buildCheckButton() {
    final child = _isChecking ? ConstrainedBox(
      constraints: BoxConstraints.tight(Size.square(15.0)),
      child: const CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
      )
    ) : Text('CHECK');

    return SizedBox(
      height: 58.0,
      child: ElevatedButton(
        child: child,
        onPressed: _onCheckButtonPressed
      ),
    );
  }
}
