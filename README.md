# mapbox

Mapbox 를 연습하기 위한 레포지토리입니다 (~ 10/22일)

## 1. 공개 엑세스 토큰 생성

Downloads: Read 범위가 있는 보안 액세스 토큰

1. 계정의 토큰 페이지에서 토큰 만들기 버튼 클릭
2. 토큰 생성 페이지에서 토큰 이름을 지정하고 Downloads: Read 범위 옆에 있는 상자가 선택되어 있는지 확인
3. 생성한 토큰은 비밀 토큰. 즉, 안전한 곳에 복사할 수 있는 기회는 단 한번 뿐

https://docs.mapbox.com/api/accounts/tokens/  
엑세스 토큰은 사용자를 대신하여 Mapbox 리소스에 대한 액세스를 제공합니다.

모든 사용자 계정에는 기본 공개 토큰이 있습니다. 추가 또는 더 제한된 권한을 부여하기 위해 추가 토큰을 생성할 수 있습니다.

curl "https://api.mapbox.com/tokens/v2?access_token=pk.eyJ1IjoiamloeXVuLWxlZSIsImEiOiJjbDljYzBnOWgxZXd5M3RudGEwMGwxdW84In0.urWHXKEJfB_M9LBViURgRw"
