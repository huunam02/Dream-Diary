# Flutter
-dontwarn io.flutter.**
-keep class io.flutter.** { *; }

# Kotlin
-dontwarn kotlin.**
-keep class kotlin.** { *; }

# Coroutines
-keep class kotlinx.coroutines.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Google Ads (QUAN TRỌNG nếu bạn chạy quảng cáo)
-keep class com.google.android.gms.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# AndroidX
-dontwarn androidx.**
-keep class androidx.** { *; }

# Metadata & annotations
-keep class kotlin.Metadata { *; }
-keepattributes *Annotation*

# Entry points (activity, service, etc.)
-keep class * extends android.app.Activity
-keep class * extends android.app.Application
-keep class * extends android.app.Service
-keep class * extends android.content.BroadcastReceiver
-keep class * extends android.content.ContentProvider
