# test_task_finstar

Test task Finstar Melnikov Anton

## Getting Started

## Setup development for mac

### Installing flutter SDK
1. Install actual version if flutter SDK from [Flutter SDK releases page](https://docs.flutter.dev/development/tools/sdk/releases)
2. Extract the file in the desired location, for example:
```
cd ~/development
unzip ~/Downloads/flutter_macos_version-stable.zip
```
*RECOMMENDATION*: unzip flutterSDK to folder and copy the full path for the 5 step using:
```
pwd
```
3. Open (or create) the rc file for your shell. Typing echo $SHELL in your Terminal tells you which shell you’re using. If you’re using Bash, edit $HOME/.bash_profile or $HOME/.bashrc. If you’re using Z shell, edit $HOME/.zshrc. If you’re using a different shell, the file path and filename will be different on your machine.
4. Add the following line and change `[PATH_TO_FLUTTER_DIRECTORY]` to be the path for your Flutter folder:
```
export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/bin"
```
5. Run `source $HOME/.<rc file>` to refresh the current window, or open a new terminal window to automatically source the file.
6. Verify that the flutter/bin directory is now in your PATH by running:
```
echo $PATH
```
Verify that the flutter command is available by running:
```
which flutter
```
*(OPTIONAL)*
7. Run the following command to see if there are any dependencies you need to install to complete the setup (for verbose output, add the -v flag):
```
flutter doctor
```
This command checks your environment and displays a report to the terminal window. The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately. Check the output carefully for other software you might need to install or further tasks to perform (shown in bold text).

For example:
`
[-] Android toolchain - develop for Android devices
• Android SDK at /Users/obiwan/Library/Android/sdk
✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
• Try re-installing or updating your Android SDK,
visit https://docs.flutter.dev/setup/#android-setup for detailed instructions.
`
The following sections describe how to perform these tasks and finish the setup process.
Once you have installed any missing dependencies, run the `flutter doctor` command again to verify that you’ve set everything up correctly.

### Installing Android Studio
1. Download and install [Android Studio](https://developer.android.com/studio).
2. Run `flutter doctor` to confirm that Flutter has located your installation of Android Studio. If Flutter cannot locate it, run `flutter config --android-studio-dir <directory>` to set the directory that Android Studio is installed to.

### Project setup
1. Open project via Android Studio
2. Open app_mobile/.dart_tool/android/app/src/build.gradle and change 30 row to `ndkVersion "20.1.5948944"`
3. Create new configuration in Android Studio (dropdown button in top-right row of Android Studio)
4. Add new configuration of `Flutter` **IMPORTANT** it must be 'Flutter', without any other words
5. Name your configuration and change the dart entrypoint to `<PATH TO PROJECT>/app-mobile/app_mobile/lib/main.dart`
6. Tap to 'fix' button at the bottom right corner of window (it will open new window where we will set the dart SDK path) *OR* open the "Android Studio/Preferences/Languages & Frameworks/Dart"
7. Set the dart SDK path to `<PATH TO FLUTTER FOLDER>/flutter/bin/cache/dart-sdk`


