//
//  PhotoGalleryViewModel.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 12.06.2025.
//

import Foundation

class PhotoGalleryViewModel {
    var photos: [Photo] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    private var isLoading = false
    
    private let apiService = APIService()
    
    public var onDataUpdated: (() -> Void)?
    
    public func reloadData(completionHendler: @escaping () -> Void) {
        photos = []
        load(page: 1, perPage: 20, completionHendler: completionHendler)
    }
    
    public func load(page: Int, perPage: Int, completionHendler: @escaping () -> Void) {
        guard isLoading == false else { return }
        
        isLoading = true
        Task {
            await fetchPhotos(page: page, perPage: perPage)
            DispatchQueue.main.async {
                completionHendler()
                self.isLoading = false
            }
        }
    }
    
    private func fetchPhotos(page: Int, perPage: Int) async {
        do {
            let photosData = try await apiService.fetchPhotos(page: page, perPage: perPage)
            photos = photosData.map { Photo(from: $0) }
        } catch {
            print(error)
        }
    }
}
