# Netflix UI

A Flutter movie discovery UI inspired by [Netflix Mobile App Redesign](https://dribbble.com/shots/5026483-Netflix-Mobile-App-Redesign/). The app includes a featured-title carousel, local title search, a saved-state control, and movie detail pages. Playback and sharing are visual demo actions; they are not connected to a streaming service.

## Summary

This update modernizes the original UI prototype with null-safe, immutable movie models; a consistent Netflix red theme; and a carousel that correctly disposes its controller. You can search the bundled titles and open a details page, where the My List control toggles saved state for the current session. The layouts include accessibility labels, and the bundled artwork keeps the app usable offline. Search and saved state use local sample data; there is no streaming backend or persistent account storage.

## Requirements

- Flutter SDK with Dart 2.17 or later

## Run

```sh
flutter pub get
flutter run
```

The movie catalog and artwork are bundled in `assets/images/` and the app works offline. To add a title, update the `movies` collection in `lib/models/MyModels.dart` and include its artwork in the asset directory.

## Screenshots

| Home | Details |
| --- | --- |
| ![Home screen](screenshots/Screenshot_1.png) | ![Details screen](screenshots/Screenshot_2.png) |
