//
//  README.md
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 5/7/25.
//

# CreditCardRec

[![Swift Version](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)
[![iOS Version](https://img.shields.io/badge/iOS-18%2B-blue.svg)](https://developer.apple.com/ios)

A SwiftUI iOS app for managing your credit cards and finding the best one to use based on cash‐back rates. It features animated card stacks, dynamic category filters, and smooth matched‐geometry transitions.

---

## Table of Contents

* [Features](#features)
* [Architecture](#architecture)
* [Setup & Installation](#setup--installation)
* [Usage](#usage)
* [Future Improvements](#future-improvements)
* [Contributing](#contributing)

---

## Features

* **Cards Tab**

  * Animated, collapsible stack of your wallet’s cards
  * Tap to expand and view detailed cash‑back breakdowns
* **Find Best Card Tab**

  * Select one or more spending categories via fluid circular buttons
  * “OK” sorts your cards by single‑category or average cash‑back
* **Profile Management**

  * Search overlay to add new cards by name
  * Edit or delete existing cards
* **Smooth Animations**

  * `matchedGeometryEffect` for hero transitions
  * Spring‑based animations with custom delays

---

## Architecture

```
CreditCardRec/
├── README.md
├── CreditCardRec/ # Main Xcode group
│ ├── APICall/ # Networking layer
│ │ ├── NetworkService.swift # Async/await HTTP client
│ │ ├── Post.swift # Decodable model for test API
│ │ └── PostsListView.swift # SwiftUI view demonstrating fetch
│ │
│ ├── DebugProperties/ # Utilities & debug tools
│ │ └── Boarder.swift # View modifier for debug borders
│ │
│ ├── Model/ # Core data types & business logic
│ │ ├── Card.swift # Card model (Identifiable, Hashable)
│ │ ├── CashBack.swift # Cashback area & rate model
│ │ └── UserData.swift # ObservableObject for shared state
│ │
│ ├── Views/ # All SwiftUI views, organized by feature
│ │ ├── CardViews/ # Card‐related screens & components
│ │ │ ├── CardsView.swift # Animated card stack container
│ │ │ ├── CardView.swift # Individual card UI + animations
│ │ │ ├── CashBackView.swift # Expanded cashback detail view
│ │ │ └── ExpenseCardView.swift # Single‐line expense row
│ │ │
│ │ ├── FindCardViews/ # “Find Best Card” feature
│ │ │ ├── FindBestCardView.swift # Main picker + results view
│ │ │ ├── CardRebateRowView.swift # Card + rebate row layout
│ │ │ ├── FindCardSearchOverlayView.swift # Category overlay
│ │ │ └── SearchBarView.swift # Collapsible category bar
│ │ │
│ │ └── Overlays/ # Shared overlay components
│ │ ├── SearchOverlayView.swift # Card‐addition overlay
│ │ ├── ProfileView.swift # Manage & edit user cards
│ │ └── ContentView.swift # TabView + global overlays
│ │
│ └── Assets/ # Images, colors, previews
│
└── CreditCardRec.entitlements # iCloud/CloudKit entitlements
```

* **SwiftUI** for declarative UI
* **Core Data** + **CloudKit** for local + cloud‑sync storage
* **Async/Await** (future) for network calls
* **`ObservableObject`** & **`@EnvironmentObject`** for shared state

---

## Setup & Installation

1. **Requirements**

   * Xcode 15 or later
   * iOS 18+ deployment target

2. **Clone & Open**

   ```bash
   git clone https://github.com/Protactini/CreditCardRec.git
   cd CreditCardRec
   open CreditCardRec.xcodeproj
   ```

3. **Build & Run**

   * Select your simulator or device
   * Press **⌘R**

---

## Usage

1. **Cards Tab**

   * Tap **+** to add a new card via the profile overlay
   * Tap a card to expand and view its detailed cash‑back list

2. **Find Best Card Tab**

   * Tap the search bar to expand category picker
   * Tap one or more categories (they animate into the bar)
   * Press **OK** to sort your cards by cashback rate
   * Tap the pill in the bar to remove a category

---

## Future Improvements

* **Real API Integration**: Fetch card data from a backend service
* **Apple Pay Simulation**: Intercept “Tap to Pay” and auto‑select optimal card
* **Theming & Dark Mode**: Custom color palettes & automatic support
* **Localization**: Support for multiple languages

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request
