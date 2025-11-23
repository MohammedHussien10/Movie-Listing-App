## (Movie Listing App)

A native iOS application built with Swift that allows users to explore and manage movies easily.
The app provides two main categories — Top Movies of All Time and Top Movies of 2025, along with detailed information about each movie.
Users can also mark movies as favorites and access them anytime offline.

## (About the Project)

This app displays list of movies, allowing users to:

  - View Top Rated Movies of All Time

  - Explore Best Movies Released in 2025

See detailed information for each movie, including:

  - Movie poster
  
  - Title
  
  - Rating
  
  - Release year
  
  - Story summary

  - Add movies to Favorites to revisit them later.

## (Architecture)

   The project follows Clean Architecture combined with MVVM, ensuring scalability, testability, and separation of concerns.
    
   Presentation (View + ViewModel)
          ↓
   Domain (Use Cases)
          ↓
   Data (Repository + Local & Remote Sources)
    
   Layers Overview:
    
   View (Storyboard + UIKit): Handles user interface and interactions.
    
   ViewModel: Contains presentation logic and state management.
    
   Repository: Decides whether data should come from remote API or local storage.
    
   Local Data Source: Uses Core Data to store and fetch favorite movies.
    
   Remote Data Source: Fetches movies from a public API using URLSession.

## (Technologies & Tools)

  - Swift programming language
  - Storyboard (UIKit)	UI design
  - Combine	Reactive programming & data binding
  - Core Data	Local persistence for favorites
  - KeychainSwift	Secure API key storage
  - Kingfisher	Caching and loading images efficiently
  - OOP Principles	Clean, modular, and reusable code
  - Clean Architecture + MVVM	Scalable and maintainable structure
  
## ScreenShots:

<img width="406" height="866" alt="1" src="https://github.com/user-attachments/assets/237ed88a-e391-41cf-b27b-170a57d3f519" />

<img width="413" height="864" alt="2" src="https://github.com/user-attachments/assets/560a8c5a-a675-404e-a63f-3a5cd3af994b" />

<img width="413" height="860" alt="3" src="https://github.com/user-attachments/assets/b575d437-e5c9-4082-b71d-3957c9f31f9b" />



## Made by :
Mohammed Hussein |
iOS Native Developer



