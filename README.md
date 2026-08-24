# ExpenseTracker

A simple personal expense tracker built with Flutter and Dart, developed as
the final project for my Industrial Attachment / Practicum at [Academic Bridge](https://academicbridge.xyz/).

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

## Screenshots

### Home Dashboard

<img width="202" height="409" alt="image" src="https://github.com/user-attachments/assets/6ff114cc-c515-4d1c-a320-c56a68cdf032" />

### Budgets

<img width="207" height="414" alt="Budgets" src="https://github.com/user-attachments/assets/72a80923-1c16-44cb-99bf-f34c65719f7e" />

### Statistics

<img width="208" height="416" alt="Statistics" src="https://github.com/user-attachments/assets/5618b32b-701b-452f-8b4a-cf596ce1aefe" />

### Add Expenses

<img width="202" height="418" alt="AddExpense" src="https://github.com/user-attachments/assets/9a3c5c43-621a-4858-b015-90f7ac6d6af7" />

### Add Incomes

<img width="197" height="412" alt="AddIncome" src="https://github.com/user-attachments/assets/060aa7f1-56fe-4bd7-b87d-95bbe420e554" />

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

## Background

This app was built during my Industrial Attachment at Academic Bridge
(Mobile App Development team), as part of the requirements for my Bachelor
of Science in Software Engineering at the Adventist University of Central
Africa (AUCA). It demonstrates Dart/Flutter fundamentals, state management
with Provider, local data persistence, and data visualization — the core
skills covered during the attachment.
