# 📞 Contact Manager App

A sleek, responsive, and modern Flutter application that manages a list of contacts by consuming endpoints from the JSONPlaceholder API. This project implements full CRUD (Create, Read, Update, Delete) operations wrapped in a highly responsive and custom presentation layer.

## 🚀 Features
- **Read (Fetch Contacts):** On initialization, data is fetched via REST endpoints with smooth loading states.
- **Create (Add Contact):** Users can dynamically add new contacts through an integrated validation form, updating the UI immediately.
- **Update (Edit Contact):** Provides real-time editing capability for existing user contact details.
- **Delete (Remove Contact):** Includes a clear preventive confirmation `AlertDialog` modal to protect against accidental deletions.

## 🛠️ Architecture & Tech Stack
- **State Management:** **BLoC (Business Logic Component)** Pattern using the `flutter_bloc` package to separate UI from business logic.
- **Network Client:** **Dio** network package for handling HTTP requests, response parsing, and state updates cleanly.
- **UI Architecture:** Built entirely using custom, reusable **Containers and Cards** featuring custom elevation shadows, status chips, and layout spacing for a clean, non-generic look.
- **Data Layer:** Strict implementation of the Repository Pattern utilizing a specialized `Contact` data model.



## 🏃 Getting Started & Installation

Follow these steps to run the project locally on your machine:

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/Melikamohammed1/Contact_Manager_app.git](https://github.com/Melikamohammed1/Contact_Manager_app.git)