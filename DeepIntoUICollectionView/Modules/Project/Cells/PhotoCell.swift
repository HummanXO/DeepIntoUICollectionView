//
//  PhotoCell.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 11.06.2025.
//

import UIKit
import SkeletonView

class PhotoCell: UICollectionViewCell {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let altDescriptionLabel = UILabel()
    let likesLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
        setupDescriptionLabels()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.hideSkeleton()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDescriptionLabels() {
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 1
        
        altDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        altDescriptionLabel.textColor = .secondaryLabel
        altDescriptionLabel.numberOfLines = 2
        altDescriptionLabel.lineBreakMode = .byTruncatingTail
        
        likesLabel.font = .systemFont(ofSize: 12, weight: .regular)
        likesLabel.textColor = .secondaryLabel
        likesLabel.numberOfLines = 1
    }
    
    private func setupImage() {
        contentView.isSkeletonable = true
        imageView.isSkeletonable = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
    }
    
    private func setupConstraints() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        
        [imageView, nameLabel, altDescriptionLabel, likesLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
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
    
    func configure(with welcome: Welcome) {
        nameLabel.text = welcome.name
        altDescriptionLabel.text = welcome.altDescription
        likesLabel.text = "❤️: \(welcome.likes)"
        
        imageView.image = nil
        
        if let cachedImage = Self.imageCache.object(forKey: welcome.url as NSString) {
            imageView.image = cachedImage
            return
        }

        guard let url = URL(string: welcome.url) else { return }

        imageView.showAnimatedGradientSkeleton()
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil,
                  let image = UIImage(data: data) else { return }

            Self.imageCache.setObject(image, forKey: welcome.url as NSString)

            DispatchQueue.main.async {
                self.imageView.image = image
                self.imageView.hideSkeleton()
            }
        }.resume()
    }
    
}
