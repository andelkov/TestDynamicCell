//
//  ViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var homeViewModel = HomeViewModel()
    
    private var collectionView: UICollectionView?
    var datasource: UICollectionViewDiffableDataSource<Section, OrganizedData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureDataSource()
        applyInitialData()
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.configureLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.delegate = self
        view.addSubview(collectionView!)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OrganizedData> { (cell, indexPath, organizedData) in
            
            var content = cell.defaultContentConfiguration()
            
            content.text = MockData.frameworks[indexPath.row].name
            content.textProperties.color = .systemBlue
            content.secondaryText = MockData.frameworks[indexPath.row].description
            
            content.image = UIImage(named: MockData.frameworks[indexPath.row].imageName)
            content.imageProperties.maximumSize.width = self.view.bounds.width/3
            
            cell.contentConfiguration = content
        }
        
        datasource = UICollectionViewDiffableDataSource<Section, OrganizedData> (collectionView: collectionView!,
           cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        
    }
    
    private func applyInitialData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, OrganizedData>()
        snapshot.appendSections([.main, .second])
        snapshot.appendItems(mainSectionItems, toSection: .main)
        snapshot.appendItems(secondSectionItems, toSection: .second)
        datasource.apply(snapshot, animatingDifferences: false)
    }
    
    func configureViewController() {
        view.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
            
        view.backgroundColor    = .systemBackground
        title                   = "Lorem Ipsum"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension HomeViewController {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MockData.frameworks.count
    }

}
