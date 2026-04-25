# 📝 NotesApp — iOS Notes App
 
> App #4 of my iOS Development Journey | Built with Swift + UIKit | Zero Storyboards
 
---
 
## 📱 Overview
 
NotesApp is a fully programmatic iOS notes app that lets users create, edit, delete, and search through notes — all persisted locally using CoreData. Built as part of my structured iOS curriculum to master `CoreData`, `UISearchController`, `UITextView`, and dual-mode view controllers.
 
---
 
## 🖥️ Screens
 
### 🏠 Note List Screen
- `UITableView` with custom `NoteCell` showing title, preview, and date
- `+` bar button to create a new note
- Swipe-to-delete with CoreData sync
- `UISearchController` for live title-based filtering
- Empty state message when no notes exist
- `viewWillAppear` re-fetch to always show the latest data
### ✏️ Note Editor Screen
- Title `UITextField` + body `UITextView`
- Dual mode — **Create** when opened fresh, **Edit** when existing note is passed
- Pre-fills fields in edit mode
- Live character count label updating as user types
- Save bar button — calls `createNote` or `updateNote` based on mode
- Pops back to list on save
---
 
## ⚙️ Features
 
| Feature | Detail |
|---|---|
| CoreData persistence | Notes saved locally across app launches |
| Create & Edit mode | Single `NoteEditorVC` handles both via `existingNote` optional |
| Live search | `UISearchController` filters by title in real time |
| Swipe to delete | Native swipe action synced with CoreData |
| Character count | Live label updates as user types in editor |
| Empty state | Friendly message shown when no notes exist |
| Global styling | Warm Minimal palette via `AppColors.swift` + `SceneDelegate` |
 
---
 
## 🛠️ Tech Stack
 
- **Language:** Swift
- **Framework:** UIKit
- **UI Approach:** 100% Programmatic — Zero Storyboards
- **Layout:** `NSLayoutConstraint` + `UIStackView`
- **Persistence:** CoreData (`NSManagedObject`, `NSFetchRequest`, `viewContext`)
- **Architecture:** Singleton pattern (`CoreDataManager`)
- **Navigation:** `UINavigationController` (push)
- **Search:** `UISearchController`
- **Custom Cells:** `UITableViewCell` subclass (`NoteCell`)
---
 
## 🧠 Concepts Practiced
 
| Concept | Where Used |
|---|---|
| CoreData stack | `CoreDataManager.swift` |
| `NSManagedObject` | `Note` entity |
| `NSFetchRequest` | `fetchNotes()` |
| `viewContext` save | `saveContext()` |
| Dual-mode VC | `NoteEditorVC` — create & edit via optional |
| `UISearchController` | `NoteListVC` |
| Dual array filtering | `allNotes` + `filteredNotes` |
| `UITextView` | `NoteEditorVC` body input |
| Character count | `NoteEditorVC` live label |
| `viewWillAppear` refresh | `NoteListVC` re-fetch on appear |
| Swipe to delete | `NoteListVC` + CoreData sync |
| Empty state | `NoteListVC` |
| Global styling | `AppColors.swift` + `SceneDelegate` |
 
---
 
## 📁 Project Structure
 
```
NotesApp/
├── Models/
│   └── Notes.xcdatamodeld
├── Managers/
│   └── CoreDataManager.swift
├── Controllers/
│   ├── NoteListVC.swift
│   └── NoteEditorVC.swift
├── Cells/
│   └── NoteCell.swift
└── Utilities/
    └── AppColors.swift
```
 
---
 
## 🚀 Getting Started
 
1. Clone the repo
   ```bash
   git clone https://github.com/vermagagan/NotesApp-iOS.git
   ```
2. Open `NotesApp.xcodeproj` in Xcode
3. Run on Simulator (iOS 16+)
> No third-party dependencies. No CocoaPods. Pure UIKit + CoreData.
 
---
 
## 🗺️ iOS Journey Series
 
| # | App | Key Concepts |
|---|---|---|
| 1 | Personal Business Card App | Programmatic UI, Auto Layout, UserDefaults, Modals |
| 2 | FitLife Onboarding App | UIPageViewController, UITabBarController, SceneDelegate, CATransition |
| 3 | GroceryMart | UITableView, UICollectionView, Diffable Data Source, Singleton |
| **4** | **NotesApp** | **CoreData, UISearchController, Dual-mode VC, UITextView** |
 
---
 
## 👨‍💻 Author
 
**Gagan**
Aspiring iOS Developer | Building in public
 
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com/in/vermagagan)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/vermagagan)
 
---
 
> *"Every app in this series is more complex than the last. This one had CoreData persistence, a dual-mode editor, live search filtering, and zero storyboards."*
 
