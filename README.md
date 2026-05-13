# 🛒 GroceryMart — iOS Shopping App
> App #3 of my iOS Development Journey | Built with Swift + UIKit | Zero Storyboards
 
## 📱 Overview
A fully programmatic iOS grocery app to browse products by category and manage a real-time shopping cart with shared state across all screens.
 
---
 
## 🖥️ Screenshots
 
| Home | Product Detail | Cart |
|---|---|---|
| ![Home](Screenshots/home.png) | ![Detail](Screenshots/detail.png) | ![Cart](Screenshots/cart.png) |
 
---
 
## 🖥️ Screens
- **Home** — Category chips (`UICollectionView`) + filtered product list (`UITableView`) + live cart badge + pull to refresh
- **Product Detail** — Large SF Symbol, name, price, description, Add to Cart
- **Cart Modal** — All items, live total, swipe-to-delete, empty state
## ⚙️ Features
| Feature | Detail |
|---|---|
| Category filtering | Animated via Diffable Data Source |
| Shared cart state | `CartManager` singleton across all screens |
| Live badge count | Updates on every add/remove |
| Swipe to delete | Native `UITableView` swipe action |
| Pull to refresh | `UIRefreshControl` on Home |
 
## 🛠️ Tech Stack
Swift · UIKit · Programmatic UI · `NSDiffableDataSource` · `NSDiffableDataSourceSnapshot` · Singleton (`CartManager`) · `UINavigationController` · Modal presentation · Custom cells
 
## 🧠 Concepts Practiced
`UITableView` datasource/delegate · Custom `UITableViewCell` · `UICollectionView` · Diffable Data Source · Swipe to delete · Pull to refresh · Nav bar badge · Singleton pattern · Modal + push navigation
 
## 🚀 Getting Started
```bash
git clone https://github.com/vermagagan/GroceryMart-iOS.git
```
Open `GroceryMart.xcodeproj` in Xcode · Run on iOS 16+ · No dependencies.
 
## 👨‍💻 Author
**vermagagan** · Aspiring iOS Developer · Building in public
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com/in/vermagagan) [![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/vermagagan)
 
> *"Custom cells, a shared singleton, animated diffable updates, and zero storyboards."*
