//
//  ViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit

final class HomeViewController: MVVMViewController<HomeViewModel> {
    
    //private var homeViewModel: HomeViewModel                                                                     // tu ide HomeViewModelIMpl ili samo HomeViewModel?
    private lazy var datasource: UICollectionViewDiffableDataSource<Section, OrganizedData> = configureDataSource()
    
    //MARK: View definition
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .always
        
        let layout = collectionView.collectionViewLayout
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.view.bounds.width-20, height: 150)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        
        return collectionView
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViewController()
        view.addSubview(collectionView)
        //applyInitialData()
    }
    
    override func bindInput() -> HomeViewModel.Input {
        return HomeViewModel.Input()
    }
    
    override func bindOutput(output: HomeViewModel.Output) {
        
    }
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, OrganizedData> {
        
        let cellRegistration = UICollectionView.CellRegistration<CustomCollectionViewCell, OrganizedData> { [self] (cell, indexPath, organizedData) in
            
            //cell.setup(with: self.homeViewModel.frameworks[indexPath.row])
        }
        
        return UICollectionViewDiffableDataSource<Section, OrganizedData> (collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applyInitialData() {
        
       // datasource.apply(homeViewModel.getInitialData(), animatingDifferences: true)
    }
    
    private func configureViewController() {
        view.backgroundColor    = .secondarySystemBackground
        //title                   = self.homeViewModel.navigationBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

//MARK: Extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        //cell.setup(with: homeViewModel.frameworks[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //self.homeViewModel.frameworks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let detailsViewController = DetailsViewController(framework: self.homeViewModel.frameworks[indexPath.row])
        
        //self.present(detailsViewController, animated: true)
        
        //presentSafariVC(with: url)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
            let referenceHeight: CGFloat = 100 
            let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
                - sectionInset.left
                - sectionInset.right
                - collectionView.contentInset.left
                - collectionView.contentInset.right
            return CGSize(width: referenceWidth, height: referenceHeight)
        }
    
}
