//
//  DataBaseManager.swift
//  Movie-Listing-App
//
//

import Foundation
import CoreData
import Combine
class DataBaseManager{
    static let shared = DataBaseManager()
    
    lazy var persistentContainer : NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Movie_Listing_App")
        
        container.loadPersistentStores{ _,error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
        
        return container
        
    }()
    
    var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            } catch{
                print("Save failed: \(error)")
            }
        }
    }
    
    func addMovieToFavourites(id:Int ,title:String, posterPath:String,releaseDate : String,voteAverage : Double,backdropPath: String,overView: String){
        
        let movie = MovieEntity(context: context)
        movie.id = Int64(id)
        movie.title = title
        movie.poster_path = posterPath
        movie.release_date = releaseDate
        movie.vote_average = voteAverage
        movie.backdrop_path = backdropPath
        movie.overview = overView
        movie.isFavourite = true
        saveContext()
        
    }
    
    func fetchFavourites() ->[Movie]{
        let request : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavourite == true")
        
        do{
            let entities = try context.fetch(request)
                return entities.map { entity in
                          Movie(
                              id: Int(entity.id),
                              title: entity.title ?? "",
                              poster_path: entity.poster_path,
                              release_date: entity.release_date,
                              vote_average: entity.vote_average,
                              backdrop_path: entity.backdrop_path,
                              overview: entity.overview
                          )
                      }
                
        
        }catch{
            print("Fetch failed: \(error)")
            return []
        }
        
    }
    
    
    func removeMovie(id: Int) {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %d AND isFavourite == YES", id)
        
        do {
            let movies = try context.fetch(request)
            
            for movie in movies{
                context.delete(movie)
            }
            saveContext()
        } catch{
            print("Delete failed: \(error)")
            
        }
        
        
      
    }
    func isFavourite(id: Int) -> Bool {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Check failed: \(error)")
            return false
        }
        
    }
    
    func saveMovies(_ movies: [Movie], for category: MovieCategory) {
        
        let request:NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate  = NSPredicate(format: "category == %@", category.endPoint)
        
        do{
            let oldMovies = try context.fetch(request)
            
            for movie in oldMovies{
                context.delete(movie)
            }
            
            for movie in movies{
                let entity = MovieEntity(context: context)
                entity.id = Int64(movie.id)
                entity.title = movie.title
                entity.poster_path = movie.poster_path
                entity.release_date = movie.release_date
                entity.vote_average = movie.vote_average ?? 0.0
                entity.backdrop_path = movie.backdrop_path
                entity.overview = movie.overview
                entity.category = category.endPoint
            }
            
            saveContext()
        }catch{
            print("Failed to save movies: \(error)")
        }
        
    }
    
    func getMoviesLocal(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", category.endPoint)
        do {
            let entities = try context.fetch(request)
            let movies = entities.map { entity in
                
                Movie(
                    id: Int(entity.id),
                    title: entity.title ?? "",
                    poster_path: entity.poster_path,
                    release_date: entity.release_date,
                    vote_average: entity.vote_average,
                    backdrop_path: entity.backdrop_path,
                    overview: entity.overview
                )
                
            }
            return Just(movies).setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        }catch{
            print("Fetch local movies failed: \(error)")
                   return Just([]).setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
    }
}
