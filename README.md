# LawyerSpot — Flutter App

A Flutter rebuild of the LawyerSpot lawyer-marketplace prototype: splash screen,
sign in, a 4-step lawyer sign-up flow, dashboard, consultations, Q&A, profile
editing, statistics, account/settings, and notifications.

## Structure

```
lib/
  main.dart                     # App entry + route table
  theme/app_theme.dart          # Colors, text styles, ThemeData
  widgets/common.dart           # Shared widgets (cards, buttons, chips, app bar)
  screens/
    splash_screen.dart
    login_screen.dart
    signup_flow.dart            # 4-step wizard + success screen
    home_shell.dart             # Bottom-nav shell (5 tabs)
    dashboard_screen.dart
    consultations_list_screen.dart
    consultation_detail_screen.dart
    edit_profile_screen.dart
    qa_browse_screen.dart
    question_detail_screen.dart
    qa_history_screen.dart
    statistics_screen.dart
    account_screen.dart
    notifications_screen.dart
```

## Running it

1. Make sure you have the Flutter SDK installed (`flutter --version`).
2. From this folder:
   ```bash
   flutter pub get
   flutter run
   ```
3. Flow: Splash → Login (tap "Sign Up" for the onboarding wizard) → Home
   (bottom nav: Dashboard / Consultations / Q&A / Profile / Account).

## Notes on the conversion

- Fonts: Manrope (body/UI) and Playfair Display (display/headline), loaded
  via `google_fonts` — no manual font files needed.
- Colors: mapped from the original Tailwind tokens into `AppColors`
  (deep navy `primary`/`primary-container`, gold `secondary` accents,
  ivory background).
- Material Symbols Outlined icons were mapped to their closest Flutter
  Material equivalents (e.g. `event_note`, `quiz`, `person_pin`, `gavel`).
- The bar/line charts on the Statistics screen are drawn with plain
  `Container`s and a small `CustomPainter`, so no charting package is
  required — swap in `fl_chart` later if you want richer interactivity.
- Photo upload on Sign-Up step 4 is a placeholder tap target; wire up
  `image_picker` if you want real photo selection.
- State is local/in-memory (no backend) — hook up your API client of
  choice (e.g. `dio`/`http` + a state manager like `provider` or `riverpod`)
  to make this fully functional.
