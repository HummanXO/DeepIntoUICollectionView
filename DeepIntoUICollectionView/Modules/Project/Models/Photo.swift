//
//  Photo.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 12.06.2025.
//

import Foundation

struct Photo {
    let id: String
    let urls: Urls
    let name: String
    let altDescription: String?
    let likes: Int
    
    init(from photoDTO: PhotoDTOElement) {
        self.id = photoDTO.id
        self.urls = photoDTO.urls
        self.name = photoDTO.user.username
        self.altDescription = photoDTO.altDescription
        self.likes = photoDTO.likes
    }
}
