//
//  PhotoGalleryViewController.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 12.06.2025.
//

import UIKit

final class PhotoGalleryViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = PhotoGalleryViewModel()
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        setupView()
        setupLayout()
        setupCollection()
        setupConstraints()
        loadData()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setupCollection() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Load Data
    private func loadData() {
        viewModel.load(page: 2, perPage: 30) {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Targets
    
    @objc private func handleRefresh() {
        viewModel.load(page: 1, perPage: 30) {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? PhotoCollectionViewCell
        else { return UICollectionViewCell() }
        let photoElement = viewModel.photos[indexPath.item]
        cell.configure(with: photoElement)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemsInRow: CGFloat = 2
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (itemsInRow + 1)
        
        let availableWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = floor(availableWidth / itemsInRow)
        
        return CGSize(width: itemWidth, height: itemWidth + 110)
    }
}
