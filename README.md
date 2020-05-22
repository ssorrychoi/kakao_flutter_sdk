# kakao_login_sdk

Kakao Login using `kakao_flutter_sdk`

![image](https://user-images.githubusercontent.com/43080040/82344880-8db7e100-9a2f-11ea-93c6-8431cdbf291f.png)

# 📱AOS 카카오 로그인 연결

---

kakao_flutter_sdk를 이용해서 안드로이드에서 접근하는 방법.

https://github.com/kakao/kakao_flutter_sdk

여기서 보면 좀 자세히 나와있다.

우선, 

## 1. 카카오 개발자 페이지에서 플랫폼 등록

![image](https://user-images.githubusercontent.com/43080040/82456092-bb179400-9aee-11ea-85a2-9e110d44f048.png)

- 패키지명은 FlutterProject > android > app > src > main > AndroidManifest.xml 
![image](https://user-images.githubusercontent.com/43080040/82456290-029e2000-9aef-11ea-9b29-6eba06ae3a5f.png)


## 2. 디버그 키 해시

- 키 해시
현재는 릴리즈까지 할것이 아니므로, 디버그 키만 해시하면됨.
https://developers.kakao.com/docs/latest/ko/getting-started/sdk-android-v1
여기 페이지에 잘 나와있다.

> `keytool -exportcert -alias androiddebugkey -keystore <debug_keystore_path> -storepass android -keypass android | openssl sha1 -binary | openssl base64
> `

터미널을 따로 켜서 홈디렉토리에서 명령어를 실행하면된다.

`keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64`

단, java가 설치되어있어야 함.

디버그 키 해시 저장 경로
- OS X와 리눅스 : ~/.android/debug.keystore

- Windows Vista와 Windows 7 예: C:\Users\{user}\.android\debug.keystore

- Windows XP 예 : C:\Documents and Settings\{user}\.android\debug.keystore

- keytool : $JAVA_HOME/bin

- openssl : Windows의 경우 다운로드 받아 설치

키 값이 나오면 디버그키해시값을 카카오 개발자 페이지에서 넣어준다.
![image](https://user-images.githubusercontent.com/43080040/82456905-c6b78a80-9aef-11ea-99eb-277aabdf5cf5.png)

## 3. Kakao_app_key 삽입


FlutterProject > app > src > main > AndroidManifest.xml 에 삽입하면된다.
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="your.package.name">
    <application
      ...
      >
      ...
        <activity android:name="com.kakao.sdk.flutter.AuthCodeCustomTabsActivity">
          <intent-filter android:label="flutter_web_auth">
              <action android:name="android.intent.action.VIEW" />
              <category android:name="android.intent.category.DEFAULT" />
              <category android:name="android.intent.category.BROWSABLE" />
              <data android:scheme="kakao${your_native_app_key_here}" android:host="oauth"/>
          </intent-filter>
        </activity>
        ...
      </application>
</manifest>
```

에러코드 : 

```
/Users/ssorry_choi/Documents/git/flutter/kakao_flutter_sdk/android/app/src/debug/AndroidManifest.xml Error:
	uses-sdk:minSdkVersion 16 cannot be smaller than version 19 declared in library [:kakao_flutter_sdk] /Users/ssorry_choi/Documents/git/flutter/kakao_flutter_sdk/build/kakao_flutter_sdk/intermediates/library_manifest/debug/AndroidManifest.xml as the library might be using APIs not available in 16
	Suggestion: use a compatible library with a minSdk of at most 16,
		or increase this project's minSdk version to at least 19,
		or use tools:overrideLibrary="com.kakao.sdk.flutter" to force usage (may lead to runtime failures)

FAILURE: Build failed with an exception.
```

android > app > build.gradle에서 
`minSdkVersion 16` 버전을 19로 바꿔줘야한다. 왜냐면 안드로이드 버전은 19에서 지원되기 때문,,

![스크린샷 2020-05-21 오전 10 05 10](https://user-images.githubusercontent.com/43080040/82512408-fcd62800-9b4a-11ea-8821-4d39396abc1a.png)


![image](https://user-images.githubusercontent.com/43080040/82512420-0a8bad80-9b4b-11ea-9916-a2e3dca0c018.png)



# 📱iOS 카카오 로그인 연결

---

##  xcode에서 KAKAO_APP_KEY 설정

1. Xcode로 실행한 후, 
Runner > Info > URL Types 에서 URL Schemes에다가 'kakao`네이티브앱키`' 를 넣는다.
![image](https://user-images.githubusercontent.com/43080040/82453676-c61cf500-9aeb-11ea-9fe2-84c84d29d6de.png)

2. Runner > Runner > Info.plist > + > KAKAO_APP_KEY 를 추가한 후, 네이티브앱 키를 넣어준다.
![image](https://user-images.githubusercontent.com/43080040/82454102-578c6700-9aec-11ea-917b-05e3a8810f5e.png)

## 👍🏻Finally working!
![image](https://user-images.githubusercontent.com/43080040/82455096-88b96700-9aed-11ea-98fe-51000439d506.png)