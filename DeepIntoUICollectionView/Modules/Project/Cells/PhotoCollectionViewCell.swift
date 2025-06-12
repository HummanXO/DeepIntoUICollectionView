//
//  PhotoCollectionViewCell.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 12.06.2025.
//

import UIKit
import SkeletonView

class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Static Properties
    static let reuseIdentifier = "PhotoCollectionViewCell"
    private static let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - UIElements
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let altDescriptionLabel = UILabel()
    let likesLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupImageView()
        setupDescription()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    private func setupView() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.isSkeletonable = true
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .secondarySystemBackground
        imageView.isSkeletonable = true
    }
    
    private func setupDescription() {
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.numberOfLines = 1
        
        altDescriptionLabel.font = .preferredFont(forTextStyle: .caption1)
        altDescriptionLabel.numberOfLines = 2
        altDescriptionLabel.lineBreakMode = .byTruncatingTail
        
        likesLabel.font = .preferredFont(forTextStyle: .caption1)
        likesLabel.numberOfLines = 1
    }
    
    private func setupConstraints() {
        [imageView, nameLabel, altDescriptionLabel, likesLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            altDescriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            altDescriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            altDescriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            likesLabel.topAnchor.constraint(equalTo: altDescriptionLabel.bottomAnchor, constant: 8),
            likesLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with photo: Photo) {
        imageView.image = nil
        nameLabel.text = photo.name
        altDescriptionLabel.text = photo.altDescription
        likesLabel.text = "❤️: \(photo.likes)"
        
        guard
            let url = URL(string: photo.urls.small)
        else { return }
        
//        if let cachedImage = Self.imageCache.object(forKey: photo.urls.small as NSString) {
//            imageView.image = cachedImage
//            return
//        }
        
        startSkeletonAnimation()
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
//            Self.imageCache.setObject(image, forKey: photo.urls.small as NSString)
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.hideSkeleton()
            }
        }.resume()
    }
}
