//
//  ViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit

final class HomeViewController: UIViewController  {
    
    private var homeViewModel: HomeViewModel
    private lazy var datasource: UICollectionViewDiffableDataSource<Section, OrganizedData> = configureDataSource()
    
    //MARK: View definition
    private lazy var collectionView: UICollectionView = {
        
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout )
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        
        return collectionView
    }()
    
    public init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViewController()
        self.homeViewModel.loadData()
        view.addSubview(collectionView)
        applyInitialData()
    }
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, OrganizedData> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OrganizedData> { [self] (cell, indexPath, organizedData) in
            
            var content = cell.defaultContentConfiguration() //snapkit ovdje sve
            
            content.text = self.homeViewModel.getCellData(index: IndexPath.row)
            content.secondaryText = self.homeViewModel.returnImageDescription(index: indexPath.row)
            content.image = self.homeViewModel.returnImageAsset(index: indexPath.row)
            
            content.textProperties.color = .systemBlue
            content.imageProperties.maximumSize.width = self.view.bounds.width/3
            
            cell.contentConfiguration = content
        }
        
        return UICollectionViewDiffableDataSource<Section, OrganizedData> (collectionView: collectionView,
                                                                           cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applyInitialData() {
        
        
        datasource.apply(homeViewModel.getInitialData(), animatingDifferences: false)
    }
    
    private func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Lorem Ipsum"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

//MARK: Extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentSafariVC(with: homeViewModel.returnAssetUrl(index: indexPath.row))
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
