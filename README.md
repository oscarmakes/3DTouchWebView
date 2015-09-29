# 3DTouchWebView
Provides a 3D Touch API for web views by bridging native APIs with JavaScript.

## Why?
Apple doesn't provide an API for 3D Touch-enabled devices like the iPhone 6s and the iPhone 6s Plus. Not even Force Touch events detect pressure sensitivity as mentioned here:-
https://developer.apple.com/library/mac/documentation/AppleApplications/Conceptual/SafariJSProgTopics/RespondingtoForceTouchEventsfromJavaScript.html

Although incidentally, this nice chap has provided a pure JS implementation. So if you want to build a website, you can use that instead.
https://github.com/freinbichler/3d-touch

## Usage
Go ahead and modify the index.html file as you see fit. I've provided a very basic API for detecting both touch events and a handler for changes in pressure.

## It crashes!
I deliberately made the app crash when 3D Touch is not available or enabled. Don't hesitate to create an issue if something's not right!

## Credits
Thanks to Thomas Zhao (thomasrzhao) for subclassing UIGestureRecognizer to allow native touch APIs to other views other than the main view controller.
His repository: https://github.com/thomasrzhao/TRZForcePressGestureRecognizer
