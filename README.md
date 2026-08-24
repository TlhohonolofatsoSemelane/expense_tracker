# ExpenseTracker

A simple, offline personal expense tracker built with Flutter and Dart —
developed as the final capstone project for my Industrial Attachment /
Practicum at [Academic Bridge](https://academicbridge.xyz/).

<p align="center">
  <img src="<img width="202" height="409" alt="image" src="https://github.com/user-attachments/assets/0e30ee78-8650-425d-bfa9-c0b2a48b1625" />
" width="200" />
  <img src="screenshots/budgets.png" width="200" />
  <img src="screenshots/statistics.png" width="200" />
</p>

## Features

- 💵 Add income and expense transactions (title, amount, category, date)
- 📊 Home dashboard showing balance, income, and expenses **for the selected month**
- 📅 Month selector (◀ ▶) to browse income, expenses, and category breakdowns for any month
- 📝 Transaction list, newest first, with swipe-to-delete
- 🥧 Statistics screen with a pie chart of spending by category, per month
- 🎯 **Budgets tab** — set a monthly spending limit per category, with a
  progress bar (green → orange → red) and an "over budget" warning when exceeded
- 💾 All data stored locally on the device (shared_preferences) — fully offline, no backend required

## Screenshots

| Home | Add Transaction | Budgets |
|:---:|:---:|:---:|
| ![Home](screenshots/home.png) | ![Add Transaction](screenshots/add_expense.png) | ![Budgets](screenshots/budgets.png) |

| Statistics | Add Income |
|:---:|:---:|
| ![Statistics](screenshots/statistics.png) | ![Add Income](screenshots/add_income.png) |

## Tech stack

- **Flutter** / **Dart**
- **provider** — state management
- **shared_preferences** — local persistence (transactions and budgets saved as JSON)
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
screenshots/                     # App screenshots used in this README
```

## Getting started

1. Clone the repo:
   ```bash
   git clone https://github.com/<your-username>/expense_tracker.git
   cd expense_tracker
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. If the platform folders (`android/`, `ios/`, etc.) aren't present, generate them:
   ```bash
   flutter create .
   ```
4. Run on an emulator or connected device:
   ```bash
   flutter run
   ```

## Background

This app was built during my Industrial Attachment at Academic Bridge
(Mobile App Development team), as part of the requirements for my Bachelor
of Science in Software Engineering at the Adventist University of Central
Africa (AUCA). It demonstrates Dart/Flutter fundamentals, state management
with Provider, local data persistence, and data visualization — the core
skills covered during the attachment.

## Possible improvements

- Filter/search transactions by category or date range
- Budget notifications/alerts
- Export transactions to CSV
- Cloud sync (e.g. Firebase) instead of local-only storage

## License

This project was built for educational purposes as part of a university
internship. Feel free to fork and adapt it.
