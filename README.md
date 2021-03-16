# Flutter Multi Platform Package Test

## ***The Plan* ™**

1. ~~Clean up all existing branches of the app, condense into one main one, and push a release to `master` 0.2.3~~
2. Get the current app “web-safe” on a new branch `web` 
   - Migrate packages to be web and null safe
   - ~~Add null safety to the code base~~ - https://github.com/Spotlyt/spotlyt-app/pull/45
   - Have web and android and iOS versions working
3. Once we're happy with `web` working well on all platforms, merge into `development`, but not `master`, and save the new web and null safe ready `development`  branch to `stable-web` as an archive of the old web ready app.
4. Start the new radically `simple`, and `simple-dev` branch version of the app based off of the `development` branch from which we will pull in code from `stable-web`

At this point, we should have 6 branches:

- `master`: Release, Production. (Going to Users, ideally prefer channel `stable`, but will have to use `beta` later)
- `development`: The currently in development branch, used for testing. (Can be either in channel `beta` or `stable`)
- `stable`: Old stable app as an archive. (Can only be channel `stable`)
- `stable-web`: Old stable app that is web compatible as an archive. (Can only be channel `beta`)
- `simple`: New app where we will start to port code from `stable web`. (Going to builds for beta testing)
- `simple-dev`: The currently in development branch for the new simple app. (Can only be channel `beta`)

Dependency Tree: `master` <- `stable`, `development` <- `stable-web`, `simple` <- `simple-dev`

Once we are at the point, we can start trying to get users from the `simple` branch, and once we get users, we will push to `master` and remove the old build cycle, but to even get to that point, we have to finish Plan Step #2, we have to get web ready! I’m focused on getting us web ready, and of the packages we are using, a few don’t support web. I don’t know how we’re going to actually deal with this across the board, but a few ideas are:

1. Option A: Replace the package with an alternative that supports web.
2. Option B: Use conditional widgets or replacement imports - https://stackoverflow.com/a/60152950.
3. Option C: Remove the package altogether and make our own alternative or pull in the code and customize it.
4. Option D: Just wait for the package to support web.

I also started looking at null safety, since starting next year it'll be in beta and we can start writing our code to be null safe, so here are the packages, their support status and what I think we should do for each:

## Packages

|                                                      Package | Web Support | Null Safety Support | HTML? | Canvas? | Solution                                                     |
| -----------------------------------------------------------: | :---------: | :-----------------: | :---: | :-----: | :----------------------------------------------------------- |
|            [Animations](https://pub.dev/packages/animations) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    |                                                              |
|                      [Async](https://pub.dev/packages/async) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
|                    [Badges](https://pub.dev/packages/badges) |     ✅👌✅     |         🚫🙅🚫         |   ✅   |    ✅    | Null safe pre-released                                       |
|        [CNIP](https://pub.dev/packages/cached_network_image) |     ⚠️🤷⚠️     |         🚫🙅🚫         |       |         | Null safety in developement release., or replace with [FadeInImage.memoryNetwork](https://api.flutter.dev/flutter/widgets/FadeInImage-class.html#FadeInImage.memoryNetwork). Version confliect, but is already in process of migrating. |
|   [CarouselSlider](https://pub.dev/packages/carousel_slider) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | Not very web friendly, should have buttons or something to indicate that it can slide. Null safety version release in dev. |
|            [Characters](https://pub.dev/packages/characters) |     ✅👌✅     |         ✅👌✅         |   ✅   |    🚫    | N/A, but definitely exposed a [bug and it's fix](https://github.com/flutter/flutter/issues/53897#issuecomment-716638453). Not showing in canvas. |
|     [DevicePreview](https://pub.dev/packages/device_preview) |     ⚠️🤷⚠️     |         🚫🙅🚫         |   🚫   |    🚫    | Wait for null safety support, or just remove it since it's useful but not crucial, and is very buggy on web. Some [workaround](https://github.com/aloisdeniel/flutter_device_preview/issues/98) for null safety |
|       [FlutterHooks](https://pub.dev/packages/flutter_hooks) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    |                                                              |
|       [FlutterIcons](https://pub.dev/packages/flutter_icons) |     ✅👌✅     |         🚫🙅🚫         |   ✅   |    ✅    | Wait for null safety [support](https://github.com/flutter-studio/flutter-icons/issues/41) . Small problem - it did not show icons the first time I rendered it, but then it showed it fine. [Might have to try this if it breaks again](https://github.com/flutter/flutter/issues/32540#issuecomment-707900491). If necessary, alternatives can be found. |
| [FlutterSlideable](https://pub.dev/packages/flutter_slidable) |     ✅👌✅     |         ✅👌✅         |   🤷   |    🤷    | N/A. Not very web friendly, should add buttons or something to indicate that it can slide open. Also seems to be verticle in web. |
|   [FlutterSpinKit](https://pub.dev/packages/flutter_spinkit) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | Wait for null safety support.                                |
| [FlutterStripePayment](https://pub.dev/packages/flutter_stripe_payment) |     🚫🙅🚫     |         🚫🙅🚫         |       |         | [A bit of a problem](#stripe).                               |
|           [FlutterSVG](https://pub.dev/packages/flutter_svg) |     ⚠️👌⚠️     |         ✅👌✅         |       |         | This one's a bit weird, since it has null safety support but not *official* web support. If we want to opt with Plan A, we could use the [PhotoView](https://pub.dev/packages/photo_view) package, but it doesn't have null safety support. I think the better option would be to opt for Plan B, where I create a [SVG Widget that conditionally uses this package or a different one](https://stackoverflow.com/a/62560528) in Web. [Another example](https://github.com/masewo/flutter_svg_web_example). ***But weirdly enough it just works if I use canvaskit.*** |
|     [FlutterSwiper](https://pub.dev/packages/flutter_swiper) |     ✅👌✅     |         🚫🙅🚫         |   ✅   |    ✅    | Wait for null safety support. May not happen since the author have not update the package since 2019. |
| [FlutterTypeAhead](https://pub.dev/packages/flutter_typeahead) |     ✅👌✅     |         🚫🙅🚫         |   ✅   |    ✅    | null safety already in pre release. Few errors being thrown due to a lack of keyboards in web, and it may have more errors, but it should be fine. |
| [FontAwesomeFlutter](https://pub.dev/packages/font_awesome_flutter) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | It's a good package but... we don't need it at all, since [FlutterIcons](https://pub.dev/packages/flutter_icons) has all the icons it does. However that library doesn't have null safety support, and this one does. Still, removing is does increasing loading speed. |
|                      [Fuzzy](https://pub.dev/packages/fuzzy) |     ✅👌✅     |         🚫🙅🚫         |   ✅   |    ✅    | Null safety in pre release. Null-safety verson in pre-released. |
|            [Get_It](https://pub.dev/packages/get_it/install) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | It's a good package but, we also won't need it, especially after we migrate to Riverpod. Have dependency conflect with current flutter (beta, 1.26.0-17.4.pre,) if using lates null-safe version (get_it 6.0.0-nullsafety.2). |
|                        [Http](https://pub.dev/packages/http) |     ✅👌✅     |         ✅👌✅         |       |         |                                                              |
|       [ImageCropper](https://pub.dev/packages/image_cropper) |     🚫🙅🚫     |         ✅👌✅         |       |         | Split web using flutter_crop_widget                          |
|         [ImagePicker](https://pub.dev/packages/image_picker) |     🚫🙅🚫     |         ✅👌✅         |       |         |                                                              |
|        [Intercom](https://pub.dev/packages/intercom_flutter) |     🚫🙅🚫     |         ✅👌✅         |       |         | Costs a lot, so we need to decide if we want to keep it or replace it with something else. If we want to keep it, we have to make it work in Flutter Web, which looks like it won't be a good implementation any time soon. If we want to replace it, I want to go with this Flutter compatible one called [Papercups](https://pub.dev/packages/papercups_flutter ). Or we don't have either. Either way, I need to stick in Segment for event tracking for stall points and admin panel data, and I want to use [Storytime](https://github.com/papercups-io/storytime) on Flutter Web. |
|                        [Intl](https://pub.dev/packages/intl) |     ✅👌✅     |         ✅👌✅         |       |         | N/A                                                          |
|       [LaunchReview](https://pub.dev/packages/launch_review) |     🚫🙅🚫     |         🚫🙅🚫         |       |         | I found something a million times better. [InAppReview](https://pub.dev/packages/in_app_review). Web doesn't have a replacement, so I just need to make the whole thing work at minimum to [send feedback to us](https://pub.dev/packages/rating_dialog) for the NPS score in the Admin Panel, and if it's a positive score and not on web it opens the in app review prompt. |
|   [MTIF](https://pub.dev/packages/mask_text_input_formatter) |     ✅👌✅     |         ✅👌✅         |       |         | N/A                                                          |
|                        [Mime](https://pub.dev/packages/mime) |     ✅👌✅     |         ✅👌✅         |       |         | N/A                                                          |
|   [PageTransition](https://pub.dev/packages/page_transition) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
|       [PathProvider](https://pub.dev/packages/path_provider) |     🚫🙅🚫     |         🚫🙅🚫         |       |         | Remove, unneeded with Web.                                   |
| [PermissionHandler](https://pub.dev/packages/permission_handler) |     🚫🙅🚫     |         ✅👌✅         |       |         | mobile only. null safe version in progress                   |
|             [PhotoView](https://pub.dev/packages/photo_view) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | null safe version under [review](https://github.com/fireslime/photo_view/issues/374) |
|      [PrettyQRCode](https://pub.dev/packages/pretty_qr_code) |     ✅👌✅     |         🚫🙅🚫         |   ✅   |    ✅    | Wait for null safety support. We can use it if we want to.   |
|                [Provider](https://pub.dev/packages/provider) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | Replace with [Riverpod](https://pub.dev/packages/hooks_riverpod) after [null-safe](https://github.com/rrousselGit/river_pod/issues/220) |
|                    [Recase](https://pub.dev/packages/recase) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
| [ReceiveSharingIntent](https://pub.dev/packages/receive_sharing_intent) |     🚫🙅🚫     |         ✅👌✅         |       |         | Probaby dont have it for the web.                            |
|                    [RxDart](https://pub.dev/packages/rxdart) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
|                      [Share](https://pub.dev/packages/share) |     🚫🙅🚫     |         ✅👌✅         |       |         | ??? (Chieh) Either Plan A: Replace with [SharePlus](https://pub.dev/packages/share_plus) or go with Plan B. |
|         [ShareExtend](https://pub.dev/packages/share_extend) |     🚫🙅🚫     |         🚫🙅🚫         |       |         | wait for null safe. might need to make our own package since author is not responsive. |
| [SharedPreferences](https://pub.dev/packages/shared_preferences) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    |                                                              |
| [SimpleAnimations](https://pub.dev/packages/simple_animations) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
|     [StripePayment](https://pub.dev/packages/stripe_payment) |     🚫🙅🚫     |         🚫🙅🚫         |       |         | There's no reliable stripe packages for mobile and web, so we need to make a full in house replacement. The good news is that the only two features the package provided was entering credit cards and verifying some specific card transactions, which will take a bit, but is possible, I think. |
|       [TimelineTile](https://pub.dev/packages/timeline_tile) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    |                                                              |
|                      [Tuple](https://pub.dev/packages/tuple) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
|         [UrlLauncher](https://pub.dev/packages/url_launcher) |     ✅👌✅     |         ✅👌✅         |   ✅   |    ✅    | N/A                                                          |
|              [Vibration](https://pub.dev/packages/vibration) |     ✅👌✅     |         ✅👌✅         |  N/A  |   N/A   | N/A                                                          |
|   [WebViewFlutter](https://pub.dev/packages/webview_flutter) |     🚫🙅🚫     |         ✅👌✅         |       |         | Since web apps don't have web view, because, it is the web, I need to find a [hack](#FlutterWebview) to show websites in the website. Going to be a problem, especially with CSR and CORS. Maybe have to solve with tabs using a dynamic import. |

## Decide between Canvas or HTML: Features

Find all the pros and cons for each of the below, and figure out what works and what doesn't on HTML and Canvas, and fill out the `HTML? | Canvas?` column, so make sure to try everything on both; things to look out for:

|                                         Feature | HTML? | Canvas? | Solution & Notes                                             |
| ----------------------------------------------: | :---: | :-----: | ------------------------------------------------------------ |
|                                          Emojis |   ✅   |   ✅⚠️✅   | More stable on html. Also a bit lagging on Canvas.           |
|                                           Fonts |       |         |                                                              |
| [SVGs]( https://github.com/dnfield/flutter_svg) |   🚫   |    ✅    | Currently having issue with html. Working on dev channel but a bit discoloration. |
|                                          Images |   ✅   |    ✅    |                                                              |
|                                         Caching |       |         |                                                              |

## Chieh

- Figure out [ImagePicker](https://pub.dev/packages/image_picker) and [ImageCropper](https://pub.dev/packages/image_cropper) - We need full replacements for this, or mish mash our own, or worst case we pull it all into our code and make it work
- Figure out [PermissionHandler](https://pub.dev/packages/permission_handler) - I think you pulled in this package
- Figure out [ReceiveSharingIntent](https://pub.dev/packages/receive_sharing_intent) - I don't think this exists on web at all, so all we have to do is make sure the feature works on android and ios and is ignored on web, probably a dynamic import
- Figure out [Share](https://pub.dev/packages/share) and [ShareExtend](https://pub.dev/packages/share_extend) - Figure out if there's a web alternative, if there is get it to work on all 3, if it doesn't make a dynamic import and ignore it on web
- Need to figure out [WebViewFlutter](https://pub.dev/packages/webview_flutter) - Since web apps don't have web view, because, it is the web, I need to find a hack to show websites in the website. Going to be a problem, especially with CSR and CORS. Maybe have to solve with tabs using a dynamic import.
- See if it's possible to have Firebase packages that aren't web ready in the code base being used in non web platforms; maybe they'll need a dynamic import with noop web mirror functions
- Help test more things and help [Decide between Canvas or HTML](#decidebetweencanvasorhtml)
  - Test every `Feature` in the Features table
  - Test every `Package` in the Packages Table

## Oindril

- Need to figure out [FlutterStripePayment](https://pub.dev/packages/flutter_stripe_payment) and [StripePayment](https://pub.dev/packages/stripe_payment) - There's no reliable stripe packages for mobile and web, so we need to make a full in house replacement. The good news is that the only two features the package provided was entering credit cards and verifying some specific card transactions, which will take a bit, but is possible, I think.
- Need to figure out [LaunchReview](https://pub.dev/packages/launch_review) - I found a million times better thing. In app review. Web doesn't have a replacement, so I just need to make the whole thing work with at minimum to send feedback to us for an NPS score in the Admin Panel, and if it's a positive score and not on web it opens the in app review prompt.
- Need to figure out [Intercom](https://pub.dev/packages/intercom_flutter) - it costs a lot, so need to decide with Andrew if we keep it or replace it with something else. If we want to keep it, we have to make it work in Flutter, if we want to replace it, I want to go with this Flutter compatible one called Papercups. Or we don't have either. Either way, I need to stick in Segment for event tracking for stall points and admin panel data.

## Improvements

- Replace Intercom with Segment + Papercups and figure out how to pull that customer data into Retool
  - https://papercups.io | https://app.papercups.io/account/overview | https://pub.dev/packages/papercups_flutter | https://github.com/papercups-io/storytime | https://pub.dev/packages/feedback
- Migrate from Provider to Riverpod
  - https://riverpod.dev
  - https://gist.github.com/c117544b0cd278f421c8b243546379f5
  - https://link.medium.com/uoKFJ1MB4cb
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
  - Add better loading screens with https://pub.dev/packages/shimmer
- Add video support
  - https://pub.dev/packages/video_player
  - https://pub.dev/packages/chewie

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
- https://www.youtube.com/watch?v=0mp-Ok00WZE

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

# SIMPLIFY:

## MINIMIZE PLATFORM SPECIFIC CODE!!!!

## MINIMIZE PACKAGES!!!!

`flutter create --description "Flutter Multi Platform Package Test" --org "com.multiplatform.test" --project-name "flutter_multi_platform_package_test" -t app .`



# 

1. Writing to firebase
2. The actual value is just null
3. Something broke
   1. It can technically be null and was not accounted for in 2
   2. It can't be null, and something is wrong with the data

General Rule: Define something as null safe, and make exceptions for being nullable

Type - Null Safe | Type? - Nullable

Easier to go Type (Null Safe) => Type? (Nullable) than Type? (Nullable) => Type (Null Safe)

# DOCUMENT MODEL GOALS:

- Have two different implementations:
  - Main Class
    - Contains fields and their types, with null-safe fields which always should have a value
      - Needs to throw if DB gives value that doesn't match
    - Contains FirebaseDocumentModel with a reference and collection, which is ignored in toMap
    - Always come from firebase, a direct mapping of the data in the backend
  - Alternative Way to:
    - Have `default<ModelName>` values where the values can be null, following the main class
    - Have a way to write data where some values don't exist, following the main class
- Any helper methods on classes should be extentions so that it supports null safe values instead of 
  - Check sub class methods get extention benefits - num to int/double
- Minimize code needed per field
  - fromMap factory boilerplate
  - toMap factory boilerplate
  - toJson, toString, equals, and Dashcode generation
- Take advantage of Object Oriented Programming
  - `extends`
  - `implements`
  - `with`



Model

^ Document Model

^ FirebaseDocumentModel





https://pub.dev/packages/chest

https://pub.dev/packages/stash

https://pub.dev/packages/simple_json_persistence

https://pub.dev/packages/moor

https://pub.dev/packages/screenshot

https://pub.dev/packages/isolate_json

https://pub.dev/packages/stack_trace/score

https://pub.dev/packages/kind

https://pub.dev/packages/equatable



https://pub.dev/packages/worker2



Icons:

https://fluttericon.com

https://pub.dev/packages/fluttericon

https://github.com/oblador/react-native-vector-icons/ | https://oblador.github.io/react-native-vector-icons/ | https://pub.dev/packages/flutter_icons#bundled-icon-sets

https://github.com/leungwensen/svg-icon



https://github.com/ant-design/ant-design-icons/tree/master/packages/icons-svg/svg



State Restoration:

- https://dev.to/pedromassango/what-is-state-restoration-and-how-to-use-it-in-flutter-5blm
- https://www.raywenderlich.com/1395-state-restoration-tutorial-getting-started











```
// the top-right of this page.

// abstract class UnsafeA<GenderType extends int?, DateTimeType extends DateTime?> {
//   GenderType? gender;
//   DateTimeType? birthday;

//   UnsafeA({
//     this.gender,
//     this.birthday,
//    });
// }

// class SafeA implements UnsafeA<int, DateTime> {
//   @override
//   int gender;
//   DateTime birthday;

//   SafeA({
//     required this.gender,
//     required this.birthday,
//    });
// }

// abstract class UnsafeA {
//   int? gender;
//   DateTime? birthday;

//   UnsafeA({
//     this.gender,
//     this.birthday,
//    });
// }

// class SafeA implements UnsafeA {
//   @override
//   int gender;
//   @override
//   DateTime birthday;

//   SafeA({
//     required this.gender,
//     required this.birthday,
//    });
// }

abstract class FirebaseDocumentModel {
  String? get reference;

  String toString() {
    return 'My reference is $reference';
  }

  bool operator ==(Object other) =>
      other is FirebaseDocumentModel && reference == other.reference;
}

class SafeFirebaseDocumentModel extends FirebaseDocumentModel {
  String reference;

  SafeFirebaseDocumentModel({required this.reference});
}

class UnsafeFirebaseDocumentModel extends FirebaseDocumentModel {
  String? reference;

  UnsafeFirebaseDocumentModel({this.reference});
}

extension FirebaseDocumentModelExtension on FirebaseDocumentModel {
  static SafeFirebaseDocumentModel safeFromMap(Map<String, Object> map) {
    return SafeFirebaseDocumentModel(
      reference: map['reference'].toString(),
    );
  }
}

abstract class UserDocumentModel {
  int? get gender;
  FirebaseDocumentModel? get firebaseDocumentModel;

  String toString() {
    return 'My gender is $gender, ${firebaseDocumentModel.toString()}';
  }

  bool operator ==(Object other) =>
      other is UserDocumentModel &&
      gender == other.gender &&
      firebaseDocumentModel == other.firebaseDocumentModel;

//   factory UserDocumentModel.fromMap(Map<String, Object> map) => SafeUserDocumentModel(
//     firebaseDocumentModel: FirebaseDocumentModelExtension.safeFromMap(map),
//     gender: int.parse(map['gender'].toString()),
//   );
}

class SafeUserDocumentModel extends UserDocumentModel {
  int gender;
  SafeFirebaseDocumentModel firebaseDocumentModel;

  SafeUserDocumentModel(
      {required this.gender, required this.firebaseDocumentModel});
}

class UnsafeUserDocumentModel extends UserDocumentModel {
  int? gender;
  UnsafeFirebaseDocumentModel? firebaseDocumentModel;

  UnsafeUserDocumentModel({this.gender, this.firebaseDocumentModel});
}

extension UserDocumentModelExtension on UserDocumentModel {
  static SafeUserDocumentModel safeFromMap(Map<String, Object> map) {
    return SafeUserDocumentModel(
      firebaseDocumentModel: FirebaseDocumentModelExtension.safeFromMap(map),
      gender: int.parse(map['gender'].toString()),
    );
  }
}

void main() {
  final UnsafeUserDocumentModel defaultUserDocumentModel =
      UnsafeUserDocumentModel();
  final UnsafeUserDocumentModel unsafeUserDocumentModel =
      UnsafeUserDocumentModel(
    gender: 1,
  );
  final UnsafeUserDocumentModel lessUnsafeUserDocumentModel =
      UnsafeUserDocumentModel(
    gender: 1,
    firebaseDocumentModel: UnsafeFirebaseDocumentModel(reference: 'users/od'),
  );
  final SafeUserDocumentModel userDocumentModel = SafeUserDocumentModel(
    gender: 1,
    firebaseDocumentModel: SafeFirebaseDocumentModel(reference: 'users/od'),
  );
  final SafeUserDocumentModel mapUserDocumentModel =
      UserDocumentModelExtension.safeFromMap({
    'gender': 2,
    'reference': 'woah',
  });
  print(defaultUserDocumentModel);
  print(userDocumentModel);
  print(mapUserDocumentModel);
  print(
      'defaultUserDocumentModel == unsafeUserDocumentModel: ${defaultUserDocumentModel == unsafeUserDocumentModel}');
  print(
      'defaultUserDocumentModel == lessUnsafeUserDocumentModel: ${defaultUserDocumentModel == lessUnsafeUserDocumentModel}');
  print(
      'defaultUserDocumentModel == userDocumentModel: ${defaultUserDocumentModel == userDocumentModel}');
  print(
      'unsafeUserDocumentModel == lessUnsafeUserDocumentModel: ${unsafeUserDocumentModel == lessUnsafeUserDocumentModel}');
  print(
      'unsafeUserDocumentModel == userDocumentModel: ${unsafeUserDocumentModel == userDocumentModel}');
  print(
      'lessUnsafeUserDocumentModel == userDocumentModel: ${lessUnsafeUserDocumentModel == userDocumentModel}');
}

```

