# test_tdd_example_inflearn

https://www.inflearn.com/course/flutter-테스트-기초/dashboard
의 기반으로 TDD 연습 하기

## Dependencies

```yaml
    dependencies:
        cupertino_icons: ^1.0.6
        mockito: ^5.4.4
        dio: ^5.5.0+1
        freezed_annotation: ^2.4.3
        json_annotation: ^4.9.0
    dev_dependencies:
        flutter_test:
            sdk: flutter
        flutter_lints: ^3.0.0
        build_runner: ^2.4.11
        custom_lint: ^0.6.4
        freezed: ^2.5.2
        json_serializable: ^6.8.0
```

## 1. 기본 구조

- 테스튼 예상이 필요한 변수 및 로직을 적고, 그 다음에 예측이 필요한 변수, 예측하는 값을 적는게 테스트의 기본이다.

## 2. Mockito를 사용하는 이유
###  외부 라이브러리은 내가 만든게 아니기때문에, 그래서, Mock을 해서 같은 환경을 만들어주는게 가장 중요하다.

