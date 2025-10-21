//
//  MoviesViewCell.swift
//  Movie-Listing-App
//
//  Created by Macos on 20/09/2025.
//

import UIKit

class MoviesViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var favouritesButton: UIButton!
    
    
    
    var isFavourite = false
    var onFavouriteTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImg.layer.cornerRadius = 12
        movieImg.clipsToBounds = true
        
        
        favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favouritesButton.tintColor = .systemRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func isFavourite(_ sender: Any) {
       
        isFavourite.toggle()
        onFavouriteTapped?()
    }
    
}
