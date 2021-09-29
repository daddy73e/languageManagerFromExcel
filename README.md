# languageManagerFromExcel

## 엑셀 언어 데이터를 Android , iOS 용  프로젝트에서 copy &amp; paste 할 수 있도록 print를 찍어주는 프로그램

## How To Use

1. "ExcelToString.xcodeproj" 열기.

2. 사용하고자 하는 excel 의 데이터를 아래 스크린샷과 같이 포맷 후 복사한다.

![https://raw.githubusercontent.com/daddy73e/languageManagerFromExcel/main/screenshot_01.png](https://raw.githubusercontent.com/daddy73e/languageManagerFromExcel/main/screenshot_01.png)

![https://github.com/daddy73e/languageManagerFromExcel/blob/main/screenshot_02.png?raw=true](https://github.com/daddy73e/languageManagerFromExcel/blob/main/screenshot_02.png?raw=true)

3. "sampleExcel.txt" 파일에 붙여넣기한다

(주의 : "sampleExcel.txt" 파일 이름 변경시 "Config.swift" 에서 "ecelTxtName" 값도 변경해줘야 한다.)

4. 기존에 작업중이던 프로젝트(iOS or Android)가 있다면 아래와 같이 값만 복사한다 

iOS일 경우 (각각 "sampleKoIOS.txt", "sampleEnIOS.txt" 에 복사한다. 갯수가 달라도 상관없음)

```json
"ok"                                                 = "확인";
"cancel"                                             = "취소";
"edit"                                               = "편집";
"search"                                             = "검색";
"alert"                                              = "알림";
"admin_user_join_type_01"                            = "일반";
"admin_user_join_type_02"                            = "카카오";
"admin_user_join_type_03"                            = "네이버";
"admin_user_join_type_04"                            = "구글";
"admin_user_join_type_05"                            = "페이스북";
"admin_user_join_type_06"                            = "애플";
"confirm"                                            = "확인";
"title_picture"                                      = "작업 선택";
"dialog_servercheck"                                 = "서버 점검중 입니다.";
```

```jsx
"ok"                                                 = "OK";
"cancel"                                             = "CANCEL";
"edit"                                               = "EDIT";
"search"                                             = "Search";
"alert"                                              = "Alarms";
"admin_user_join_type_01"                            = "Normal";
"admin_user_join_type_02"                            = "Kakao";
"admin_user_join_type_03"                            = "Naver";
"admin_user_join_type_04"                            = "Google";
"admin_user_join_type_05"                            = "Facebook";
"admin_user_join_type_06"                            = "Apple";
"dialog_servercheck"                                 = "Server is under safe check.";
"app_conn_err"                                       = "Connection unstable.";
```

Android일 경우 (각각 "sample_ko_and.xml", "sample_en_and.xml" 에 복사한다. 갯수가 달라도 상관없음)

```xml
<resources>
    <string name="ok">확인</string>
    <string name="cancel">취소</string>
    <string name="edit">편집</string>
    <string name="search">검색</string>
    <string name="alert">알림</string>
    <string name="admin_user_join_type_01">일반</string>
    <string name="admin_user_join_type_02">카카오</string>
    <string name="admin_user_join_type_03">네이버</string>
    <string name="admin_user_join_type_04">구글</string>
    <string name="admin_user_join_type_05">페이스북</string>
    <string name="admin_user_join_type_06">애플</string>
    <string name="confirm">확인</string>
    <string name="title_picture">작업 선택</string>
    <string name="dialog_servercheck">서버 점검중 입니다.</string>
</resources>
```

```xml
<resources>
    <string name="ok">Confirm</string>
    <string name="cancel">Cancel</string>
    <string name="edit">Edit</string>
    <string name="search">Search</string>
    <string name="alert">Alarms</string>
    <string name="admin_user_join_type_01">Normal</string>
    <string name="admin_user_join_type_02">Kakao</string>
    <string name="admin_user_join_type_03">Naver</string>
    <string name="admin_user_join_type_04">Google</string>
    <string name="admin_user_join_type_05">Facebook</string>
    <string name="admin_user_join_type_06">Apple</string>
    <string name="dialog_servercheck">Server is under safe check.</string>
    <string name="app_conn_err">Connection unstable.</string>
</resources>
```

4. simulator를 선택하고, 실행한다.

5. iOS 또는 Android 로그를 한번에 보고자 한다면 "Auto IOS" 또는 "Auto Android" 버튼을 클릭한다.

### "Auto IOS" 클릭시 로그

```xml
***** 엑셀 데이터 갯수 *****
12
************************

******************** iOS 복사 붙여넣기용 한글 EXPORT ********************
"admin_user_join_type_01" = "일반"
"admin_user_join_type_02" = "카카오"
"admin_user_join_type_03" = "네이버"
"admin_user_join_type_04" = "구글"
"admin_user_join_type_05" = "페이스북"
"admin_user_join_type_06" = "애플"
"alert" = "알림"
"cancel" = "취소"
"edit" = "편집"
"ok" = "확인"
"search" = "검색"
************ Count = 11 ************

******************** iOS 복사 붙여넣기용 영문 EXPORT ********************
"admin_user_join_type_01" = "Normal"
"admin_user_join_type_02" = "Kakao"
"admin_user_join_type_03" = "Naver"
"admin_user_join_type_04" = "Google"
"admin_user_join_type_05" = "Facebook"
"admin_user_join_type_06" = "Apple"
"alert" = "Alarms"
"cancel" = "Cancel"
"edit" = "Edit"
"ok" = "Confirm"
"search" = "Search"
************ Count = 11 ************

***** iOS 코드에 사용중인 한글 String 갯수 *****
15
*****************************************

***** iOS 코드에 사용중인 영문 String 갯수 *****
14
*****************************************

***** 한글 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****
(00)  ID : confirm      한글 번역 : 확인
(01)  ID : dialog_servercheck      한글 번역 : 서버 점검중 입니다.
(02)  ID : title_picture      한글 번역 : 작업 선택
******************** Count = 3 **********************

***** 영문 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****
(00)  ID : app_conn_err      영문 번역 : Connection unstable.
(01)  ID : dialog_servercheck      영문 번역 : Server is under safe check.
******************** Count = 2 **********************

EachLocale(strId: "app_conn_err", kor: "", eng: "Connection unstable.")

***** 한글, 영문 통합 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****
ID : confirm
한글 변역:"확인"
영문 번역:""

ID : dialog_servercheck
한글 변역:"서버 점검중 입니다."
영문 번역:"Server is under safe check."

ID : title_picture
한글 변역:"작업 선택"
영문 번역:""

ID : app_conn_err
한글 변역:""
영문 번역:"Connection unstable."

******************************************

******************** iOS 복사 붙여넣기용 한글 EXPORT ********************
"confirm" = "확인"
"dialog_servercheck" = "서버 점검중 입니다."
"title_picture" = "작업 선택"
"app_conn_err" = ""
************ Count = 4 ************

******************** iOS 복사 붙여넣기용 영문 EXPORT ********************
"confirm" = ""
"dialog_servercheck" = "Server is under safe check."
"title_picture" = ""
"app_conn_err" = "Connection unstable."
************ Count = 4 ************
```

### "Auto Android" 클릭시 로그

```xml
***** 엑셀 데이터 갯수 *****
12
************************

******************** ANDROID 복사 붙여넣기용 한글 EXPORT ********************
<resources>
    <string name="admin_user_join_type_01">일반</string>
    <string name="admin_user_join_type_02">카카오</string>
    <string name="admin_user_join_type_03">네이버</string>
    <string name="admin_user_join_type_04">구글</string>
    <string name="admin_user_join_type_05">페이스북</string>
    <string name="admin_user_join_type_06">애플</string>
    <string name="alert">알림</string>
    <string name="cancel">취소</string>
    <string name="edit">편집</string>
    <string name="ok">확인</string>
    <string name="search">검색</string>
</resources>
************ Count = 11 ************

******************** ANDROID 복사 붙여넣기용 영문 EXPORT ********************
<resources>
    <string name="admin_user_join_type_01">Normal</string>
    <string name="admin_user_join_type_02">Kakao</string>
    <string name="admin_user_join_type_03">Naver</string>
    <string name="admin_user_join_type_04">Google</string>
    <string name="admin_user_join_type_05">Facebook</string>
    <string name="admin_user_join_type_06">Apple</string>
    <string name="alert">Alarms</string>
    <string name="cancel">Cancel</string>
    <string name="edit">Edit</string>
    <string name="ok">Confirm</string>
    <string name="search">Search</string>
</resources>
************ Count = 11 ************

***** 한글 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****
(00)  ID : confirm      한글 번역 : 확인
(01)  ID : dialog_servercheck      한글 번역 : 서버 점검중 입니다.
(02)  ID : title_picture      한글 번역 : 작업 선택
******************** Count = 3 **********************

***** 영문 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****
(00)  ID : app_conn_err      영문 번역 : Connection unstable.
(01)  ID : dialog_servercheck      영문 번역 : Server is under safe check.
******************** Count = 2 **********************

***** 한글, 영문 통합 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****
ID : confirm
한글 변역:"확인"
영문 번역:""

ID : dialog_servercheck
한글 변역:"서버 점검중 입니다."
영문 번역:"Server is under safe check."

ID : title_picture
한글 변역:"작업 선택"
영문 번역:""

ID : app_conn_err
한글 변역:""
영문 번역:"Connection unstable."

******************************************

******************** ANDROID 복사 붙여넣기용 한글 EXPORT ********************
<resources>
    <string name="confirm">확인</string>
    <string name="dialog_servercheck">서버 점검중 입니다.</string>
    <string name="title_picture">작업 선택</string>
    <string name="app_conn_err"></string>
</resources>
************ Count = 4 ************

******************** ANDROID 복사 붙여넣기용 영문 EXPORT ********************
<resources>
    <string name="confirm"></string>
    <string name="dialog_servercheck">Server is under safe check.</string>
    <string name="title_picture"></string>
    <string name="app_conn_err">Connection unstable.</string>
</resources>
************ Count = 4 ************
```
