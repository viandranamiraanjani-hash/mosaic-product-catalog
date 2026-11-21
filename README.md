
# MOSAIC — Curated Boutique

**Different Finds, One Place.**

MOSAIC is a Flutter-based product catalog application designed with a curated boutique concept. It provides users with a clean and elegant shopping discovery experience, allowing them to browse products, explore categories, search for items, and view product details.

## Features

- **Product Catalog** — Browse products with images, names, prices, categories, and ratings.
- **Product Details** — View detailed product information, including descriptions and ratings.
- **Category Filtering** — Filter products by category.
- **Product Search** — Search products by title.
- **Network Error Handling** — Handle connection failures, request timeouts, and invalid API responses.
- **Retry Mechanism** — Retry failed requests when the connection is restored.
- **Image Error Handling** — Display a fallback interface when product images cannot be loaded.
- **Responsive UI** — Clean and organized interface with a curated boutique visual identity.

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application development |
| Dart | Programming language |
| Provider | State management |
| HTTP | REST API communication |
| Google Fonts | Typography |
| Fake Store API | Product data source |

## Architecture

The application uses a layered architecture to separate responsibilities and improve maintainability.

```text
lib/
├── main.dart
│
├── core/
│   ├── error/
│   ├── network/
│   └── theme/
│       └── app_theme.dart
│
└── features/
    └── products/
        ├── data/
        │   ├── models/
        │   │   └── product_model.dart
        │   ├── repositories/
        │   │   └── product_repository.dart
        │   └── sources/
        │       └── product_api_service.dart
        │
        ├── domain/
        │
        └── presentation/
            ├── pages/
            │   ├── product_catalog_page.dart
            │   └── product_detail_page.dart
            ├── state/
            │   └── product_provider.dart
            └── widgets/
                └── product_card.dart
```

### Layer Responsibilities

- **Core** — Shared application configuration and theme.
- **Data** — Product models, API communication, and repository implementation.
- **Domain** — Reserved for domain-specific business logic.
- **Presentation** — User interface, reusable widgets, and state management.

## API Source

MOSAIC uses the [Fake Store API](https://fakestoreapi.com/) to retrieve product information.

Available endpoints:

- `GET /products` — Retrieve all products.
- `GET /products/categories` — Retrieve product categories.
- `GET /products/category/{category}` — Retrieve products by category.
- `GET /products/{id}` — Retrieve product details.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Android Emulator or a physical device
- Internet connection

### Installation

1. Clone the repository:

   bash
   git clone https://github.com/viandranamiraanjani-hash/mosaic-product-catalog.git
   

2. Navigate to the project directory:

   bash
   cd product_catalog
   

3. Install dependencies:

   bash
   flutter pub get
   

4. Run the application:

   bash
   flutter run
   

## Testing

Run automated tests:

bash
flutter test


Check code quality:

bash
flutter analyze


## Screenshots

Application screenshots will be added here.

## Project Information

**Project Name:** MOSAIC — Curated Boutique  
**Platform:** Flutter  
**Category:** Product Catalog Application  
**API:** Fake Store API

---

*Different Finds, One Place.*
