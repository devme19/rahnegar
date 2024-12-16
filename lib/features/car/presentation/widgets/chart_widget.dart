import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';




class ChartWidget extends StatelessWidget {

  List<PercentData> chartData = [];
  ChartWidget({required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 30,
                showTitles: true,              // Show Y-axis values
                interval: 20,                  // Interval for Y-axis
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(value.toInt().toString()), // Y-axis values
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Hide right Y-axis
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 50,
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  DateTime date = chartData[value.toInt()].time;
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Text(DateFormat('HH:mm').format(date)),
                        Text(DateFormat('yy-MM-dd').format(date),style: TextStyle(fontSize: 8),),
                      ],
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles( // Disable top X-axis values
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: (chartData.length - 1).toDouble(),
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: chartData
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.percent.toDouble()))
                  .toList(),
              isCurved: true,
              barWidth: 2,
              color: Colors.blue,
              dotData: FlDotData(show: true), // Hide the dots on the chart
              showingIndicators: [], // Ensure no labels are shown
            ),
          ],
        ),
      ),
    );
  }
}

class PercentData {
  final double percent;
  final DateTime time;

  PercentData(this.percent, this.time);
}



// class ChartWidget extends StatelessWidget {
//   final List<PercentData> chartData = [
//     PercentData(2, DateTime.parse("2024-10-03 06:24:22.861976Z").toLocal()),
//     PercentData(23, DateTime.parse("2024-10-04 06:24:22.861976Z").toLocal()),
//     PercentData(35, DateTime.parse("2024-10-05 06:24:22.861976Z").toLocal()),
//     PercentData(78, DateTime.parse("2024-10-06 06:24:22.861976Z").toLocal())
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Percentage over Time')),
//       body: Center(
//         child: SfCartesianChart(
//           primaryXAxis: DateTimeAxis(
//             dateFormat: DateFormat('yy-MM-dd \n HH:mm'),
//             intervalType: DateTimeIntervalType.minutes,
//             rangePadding: ChartRangePadding.additional, // Adds extra space to the chart
//           ),
//           primaryYAxis: NumericAxis(
//             title: AxisTitle(text: 'Percentage'),
//           ),
//           series: <CartesianSeries>[
//             LineSeries<PercentData, DateTime>(
//               dataSource: chartData,
//               xValueMapper: (PercentData data, _) => data.time,
//               yValueMapper: (PercentData data, _) => data.percent,
//               markerSettings: MarkerSettings(isVisible: true),
//               dataLabelSettings: DataLabelSettings(isVisible: true),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PercentData {
//   final int percent;
//   final DateTime time;
//
//   PercentData(this.percent, this.time);
// }
//
//

