//
//  ViewController.swift
//  Movie-Listing-App
//
//

import UIKit
import KeychainSwift
import Combine
import Kingfisher
class MovieList: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    private var collectionView: UICollectionView!
    @IBOutlet weak var moviesTable: UITableView!
    let moviesViewModel = MoviesViewModel(getMoviesUseCase: UseCaseMovieListImpl(repo: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl())))
    
    var favourtiesViewModel = FavouritesViewModel(useCaseMovieList: UseCaseMovieListImpl(repo: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl())))
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesTable.reloadData()
        collectionView.reloadData()
        navigationAndTableViewSetUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindMovies()
        moviesViewModel.fetchMovies()
    }
    
    
    private func bindMovies(){
        moviesViewModel.$topRatedMovies.receive(on: DispatchQueue.main).sink {[weak self] _ in
            self?.moviesTable.reloadData()
        }.store(in: &cancellables)
        
        moviesViewModel.$allTimeMovies.receive(on: DispatchQueue.main).sink {[weak self] _ in
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.topRatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Movies_List_Cell", for: indexPath) as? MoviesViewCell else{
            
            
            return UITableViewCell()
        }
        
        
        let movies = moviesViewModel.topRatedMovies[indexPath.row]
        
        cell.movieTitle.text = movies.title
        let ratingString = String(format: "%.1f", movies.vote_average ?? 0.0)
        cell.rating.text = ratingString
        if let movieImg = movies.poster_path{
            let fullURL = "https://image.tmdb.org/t/p/w500\(movieImg)"
            cell.movieImg.kf.setImage(with: URL(string: fullURL),placeholder: UIImage(named: "loadingMovie"))
        }
        else{
            cell.movieImg.image = UIImage(named: "loadingMovie")
        }
        
        cell.releaseDate.text = movies.release_date?.onlyYear ?? "N/A"
        
        cell.selectionStyle = .none
        let isFav = favourtiesViewModel.isFavourite(id: movies.id)
        let imageName = isFav ? "heart.fill" : "heart"
        cell.favouritesButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.onFavouriteTapped =  { [weak self] in
            guard let self = self else { return }
            if self.favourtiesViewModel.isFavourite(id: movies.id) {
                self.favourtiesViewModel.removeMovie(id: movies.id)
                cell.favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                self.favourtiesViewModel.addMovie(movie: movies)
                cell.favouritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModelDetails = moviesViewModel.topRatedMovies[indexPath.row]
        
        
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetails") as? MovieDetails else { return }
        
        detailsVC.movieDetailsViewModel = MovieDetailsViewModel(movie: viewModelDetails)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top 2025 Movies"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            header.textLabel?.textColor = .white
            header.contentView.backgroundColor = UIColor(hex: "#242A32")
        }
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesViewModel.allTimeMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MoviesCollectionViewCell else{
            return  UICollectionViewCell()
        }
        
        
        let movies = moviesViewModel.allTimeMovies[indexPath.item]
        
        cell.titleLabel.text = movies.title
        cell.date.text = movies.release_date?.onlyYear ?? "N/A"
        let ratingString = String(format: "%.1f", movies.vote_average ?? 0.0)
        cell.rate.text = ratingString
        cell.imdbImg.image = UIImage(named: "imdb")
        if let movieImg = movies.poster_path{
            let fullURL = "https://image.tmdb.org/t/p/w500\(movieImg)"
            cell.imageView.kf.setImage(with: URL(string: fullURL),placeholder: UIImage(named: "loadingMovie"))
        }
        else{
            cell.imageView.image = UIImage(named: "loadingMovie")
        }
        
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        let isFav = favourtiesViewModel.isFavourite(id: movies.id)
        let imageName = isFav ? "heart.fill" : "heart"
        cell.favouritesButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.onFavouriteTapped =  { [weak self] in
            guard let self = self else { return }
            if self.favourtiesViewModel.isFavourite(id: movies.id) {
                self.favourtiesViewModel.removeMovie(id: movies.id)
                cell.favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                self.favourtiesViewModel.addMovie(movie: movies)
                cell.favouritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width * 0.9, height: 320)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    
    private func setupCollectionView() {
        let headerLabel = UILabel()
        headerLabel.text = "Top Movies All Time"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        headerLabel.textColor = .white
        
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
            
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 260)
        layout.minimumLineSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            collectionView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModelDetails = moviesViewModel.allTimeMovies[indexPath.row]
        
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetails
        
        detailsVC.movieDetailsViewModel = MovieDetailsViewModel(movie: viewModelDetails)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func navigationAndTableViewSetUp() {
        moviesTable.dataSource = self
        moviesTable.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.barTintColor = UIColor(hex: "#242A32")
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.backgroundColor = UIColor(hex: "#242A32")
        moviesTable.showsVerticalScrollIndicator = false
    }
    
    
    
    
}

