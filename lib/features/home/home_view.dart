import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_train/core/model/work_model.dart';

import '../../core/state/app_state.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final work = ref.watch(workState).work;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      body: work != null
          ? ListView.builder(
              itemCount: work.length,
              itemBuilder: (context, index) {
                return Text(work[index].dayOfTime.toString());
              },
            )
          : const Text('Eklenmiş Veri Yok'),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          ref.watch(workState).addWorkData(
              items: WorkModel(
                  id: 1,
                  machinistOne: 'Samet ATEŞ',
                  machinistTwo: 'Turan YILDIRIM',
                  trainNumber: 23250,
                  startTime: '17:50',
                  finishTime: '23:45',
                  exitStation: 'Kayseri',
                  arrivalStation: 'Yerköy',
                  dayOfTime: DateTime.now(),
                  offDay: false,
                  weekOfDay: false,
                  machinistOneNumber: 98765,
                  machinistTwoNumber: 98764));
        },
      ),
    );
  }
}
