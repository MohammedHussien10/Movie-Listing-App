//
//  MoviesCollectionViewCell.swift
//  Movie-Listing-App
//
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let date = UILabel()
    let rate = UILabel()
    let imdbImg = UIImageView()
    let favouritesButton = UIButton()
    var isFavourite = false
    var onFavouriteTapped: (() -> Void)?
      override init(frame: CGRect) {
          super.init(frame: frame)
          
          favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
          favouritesButton.tintColor = .systemRed
          
          imageView.contentMode = .scaleAspectFill
          imageView.clipsToBounds = true
          imageView.layer.cornerRadius = 8
          imdbImg.contentMode = .scaleAspectFill
          
         
          titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
          titleLabel.textColor = .white
          titleLabel.textAlignment = .left
          titleLabel.numberOfLines = 2
          titleLabel.lineBreakMode = .byTruncatingTail
          
          date.font = UIFont.systemFont(ofSize: 12, weight: .medium)
          date.textColor = UIColor(hex: "#66676C")
          date.textAlignment = .left
          
          rate.font = UIFont.systemFont(ofSize: 12, weight: .medium)
          rate.textColor = UIColor(hex: "#66676C")
          rate.textAlignment = .left
          


          contentView.addSubview(imageView)
          contentView.addSubview(titleLabel)
          contentView.addSubview(favouritesButton)
          contentView.addSubview(date)
          contentView.addSubview(rate)
          contentView.addSubview(imdbImg)
          
          imageView.translatesAutoresizingMaskIntoConstraints = false
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          favouritesButton.translatesAutoresizingMaskIntoConstraints = false
          date.translatesAutoresizingMaskIntoConstraints = false
          rate.translatesAutoresizingMaskIntoConstraints = false
          imdbImg.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
        
              imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
              imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              imageView.heightAnchor.constraint(equalToConstant: 180),
              
   
              favouritesButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
              favouritesButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
              favouritesButton.widthAnchor.constraint(equalToConstant: 24),
              favouritesButton.heightAnchor.constraint(equalToConstant: 24),
              
 
              titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
              titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
              titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
              

              date.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
              date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
              date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
              
      
              imdbImg.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 6),
              imdbImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
              imdbImg.widthAnchor.constraint(equalToConstant: 32),
              imdbImg.heightAnchor.constraint(equalToConstant: 16),
              imdbImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
              
          
              rate.centerYAnchor.constraint(equalTo: imdbImg.centerYAnchor),
              rate.leadingAnchor.constraint(equalTo: imdbImg.trailingAnchor, constant: 6),
              rate.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
          ])

          
          contentView.backgroundColor = UIColor(hex: "#242A32")
          contentView.layer.cornerRadius = 8
          
          favouritesButton.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    @objc private func favouriteTapped() {
        
        
        isFavourite.toggle()
 

        onFavouriteTapped?()
    }
}
