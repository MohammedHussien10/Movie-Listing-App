//
//  Favourites.swift
//  Movie-Listing-App
//
//

import UIKit
import Combine

class Favourites: UIViewController,UITableViewDataSource, UITableViewDelegate{
 
    @IBOutlet weak var favourtiesTable: UITableView!
    
    var favourtiesViewModel = FavouritesViewModel(useCaseMovieList: UseCaseMovieListImpl(repo: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl())))
    
    private var cancellables = Set<AnyCancellable>()
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favourtiesViewModel.getFavourites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        bindMovies()
        favourtiesTable.dataSource = self
        favourtiesTable.delegate = self

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourtiesViewModel.favourites.count
    }
    
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Movies_List_Cell", for: indexPath) as? MoviesViewCell else{
            
          
            return UITableViewCell()
        }
        
        
        let movies = favourtiesViewModel.favourites[indexPath.row]
        
        cell.movieTitle.text = movies.title
        cell.rating.text = String(format: "%.1f", movies.vote_average ?? 0.0)
        if let movieImg = movies.poster_path{
            let fullURL = "https://image.tmdb.org/t/p/w500\(movieImg)"
            cell.movieImg.kf.setImage(with: URL(string: fullURL),placeholder: UIImage(named: "loadingMovie"))
        }
        else{
            cell.movieImg.image = UIImage(named: "loadingMovie")
        }
        
        cell.releaseDate.text = movies.release_date?.onlyYear ?? "N/A"
        
        cell.selectionStyle = .none
        
        let isFav = favourtiesViewModel.isFavourite(id: Int(movies.id))
        let imageName = isFav ? "heart.fill" : "heart"
        cell.favouritesButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.onFavouriteTapped =  { [weak self] in
            guard let self = self else { return }
            if self.favourtiesViewModel.isFavourite(id: Int(movies.id)) {
                self.favourtiesViewModel.removeMovie(id: Int(movies.id))
                cell.favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movies = favourtiesViewModel.favourites[indexPath.row]
        
        
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetails") as? MovieDetails else { return }
        
        detailsVC.movieDetailsViewModel = MovieDetailsViewModel(movie: movies)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    
    private func bindMovies(){
        favourtiesViewModel.$favourites
                  .receive(on: DispatchQueue.main)
                  .sink { [weak self] movies in
                      self?.favourtiesTable.reloadData()
                      
                      for i in movies{
                          print(i)
                      }
                  }
                  .store(in: &cancellables)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
