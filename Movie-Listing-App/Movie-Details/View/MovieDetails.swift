//
//  Movie_Details.swift
//  Movie-Listing-App
//
//  Created by Macos on 12/09/2025.
//

import UIKit

class MovieDetails: UIViewController {
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDate: UILabel!
    
    
    @IBOutlet weak var movieStory: UILabel!
    
    var movieDetailsViewModel : MovieDetailsViewModel?
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        guard let vDetails = movieDetailsViewModel else{return}
        
          movieTitle.text = vDetails.movie.title
        movieDate.text  =  ( vDetails.movie.release_date?.onlyYear ?? "N/A")
        
        
          movieRating.text = String(format: "%.1f", vDetails.movie.vote_average ?? 0.0)
          movieStory.text = vDetails.movie.overview
        
        if let poster = vDetails.movie.poster_path{
            let fullURL = "https://image.tmdb.org/t/p/w500\(poster)"
            movieImg.kf.setImage(with: URL(string: fullURL),placeholder: UIImage(named: "loadingMovie"))
        }
        
        if let backdrop = vDetails.movie.backdrop_path{
            let fullURL = "https://image.tmdb.org/t/p/w500\(backdrop)"
            moviePoster.kf.setImage(with: URL(string: fullURL),placeholder: UIImage(named: "loadingMovie"))
        }
        
        

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
