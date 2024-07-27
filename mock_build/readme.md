# MockBuild에 대한 설명

## 1. MockBuild는 실제 Build파일을 .gitignore때문에 날아갈 build대신 만든 dir

## 2. performance test

Cli 명령어 및 테스트 코드 작성 이후, 추가적으로 나오는  
`scrolling_timeline.timeline_summary.json`  
`scrolling_timeline.timeline.json`  
파일이 `build` 폴더에 만들어진다.

```bash
flutter drive \
--driver=perf_driver/perf_driver.dart \
--target=integration_test/app_test.dart \
--profile \
--no-dds
```

## 3. 각 파일의 대한 설명

### 1. `scrolling_timeline.timeline_summary.json`

그래프를 만들 수 있는 json이라고 한다.

### 2. `scrolling_timeline.timeline.json`

test 연결 링크 : <chrome://tracing>
