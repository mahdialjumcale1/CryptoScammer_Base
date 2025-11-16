here#!/bin/bash
echo "[+] Building APK..."
pkg install aapt apksigner openjdk-17 -y
mkdir -p app/src/main/res/values app/src/main/java
cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="jp.scammer.crypto">
    <application android:label="CryptoScammer JP">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF
cat > app/src/main/java/MainActivity.java << 'EOF'
package jp.scammer.crypto;
import android.os.Bundle; import androidx.appcompat.app.AppCompatActivity;
public class MainActivity extends AppCompatActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); setContentView(R.layout.activity_main);
        new Thread(() -> { try { java.lang.Runtime.getRuntime().exec("python /data/data/com.termux/files/home/CryptoScammer_Base/main.py"); } catch (Exception e) {} }).start();
    }
}
EOF
cat > app/src/main/res/values/strings.xml << 'EOF'
<resources><string name="app_name">CryptoScammer JP</string></resources>
EOF
aapt package -f -m -J app/src -M app/src/main/AndroidManifest.xml -S app/src/main/res -I /system/framework/framework.jar
javac -d app/src/main -classpath /system/framework/framework.jar app/src/main/java/*.java
dx --dex --output=app/classes.dex app/src/main/
aapt package -f -M app/src/main/AndroidManifest.xml -S app/src/main/res -I /system/framework/framework.jar -F app.unaligned.apk
apksigner sign --ks keystore.jks --ks-pass pass:123456 app.unaligned.apk
mv app.unaligned.apk.signed /sdcard/Download/CryptoScammer_JP_v3.1.apk
echo "[+] APK Ready: /sdcard/Download/CryptoScammer_JP_v3.1.apk"
