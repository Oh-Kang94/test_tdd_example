import 'package:flutter_test/flutter_test.dart';
import 'package:test_tdd_example_inflearn/1_counter/counter.dart';

void main() {
  // Group :
  group(
    'Counter',
    () {
      test(
        'It must starts 0',
        () {
          // 첫 param은 추측하고 싶은 변수, 두번째 param은 기대하는 값
          expect(
            Counter().value,
            0,
          );
        },
      );
      test(
        'Add +1',
        () {
          final counter = Counter();
          counter.countUp();
          expect(counter.value, 1);
        },
      );
      // 1씩 감소
      test(
        'Sub 1',
        () {
          final counter = Counter();
          counter.countDown();
          expect(counter.value, -1);
        },
      );
      // 0으로 Reset
      test('reset 0', () {
        final counter = Counter();
        counter.clear();
        expect(counter.value, 0);
      });
    },
  );
  
}
