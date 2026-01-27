import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_1/data/transaction/repository/db_repo.dart';
import 'package:flutter_project_1/ui/graphs/graphs_viewmodel.dart';

class Graphs extends StatelessWidget {
  const Graphs({super.key});

  List<PieChartSectionData> displayExpenseIncomeRatio(
    double sendTotal,
    double receiveTotal,
  ) {
    return [
      PieChartSectionData(value: sendTotal, color: Colors.red),
      PieChartSectionData(value: receiveTotal, color: Colors.green),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          GraphsViewModel(context.read<TransactionDbRepository>())..load(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Cashflow"),
        ),
        body: Container(
          padding: .all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.green,
                        ),
                      ),
                      const Text("Pemasukan"),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.red,
                        ),
                      ),
                      const Text("Pemasukan"),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Consumer<GraphsViewModel>(
                    builder:
                        (
                          BuildContext context,
                          GraphsViewModel value,
                          Widget? child,
                        ) {
                          if (value.isLoading) {
                            return const CircularProgressIndicator();
                          }
                          return PieChart(
                            PieChartData(
                              sections: displayExpenseIncomeRatio(
                                value.totalSend,
                                value.totalReceive,
                              ),
                            ),
                          );
                        },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
