# Color Palette Generator

This is an AI/ML based mobile app that creates color palettes from user selected images. 
The users can either take pictures by using the camera or pick images from their gallery to get the palette. The purpose of the app is to provide artists and designers with a source of inspiration and a tool for color exploration. With the generated color palette, they can incorporate the chosen colors into their creative projects, whether it be painting, digital design, or any other kinds of art.

## How it works

When the image input is received, the app sends it to the local server where the model anaylzes it. The model uses K-Means clustering to take the average of the color values from the input, and returns 5 peak values in json array. The app then takes the array, parses it into strings, and generates an organized palette with it.

## Our Model
- [Color Palette Model](https://github.com/suyashgoel/color-palette-model)

## Installation/Prerequisites

The app currently **only supports androids**. We are planning to work on ios version as well in the future.
We are also in the process of figuring out how to publish this app to Google Play Store.

1. Download our zip file and open it on Android Studio after unzipping it.
    - click **pub get** to update all the dependencies
2. Connect your android device to your computer and select it as the platform to run the app on.
3. Run the app and it should install and open when the download ends.

## Colaborators

<a href="https://github.com/bhaveshasasik/color-palette-app/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=bhaveshasasik/color-palette-app" />
</a>

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
