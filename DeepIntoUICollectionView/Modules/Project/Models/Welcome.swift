//
//  Welcome.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 11.06.2025.
//

import Foundation

struct Welcome {
    var id: String
    var url: String
    var name: String
    var altDescription: String
    var likes: Int
    
    init(form dto: WelcomeElement) {
        self.id = dto.id
        self.url = dto.urls.small
        self.name = dto.user.name
        self.altDescription = dto.altDescription
        self.likes = dto.likes
    }
}
