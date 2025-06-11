//
//  ViewModel.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 10.06.2025.
//

import Foundation

class ViewModel {
    var item: [Welcome]?
    
    let apiService = APIService()
    
    func fetchPhotos(page: Int, perPage: Int) async {
        guard item?.isEmpty ?? true else { return }
        do {
            let itemDTO = try await apiService.getPhotos(page: page, perPage: perPage)
            item = itemDTO.map { Welcome(form: $0) }
        } catch {
            print("Failed to fetch photos: \(error)")
        }
    }
}
