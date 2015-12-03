# 3DTouchWebView
Provides a 3D Touch API for web views by bridging native APIs with JavaScript.

## Why?
Apple doesn't provide a "3D Touch" API in its Safari Developer Library docs. I can only presume it's to discourage and avoid behaviours being overriden like the Peek and Pop behaviour on anchor links.

If you want/need a JS implementation because you're building a web app, this chap has kindly made a script for that:
https://github.com/freinbichler/3d-touch

Also by not using a pure JS implementation, you're working closer to the metal for hardware access hence the little latency.

## Usage
Go ahead and modify the index.html file as you see fit. I've provided a very basic API for detecting both touch events and a handler for changes in pressure.

## It crashes!
I deliberately made the app crash when 3D Touch is not available or enabled. Don't hesitate to create an issue if something's not right!

## Credits
Thanks to Thomas Zhao (thomasrzhao) for subclassing UIGestureRecognizer to allow `Set<Touch>` API to be (unwillingly) attached to the WKWebView.
His repository: https://github.com/thomasrzhao/TRZForcePressGestureRecognizer
