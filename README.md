# Flutter Multi Platform Package Test

I’m focused on getting us web ready, and of the packages we are using, a few don’t support web. I don’t know how we’re going to actually deal with this, but a few ideas are:

1. Plan A: Replace the package with an alternative that supports web.
2. Plan B: Use conditional widgets or replacement imports - https://stackoverflow.com/a/60152950.
3. Plan C: Remove the package altogether and make our own alternative or pull in the code and customize it.
4. Plan D: Just wait for the package to support web.

I also started looking at null safety, since starting next year it'll be in beta and we can start writing our code to be null safe, so here are the packages, their support status and what I think we should do for each:

|                                                      Package | Web Support | Null Safety Support | Solution                                                     |
| -----------------------------------------------------------: | :---------: | :-----------------: | :----------------------------------------------------------- |
|            [Animations](https://pub.dev/packages/animations) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
|                      [Async](https://pub.dev/packages/async) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|                    [Badges](https://pub.dev/packages/badges) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
| [CachedNetworkImageProvider](https://pub.dev/packages/cached_network_image) |     🚫🙅🚫     |         🚫🙅🚫         | Replace with [FadeInImage.memoryNetwork](https://api.flutter.dev/flutter/widgets/FadeInImage-class.html#FadeInImage.memoryNetwork). Already tested. Works well. |
|   [CarouselSlider](https://pub.dev/packages/carousel_slider) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support. Not very web friendly, should have buttons or something to indicate that it can slide. |
|            [Characters](https://pub.dev/packages/characters) |     ✅👌✅     |         ✅👌✅         | N/A, but definitely exposed a [bug and it's fix](https://github.com/flutter/flutter/issues/53897#issuecomment-716638453). |
|     [DevicePreview](https://pub.dev/packages/device_preview) |     ⚠️🤷⚠️     |         🚫🙅🚫         | Wait for null safety support, or just remove it since it's useful but not crucial, and is very buggy on web. |
|       [FlutterHooks](https://pub.dev/packages/flutter_hooks) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
|       [FlutterIcons](https://pub.dev/packages/flutter_icons) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support. Small problem - it did not show icons the first time I rendered it, but then it showed it fine. [Might have to try this if it breaks again](https://github.com/flutter/flutter/issues/32540#issuecomment-707900491). If necessary, alternatives can be found. |
| [FlutterSlideable](https://pub.dev/packages/flutter_slidable) |     ✅👌✅     |         ✅👌✅         | N/A. Not very web friendly, should add buttons or something to indicate that it can slide open. |
|   [FlutterSpinKit](https://pub.dev/packages/flutter_spinkit) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
| [FlutterStripePayment](https://pub.dev/packages/flutter_stripe_payment) |     🚫🙅🚫     |         🚫🙅🚫         | [A bit of a problem](#stripe).                               |
|           [FlutterSVG](https://pub.dev/packages/flutter_svg) |     ⚠️👌⚠️     |         ✅👌✅         | This one's a bit weird, since it has null safety support but not *official* web support. If we want to opt with Plan A, we could use the [PhotoView](https://pub.dev/packages/photo_view) package, but it doesn't have null safety support. I think the better option would be to opt for Plan B, where I create a [SVG Widget that conditionally uses this package or a different one](https://stackoverflow.com/a/62560528) in Web. [Another example](https://github.com/masewo/flutter_svg_web_example). ***But weirdly enough it just works if I use canvaskit.*** |
|     [FlutterSwiper](https://pub.dev/packages/flutter_swiper) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
| [FlutterTypeAhead](https://pub.dev/packages/flutter_typeahead) |     ⚠️👌⚠️     |         🚫🙅🚫         | Wait for null safety support. Few errors being thrown due to a lack of keyboards in web, and it may have more errors, but it should be fine. |
| [FontAwesomeFlutter](https://pub.dev/packages/font_awesome_flutter) |     ✅👌✅     |         ✅👌✅         | It's a good package but... we don't need it at all, since [FlutterIcons](https://pub.dev/packages/flutter_icons) has all the icons it does. However that library doesn't have null safety support, and this one does. Still, removing is does increasing loading speed. |
|                      [Fuzzy](https://pub.dev/packages/fuzzy) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
|             [GetIt](https://pub.dev/packages/get_it/install) |     ✅👌✅     |         ✅👌✅         | It's a good package but, we also won't need it, especially after we migrate to Riverpod. |
|                        [Http](https://pub.dev/packages/http) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
|       [ImageCropper](https://pub.dev/packages/image_cropper) |     🚫🙅🚫     |         🚫🙅🚫         | ??? (Chieh)                                                  |
|         [ImagePicker](https://pub.dev/packages/image_picker) |     🚫🙅🚫     |         🚫🙅🚫         | ??? (Chieh)                                                  |
|        [Intercom](https://pub.dev/packages/intercom_flutter) |     🚫🙅🚫     |         🚫🙅🚫         | Costs a lot, so we need to decide if we want to keep it or replace it with something else. If we want to keep it, we have to make it work in Flutter Web, which looks like it won't be a good implementation any time soon. If we want to replace it, I want to go with this Flutter compatible one called [Papercups](https://pub.dev/packages/papercups_flutter ). Or we don't have either. Either way, I need to stick in Segment for event tracking for stall points and admin panel data, and I want to use [Storytime](https://github.com/papercups-io/storytime) on Flutter Web. |
|                        [Intl](https://pub.dev/packages/intl) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|       [LaunchReview](https://pub.dev/packages/launch_review) |     🚫🙅🚫     |         🚫🙅🚫         | I found something a million times better. [InAppReview](https://pub.dev/packages/in_app_review). Web doesn't have a replacement, so I just need to make the whole thing work at minimum to [send feedback to us](https://pub.dev/packages/rating_dialog) for the NPS score in the Admin Panel, and if it's a positive score and not on web it opens the in app review prompt. |
| [MaskTextInputFormatter](https://pub.dev/packages/mask_text_input_formatter) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|                        [Mime](https://pub.dev/packages/mime) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|   [PageTransition](https://pub.dev/packages/page_transition) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|       [PathProvider](https://pub.dev/packages/path_provider) |     🚫🙅🚫     |         🚫🙅🚫         | Remove, unneeded with Web.                                   |
| [PermissionHandler](https://pub.dev/packages/permission_handler) |     🚫🙅🚫     |         🚫🙅🚫         | ??? (Chieh)                                                  |
|             [PhotoView](https://pub.dev/packages/photo_view) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
|      [PrettyQRCode](https://pub.dev/packages/pretty_qr_code) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support. We can use it if we want to.   |
|                [Provider](https://pub.dev/packages/provider) |     ✅👌✅     |         ✅👌✅         | Replace with [Riverpod](https://pub.dev/packages/hooks_riverpod) after [null-safe](https://github.com/rrousselGit/river_pod/issues/220) |
|                    [Recase](https://pub.dev/packages/recase) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
| [ReceiveSharingIntent](https://pub.dev/packages/receive_sharing_intent) |     🚫🙅🚫     |         🚫🙅🚫         | ??? (Chieh)                                                  |
|                    [RxDart](https://pub.dev/packages/rxdart) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|                      [Share](https://pub.dev/packages/share) |     🚫🙅🚫     |         ✅👌✅         | ??? (Chieh) Either Plan A: Replace with [SharePlus](https://pub.dev/packages/share_plus) or go with Plan B. |
|         [ShareExtend](https://pub.dev/packages/share_extend) |     🚫🙅🚫     |         🚫🙅🚫         | ??? (Chieh)                                                  |
| [SharedPreferences](https://pub.dev/packages/shared_preferences) |     ✅👌✅     |         🚫🙅🚫         | Wait for null safety support.                                |
| [SimpleAnimations](https://pub.dev/packages/simple_animations) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|     [StripePayment](https://pub.dev/packages/stripe_payment) |     🚫🙅🚫     |         🚫🙅🚫         | There's no reliable stripe packages for mobile and web, so we need to make a full in house replacement. The good news is that the only two features the package provided was entering credit cards and verifying some specific card transactions, which will take a bit, but is possible, I think. |
|       [TimelineTile](https://pub.dev/packages/timeline_tile) |     🚫🙅🚫     |         🚫🙅🚫         | ??? (Chieh)                                                  |
|                      [Tuple](https://pub.dev/packages/tuple) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|         [UrlLauncher](https://pub.dev/packages/url_launcher) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|              [Vibration](https://pub.dev/packages/vibration) |     ✅👌✅     |         ✅👌✅         | N/A                                                          |
|   [WebViewFlutter](https://pub.dev/packages/webview_flutter) |     🚫🙅🚫     |         🚫🙅🚫         | Since web apps don't have web view, because, it is the web, I need to find a [hack](#FlutterWebview) to show websites in the website. Going to be a problem, especially with CSR and CORS. Maybe have to solve with tabs using a dynamic import. |

## Chieh

- Figure out [ImagePicker](https://pub.dev/packages/image_picker) and [ImageCropper](https://pub.dev/packages/image_cropper) - We need full replacements for this, or mish mash our own, or worst case we pull it all into our code and make it work
- Figure out [PermissionHandler](https://pub.dev/packages/permission_handler) - I think you pulled in this package
- Figure out [ReceiveSharingIntent](https://pub.dev/packages/receive_sharing_intent) - I don't think this exists on web at all, so all we have to do is make sure the feature works on android and ios and is ignored on web, probably a dynamic import
- Figure out [Share](https://pub.dev/packages/share) and [ShareExtend](https://pub.dev/packages/share_extend) - Figure out if there's a web alternative, if there is get it to work on all 3, if it doesn't make a dynamic import and ignore it on web
- Figure out [TimelineTile](https://pub.dev/packages/timeline_tile) - We either need an alternative or a replacement or make it work on web or something; maybe pull the package in internally
- See if it's possible to have Firebase packages that aren't web ready in the code base being used in non web platforms; maybe they'll need a dynamic import with noop web mirror functions
- Help test more things and help [Decide between Canvas or HTML](#decidebetweencanvasorhtml)

## Oindril

- Need to figure out [StripePayment](https://pub.dev/packages/stripe_payment) - There's no reliable stripe packages for mobile and web, so we need to make a full in house replacement. The good news is that the only two features the package provided was entering credit cards and verifying some specific card transactions, which will take a bit, but is possible, I think 
- Need to figure out [WebViewFlutter](https://pub.dev/packages/webview_flutter) - Since web apps don't have web view, because, it is the web, I need to find a hack to show websites in the website. Going to be a problem, especially with CSR and CORS. Maybe have to solve with tabs using a dynamic import.
- Need to figure out [LaunchReview](https://pub.dev/packages/launch_review) - I found a million times better thing. In app review. Web doesn't have a replacement, so I just need to make the whole thing work with at minimum to send feedback to us for an NPS score in the Admin Panel, and if it's a positive score and not on web it opens the in app review prompt.
- Need to figure out [Intercom](https://pub.dev/packages/intercom_flutter) - it costs a lot, so need to decide with Andrew if we keep it or replace it with something else. If we want to keep it, we have to make it work in Flutter, if we want to replace it, I want to go with this Flutter compatible one called Papercups. Or we don't have either. Either way, I need to stick in Segment for event tracking for stall points and admin panel data.

## Decide between Canvas or HTML

`flutter create --description "Flutter Multi Platform Package Test" --org "com.multiplatform.test" --project-name "flutter_multi_platform_package_test" -t app .`

Find all the pros and cons between them, what works and what doesn't, things to look out for:

- Emojis
- Fonts
- Images (cached?)
- SVG (cached?) - https://github.com/dnfield/flutter_svg
- How do Graphical Packages look

## Firebase Problems

If we want to opt into Plan A, the only stripe package that supports Web is [Stripe API](https://pub.dev/packages/stripe_api). It doesn't have null safety, and worst case I can copy it's source code as needed.

## Improvements

- Replace Intercom with Segment + Papercups and figure out how to pull that customer data into Retool
  - https://papercups.io | https://app.papercups.io/account/overview | https://pub.dev/packages/papercups_flutter | https://github.com/papercups-io/storytime | https://pub.dev/packages/feedback
- Migrate from Provider to Riverpod
  - https://riverpod.dev
- Find a better way to have document models, use generics or packages
  - Use Mixins, Abstract and Interface Classes https://dart.dev/samples#interfaces-and-abstract-classes
  - Figure out how to have all code be generated and available instead of manually done, based on types stringified
  - Consider Using https://pub.dev/packages/equatable
- Find a better way to have styling in flutter
  - Use https://pub.dev/packages/nested for all styling
  - Or use https://pub.dev/packages/styled_widget
  - Or check out https://pub.dev/packages/velocity_x
  - Maybe use https://github.com/fayeed/flutter_parsed_text for body
- Find a way to support web responsiveness better
  - https://github.com/Codelessly/ResponsiveFramework | https://pub.dev/packages/responsive_framework
  - https://pub.dev/packages/auto_size_text
  - https://blog.codemagic.io/flutter-web-getting-started-with-responsive-design/
- Improve routing
  - https://stackoverflow.com/questions/49681415/flutter-persistent-navigation-bar-with-named-routes/59133502#59133502
  - `setUrlStrategy(PathUrlStrategy());`
    - https://stackoverflow.com/a/65709246
  - See if GetX is cleaner than what we have now https://pub.dev/packages/get
  - Use Fluro for routing if it does anything actually better
- Implement Video calling so we can pass the app store
  - https://pub.dev/packages/flutter_speed_dial
  - https://pub.dev/packages/agora_rtc_engine
- Add a splash screen for android, ios, web, macos
  - https://pub.dev/packages/flutter_native_splash
  - https://pub.dev/flutter/packages?q=splash+screen&platform=ios+web+android
- Get the highest scores possible on Lighthouse for flutter web
  - It's ok if performance ins't the best
- Since we're doing web, add desktop support with Electron and MacOS
  - https://github.com/hayderux/electron-flutter
- Replace feedback dialog with
  - https://pub.dev/packages/rating_dialog -> sends data to us
  - good reviews go to -> https://pub.dev/packages/in_app_review

## Stripe Problems

Options:

- https://pub.dev/packages/stripe_api
- https://pub.dev/packages/credit_card_validator | https://pub.dev/packages/string_validator
- https://pub.dev/packages/credit_card_type_detector

## Hosting

- https://blog.codemagic.io/publishing-web-apps-to-firebase-hosting/
- https://firebase.google.com/docs/hosting
- https://flutter.dev/docs/deployment/web

Web Responsiveness

- https://flutter.dev/docs/development/ui/layout/responsive

 ### FlutterWebview:

- https://stackoverflow.com/questions/58150503/webview-in-flutter-web
- https://pub.dev/packages/easy_web_view
- https://stackoverflow.com/questions/61499763/flutter-webview-not-working-for-flutter-web
- https://stackoverflow.com/questions/58632100/webview-in-flutter-for-web-is-not-loading-google-maps-or-others

Stripe: https://fidev.io/stripe-checkout-in-flutter-web/ | https://github.com/MarcinusX/flutter_stripe_demo

- https://stackoverflow.com/questions/61484807/flutter-web-dialog-popup-for-stripe-integration
- https://github.com/Techie-Qabila/stripe_api
- https://github.com/jonasbark/flutter_stripe_payment
- https://pub.dev/packages/stripe_sdk - https://github.com/ezet/stripe-sdk/tree/master/example/web
- https://pub.dev/packages/stripe_payment

CORS:

- https://medium.com/swlh/flutter-web-node-js-cors-and-cookies-f5db8d6de882

Firebase Storage Web Problems:

- https://dev.to/happyharis/flutter-web-firebase-storage-2ac1
- https://www.xspdf.com/resolution/54536347.html

Bonuses:

- https://github.com/ajith-m-doodlebug/center_webview/blob/main/lib/center_webview.dart
- https://pub.dev/packages/flutter_keyboard_visibility
- https://github.com/FlutterGen/flutter_gen

Share Target:

- https://youtu.be/ppwagkhrZJs?t=466

File Picker

- https://pub.dev/packages/file_picker
- https://pub.dev/packages/file_access
- https://pub.dev/packages/image_web_picker
- https://github.com/flutter/flutter/issues/36281

Image Cropper

- https://pub.dev/packages/crop
- https://pub.dev/packages/image_crop_widget
- https://pub.dev/packages/image

Flutter Web Samples:

- 
  - https://gallery.codelessly.com/flutterwebsites/flutterwebsite
  - https://gallery.codelessly.com/flutterwebsites/minimal

Null Safety:

- https://dart.dev/null-safety/migration-guide#migration-tool
- Add `// @dart=2.9` to disable null checking in a file, but **<u>*DO NOT USE*</u>**
- **<u>*DO NOT USE `!` or `late`*</u>**
  - The `!` operator is a runtime null check in all modes, for all users. So, when migrating, ensure that you only add `!` where it’s an error for a `null` to flow to that location, even if the calling code has not migrated yet.
  - Runtime checks associated with the `late` keyword apply in all modes, for all users. Only mark a field `late` if you are sure it is always initialized before it is used.
- https://dart.dev/null-safety/faq

Future:

- https://pub.dev/packages/i18n_extension