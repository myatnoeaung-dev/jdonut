import 'dart:convert';

import 'package:integration_test/integration_test_driver.dart';

/// Host side of integration_test/perf_test.dart. Saves the frame timing
/// summary to build/onboarding_to_rewards_perf.timeline_summary.json and fails
/// when the 90th-percentile frame misses the 60 fps budget (16 ms) on either
/// the UI (build) or raster thread.
Future<void> main() => integrationDriver(responseDataCallback: _checkFrameBudget);

const String _reportKey = 'onboarding_to_rewards';
const double _frameBudgetMillis = 1000 / 60;
const List<String> _checkedPercentiles = [
  '90th_percentile_frame_build_time_millis',
  '90th_percentile_frame_rasterizer_time_millis',
];

Future<void> _checkFrameBudget(Map<String, dynamic>? data) async {
  if (data == null) throw StateError('The perf test sent no frame timings.');
  await writeResponseData(data, testOutputFilename: '${_reportKey}_perf');
  final summary = (data[_reportKey] as Map).cast<String, dynamic>();
  // ignore: avoid_print
  print(const JsonEncoder.withIndent('  ').convert(summary));
  final overBudget = [
    for (final key in _checkedPercentiles)
      if ((summary[key] as num) > _frameBudgetMillis) '$key = ${summary[key]} ms',
  ];
  if (overBudget.isNotEmpty) {
    throw StateError('Frames miss the ${_frameBudgetMillis.toStringAsFixed(1)} ms budget: ${overBudget.join(', ')}');
  }
}
