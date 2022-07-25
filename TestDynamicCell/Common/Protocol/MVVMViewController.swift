//
//  MVVMViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 21.07.2022..
//

import UIKit

class MVVMViewController<ViewModel: ViewModelType>: UIViewController {
    
    private let viewModel: ViewModel  
    
    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindOutput(output: viewModel.transform(input: bindInput()))
    }
    
    func setupView() {
    }
    
    func bindInput() -> ViewModel.Input {
        fatalError("Should be implemented in the subclass")
    }
    
    func bindOutput(output: ViewModel.Output) {
        fatalError("Should be implemented in the subclass")
    }
}
