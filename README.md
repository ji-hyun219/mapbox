# mapbox

Mapbox 를 연습하기 위한 레포지토리입니다 (~ 10/22일)

## 1. 공개 엑세스 토큰 생성

Downloads: Read 범위가 있는 보안 액세스 토큰

1. 계정의 토큰 페이지에서 토큰 만들기 버튼 클릭
2. 토큰 생성 페이지에서 토큰 이름을 지정하고 `Downloads: Read` 범위 옆에 있는 상자가 선택되어 있는지 확인
3. 생성한 토큰은 `시크릿 토큰`. 즉, 안전한 곳에 복사할 수 있는 기회는 단 한번 뿐

https://docs.mapbox.com/api/accounts/tokens/  
엑세스 토큰은 사용자를 대신하여 Mapbox 리소스에 대한 액세스를 제공합니다.

모든 사용자 계정에는 기본 공개 토큰이 있습니다. 추가 또는 더 제한된 권한을 부여하기 위해 추가 토큰을 생성할 수 있습니다.

### 1번에 대한 참고자료 (토큰 생성에 관한..)

https://github.com/ji-hyun219/mapbox-flutter

`이어지는 2, 3번 --> 이제 두 토큰이 있으므로 프로젝트 코드의 적절한 위치에서 토큰을 교체하기만 하면 됩니다.`

## 2. ios - 토큰 교체

### `공개 토큰인 경우`

Info.plist 파일을 열고 `MBXAccessToken` 값이 `공개 엑세스 토큰인 키를 추가`한다.

```
<key>MBXAccessToken></key>
	<string>pk.eyJ1IjoiamloeXVuLWxlZSIsImEiOiJjbDljYzBnOWgxZXd5M3RudGEwMGwxdW84In0.urWHXKEJfB_M9LBViURgRw</string>
```

이렇게 나의 `public access token 을 추가`해주면 된다.

### `시크릿 토큰인 경우`

- 홈 디렉터리란
  Home Directory (~)
  멀티 유저 시스템에선 사용자마다 독립적인 공간을 할당해줘서 독립 공간에 파일을 저장할 수 있도록 합니다.  
  리눅스에선 이런 독립 공간을 home directory 라고 합니다.  
  chmod 로 권한을 설정하여 타인이 디엑토리를 수정, 삭제, 읽기 등을 제한할 수 있습니다.

- Home Directory 경로
  보통은 `/home/User` 에 위치합니다.  
  제 User 아이디가 eisen 일 시 eisen 계정의 home directory 는
  `/home/eisen` 이 됩니다.

1. 비밀 토큰을 사용하려면 프로젝트 폴더가 아닌 `홈 디렉터리의 파일에 저장`해야 한다.
2. 이 접근 방식은 애플리케이션의 소스 코드에서 비밀 토큰을 유지하여 `실수로 비밀 토큰을 노출하는 것을 방지`하는 데 도움이 된다..!!
3. `.netrc 파일을 생성`하여 다음과 같이 추가

- touch .netrc
- cat > .netrc
- 다음 코드를 추가 (`YOUR_SECRET_TOKEN` 에 발급 받은 시크릿 토큰 입력)

```
machine api.mapbox.com
  login mapbox
  password <YOUR_SECRET_TOKEN>
```

## 3. Android - 토큰 교체

### `시크릿 토큰 구성`

비밀 토큰이 노출되지 않도록 하려면 이를 환경변수로 추가해라.

홈 디렉터리에 `ls -a` 하면 `.gradle 디렉터리`가 존재. 이를 `ls` 하면

```
caches
jdks
native
daemon
kotlin-profile
wrapper
```

그래서 여기다가 `gradle.properties` 파일을 찾거나 만든다.  
지금 없으니까 만들어야 함  
https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home

위의 url 을 클릭하면 `gradle.properties` 파일은 `전역 Gradle 구성 속성` 에 대한 내용의 파일

### `공개 토큰 구성`

```
<string name="mapbox_access_token">YOUR_MAPBOX_ACCESS_TOKEN</string>
```

<권한 구성>  
매니페스트 병합 기능을 사용하여 애플리케이션의 메니페스트 파일에 SDK 요구 사항을 포함할 필요성을 줄일 수 있다.  
지도에 사용자의 위치를 ​​표시 하거나 사용자의 위치 정보를 얻으려면 정밀 또는 보통 위치 권한 을 추가해야 합니다.

```
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

## 그 후 명령어

```
flutter build ios --dart-define ACCESS_TOKEN=sk.**
```
