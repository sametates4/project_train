import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_train/core/function/app_function.dart';
import 'package:project_train/core/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/model/work_model.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List<WorkModel> employees = <WorkModel>[];
  late DataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = Provider.of<AppState>(context, listen: false).work ?? [];
    employeeDataSource = DataSource(workData: employees);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table View')),
      body: SfDataGrid(
        source: employeeDataSource,
        allowColumnsDragging: true,
        allowColumnsResizing: true,
        allowMultiColumnSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
            width: 250,
              columnName: 'machinist',
              label: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Makinist',
                  ))),
          GridColumn(
              columnName: 'trainNumber',
              label:
                  Container(alignment: Alignment.center, child: Text('Giden'))),
          GridColumn(
              columnName: 'trainNumberTwo',
              label: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Gelen',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'startTime',
              label: Container(
                  alignment: Alignment.center, child: Text('İşe Başlama'))),
          GridColumn(
              columnName: 'endTime',
              label: Container(
                  alignment: Alignment.center, child: Text('İş Bitiş'))),
          GridColumn(
              columnName: 'activeWorking',
              label: Container(
                  alignment: Alignment.center, child: Text('Fiili Çalışma'))),
        ],
      ),
    );
  }
}

class DataSource extends DataGridSource {
  DataSource({required List<WorkModel> workData}) {
    _workData = workData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'machinist', value: e.machinist),
              DataGridCell<int>(
                  columnName: 'trainNumber', value: e.trainNumber),
              DataGridCell<int>(
                  columnName: 'trainNumberTwo', value: e.trainNumberTwo),
              DataGridCell<String>(
                  columnName: 'startTime',
                  value: AppFunction.dateTimeFormat(e.startTime)),
              DataGridCell<String>(
                  columnName: 'endTime',
                  value: AppFunction.dateTimeFormat(e.endTime)),
              DataGridCell<String>(
                  columnName: 'activeWorking',
                  value: e.endTime != null ? AppFunction.timeFormat(
                      e.endTime!.difference(e.startTime)) : AppFunction.timeFormat(
                      DateTime.now().difference(e.startTime))
              )
            ]))
        .toList();
  }

  List<DataGridRow> _workData = [];

  @override
  List<DataGridRow> get rows => _workData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
