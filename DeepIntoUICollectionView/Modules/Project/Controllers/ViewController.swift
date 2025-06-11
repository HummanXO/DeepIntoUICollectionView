//
//  ViewController.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 07.06.2025.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await viewModel.fetchPhotos(page: 1, perPage: 30)
            collectionView.reloadData()
        }
        setupLayout()
        setupCollectionView()
        setupConstraints()
        view.backgroundColor = .systemBackground
        title = "Deep into UICollectionView"
    }
    
    func setupLayout() {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    func setupConstraints() {
        [collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.item?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        if let element = viewModel.item?[indexPath.item] {
            cell.configure(with: element)
        } 
        return cell
    }
}

    extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
                let padding: CGFloat = 10
                let itemsPerRow: CGFloat = 2
                let totalSpacing = padding * (itemsPerRow + 1)
                let availableWidth = collectionView.bounds.width - totalSpacing
                let itemWidth = floor(availableWidth / itemsPerRow)
                return CGSize(width: itemWidth, height: itemWidth + 110)
            }
    }
