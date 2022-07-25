//
//  ViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: MVVMViewController<HomeViewModel> {
    
    //MARK: parameters
    private var frameworks: [CustomCollectionViewCell.Data] = []                                //ovo ne valja ovdje spremati
    var navBarTitle: String?
    private let disposeBag = DisposeBag()
    
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
    
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        
        return collectionView
    }()
    
    override func setupView() {
        configureViewController()
        view.addSubview(collectionView)
    }
    
    override func bindInput() -> HomeViewModel.Input {
        return HomeViewModel.Input()
    }
    
    override func bindOutput(output: HomeViewModel.Output) {
        output.loading.drive { _ in
            //handle true/false, sakriti spinner
        }
        output.frameworks
            .drive(collectionView.rx.items(cellIdentifier: CustomCollectionViewCell.reuseIdentifier, cellType: CustomCollectionViewCell.self) ) { [weak self] (row, item, cell) in
                cell.configure(with: item)
                self?.frameworks.insert(item, at: row)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func configureViewController() {
        view.backgroundColor    = .secondarySystemBackground
        title                   = navBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: Extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 //self.homeViewModel.frameworks.count                                                         //kako reaktivno izračunati koliko ima celija
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailsViewController = Scene.details.viewController as? DetailsViewController else {return}
        detailsViewController.framework = self.frameworks[indexPath.row] 

        
        self.present(detailsViewController, animated: true)
        
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
//
//extension HomeViewController {
//    typealias DataSource = RxCollectionViewSectionedReloadDataSource
//
//    static func dataSource() -> DataSource<SectionOfFrameworks> {
//        .init { dataSource, collectionView, indexPath, element in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
//            cell.configure(with: element)
//            return cell
//        }
//
//    }
//}
