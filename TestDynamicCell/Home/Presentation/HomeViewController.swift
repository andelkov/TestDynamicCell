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
import Moya

final class HomeViewController: MVVMViewController<HomeViewModel> {
    
    //MARK: parameters
    var navBarTitle: String?
    private let disposeBag = DisposeBag()
    
    //MARK: View definition
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    private lazy var refreshButton: UIBarButtonItem = {
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        
        return refreshButton
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .always
        
        let layout = collectionView.collectionViewLayout
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.view.bounds.width-20, height: 150)
        }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInsetReference = .fromLayoutMargins
        
        return collectionView
    }()
    
    override func setupView() {
        configureViewController()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    
    
    
    private func configureViewController() {
        view.backgroundColor    = .secondarySystemBackground
        navigationItem.rightBarButtonItem = refreshButton
        title                   = navBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func bindInput() -> HomeViewModel.Input {
        let load = Driver.merge(refreshButton.rx.tap.asDriver(), Driver.just(()) )
        
        return HomeViewModel.Input(load: load,
                                   itemSelected: collectionView.rx.modelSelected(CustomCollectionViewCell.Data.self).asDriver())
    }
    
    override func bindOutput(output: HomeViewModel.Output) {
        
        output.loading.drive { [weak self] isLoading in
    
            self?.collectionView.isHidden = isLoading
            
            if isLoading {
                self?.activityIndicator.startAnimating()
                
            } else {
                self?.activityIndicator.stopAnimating()
            }
            
        }
            .disposed(by: disposeBag)
        
        output.frameworks
            .drive(collectionView.rx.items(cellIdentifier: CustomCollectionViewCell.reuseIdentifier, cellType: CustomCollectionViewCell.self) ) { (row, item, cell) in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        output.navigate
            .drive(onNext: { [weak self] scene in
                self?.present(scene.viewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }
    
}

//MARK: Extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
