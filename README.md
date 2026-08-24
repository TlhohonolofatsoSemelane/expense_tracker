# ExpenseTracker

A simple personal expense tracker built with Flutter and Dart, developed as
the final project for my Industrial Attachment / Practicum at Academic
Bridge.

## Features

- Add income and expense transactions (title, amount, category, date)
- Home dashboard showing balance, income, and expenses **for the selected month**
- Month selector (◀ ▶) on Home, Statistics, and Budgets to browse any month
- Transaction list, newest first, with swipe-to-delete
- Statistics screen with a pie chart of spending by category, per month
- **Budgets tab** — set a monthly spending limit per category, with a
  progress bar (green → orange → red) and an "over budget" warning when
  exceeded
- All data is stored locally on the device (no backend/internet required)

## Tech stack

- **Flutter** / **Dart**
- **provider** — state management
- **shared_preferences** — local persistence (transactions saved as JSON)
- **fl_chart** — the statistics pie chart
- **intl** — currency and date formatting
- **uuid** — generating unique transaction IDs

## Project structure

```
lib/
  main.dart                      # App entry point
  models/
    transaction.dart             # ExpenseTransaction model
    budget.dart                  # Budget model (category + monthly limit)
  providers/
    transaction_provider.dart    # App state: transactions, budgets, selected month
  services/
    storage_service.dart         # shared_preferences read/write for both
  screens/
    home_screen.dart             # Dashboard + transaction list + bottom nav
    add_transaction_screen.dart  # Form to add a new transaction
    statistics_screen.dart       # Pie chart of spending by category (monthly)
    budget_screen.dart           # Set/edit per-category monthly budgets
  widgets/
    summary_card.dart            # Balance / income / expense card
    transaction_tile.dart        # Single transaction row (swipe to delete)
    month_selector.dart          # ◀ Month Year ▶ navigator used on 3 screens
    budget_progress_tile.dart    # Category budget progress bar
  utils/
    categories.dart              # Category list, icons and colors
```

## How to run

1. Open the project folder in **Android Studio** (or VS Code) with the
   Flutter and Dart plugins installed.
2. Install dependencies:
   ```
   flutter pub get
   ```
3. Run on an emulator or connected device:
   ```
   flutter run
   ```

## Possible improvements

- Filter/search transactions by category or date range
- Monthly view / budget limits per category
- Export transactions to CSV
- Cloud sync (e.g. Firebase) instead of local-only storage
