# Color Palette Genarator - Color Flix

This is an AI/ML based mobile app that creates color palettes from user selected images. 
The users can either take pictures by using the camera or pick images from their gallery to get the palette. The purpose of the app is to provide artists and designers with a source of inspiration and a tool for color exploration. With the generated color palette, they can incorporate the chosen colors into their creative projects, whether it be painting, digital design, or any other kinds of art.

## How it works

When the image input is received, the app sends it to the local server where the model anaylzes it. The model uses K-Means clustering to take the average of the color values from the input, and returns 5 peak values in json array. The app then takes the array, parses it into strings, and generates an organized palette with it.

## Used technologies
* [Flutter](https://docs.flutter.dev/get-started/install)
* [Android Studio](https://developer.android.com/studio?gclid=CjwKCAjwpuajBhBpEiwA_ZtfhRa9zl1MVDHjEyTg-DABD-GxMUNWyV233UKy0wMx0qFAQtAWaKN3CxoCW0gQAvD_BwE&gclsrc=aw.ds)
* [Android file Transfer](https://www.android.com/filetransfer/)

## Our Model
- [Color Palette Model](https://github.com/suyashgoel/color-palette-model)

## Installation/Prerequisites

The app currently **only supports androids**. We are planning to work on ios version as well in the future.
We are also in the process of figuring out how to publish this app to Google Play Store.

1. Download our zip file and open it on Android Studio after unzipping it.
    - click **pub get** to update all the dependencies
2. Connect your android device to your computer and select it as the platform to run the app on.
3. Run the app and it should install and open when the download ends.

## Collaborators

[![](https://github.com/bhaveshasasik.png?size=50)](https://github.com/bhaveshasasik)
[![](https://github.com/suyashgoel.png?size=50)](https://github.com/suyashgoel)
[![](https://github.com/minjiyun02.png?)](https://github.com/minjiyun02)

## References and Resources

* App icon
  * [Flutter Tutorial - Change App Icon & Name Without Needing any Packages | SUPER EASY](https://www.youtube.com/watch?v=xbbCrFvF7G8)
* Splash screen
  * [How to Create a Stunning Splash Screen in Flutter](https://youtu.be/baa0SlEDimk)
  * [How to Create a Splash Screen in Flutter App? | GeeksforGeeks](https://youtu.be/XXISgdYHdYw)
* Other screens
  * 
* Using image picker 
  * 
