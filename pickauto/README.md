# pickauto

A new Flutter project.

## Getting Started

This is a project where we get the current location of the device.
Here you just show a polyline from source to destination.

When you start the project an animation screen will apear with a get location button on tapping it you will redirect to  ascreen where you can get the Googlemap screen and also a floating button.
By tapping on the floating button a container with two text field and a custom button will appear.
On the Source text field pass the source point by tapping on the map similarly you can do it for the destination.
It will generate two icons for source and destination respectively. So after tapping on the get path button you will se the path from source to destination. 


To use this project 1st run "flutter pub get" so it will resolve all the dependencies

Add your Api Key for android:

 Set the minSdkVersion in android/app/build.gradle:

            android {
    defaultConfig {
        minSdkVersion 20
                 }
                }
Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:

<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>


For more details follow the link: https://pub.dev/packages/google_maps_flutter.

You can get a basic idea about how you create marker and circle in a google map and an overal idea about how to conver LatLng data type to string and how to toogle button etc. 

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
