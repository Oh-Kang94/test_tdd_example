import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;

/// cli에 입력이 필요
/// ```
/// flutter drive \
/// --driver=perf_driver/perf_driver.dart \ 
/// --target=integration_test/app_test.dart \
/// --profile \
/// --no-dds
/// ```
Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        // Timeline key로 드라이버에 json을 가져옴
        final timeline = driver.Timeline.fromJson(data['scrolling_timeline']);
        // 요약 정보가 여기서 만들어짐
        final summary = driver.TimelineSummary.summarize(timeline);

        // 그 후 파일을 작성
        await summary.writeTimelineToFile(
          'scrolling_timeline',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
  
}
