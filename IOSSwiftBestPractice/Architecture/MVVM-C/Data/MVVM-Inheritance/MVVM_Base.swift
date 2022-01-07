//
//  MVVM_Base.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

import UIKit

// simulate how to design a set of screens that looks quite similar to each other, and only few UI componenets are different using MVVM

protocol MVVM_BaseViewModeling {
    var data_for_view1: String { get }    
    var data_for_view3: String { get }
}

class MVVM_BaseViewController: UIViewController {
    
    // MARK: - properties
    
    let baseViewModel: MVVM_BaseViewModeling
    
    // MARK: - Init methods
    
    init(viewModel: MVVM_BaseViewModeling) {
        self.baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
    }
    
    // MARK: - UI components
    
    func setupUIComponents() {
        
        // view 1 is the same among screens
        setupView1()
        
        // view 2 is different among screens
        setupView2()
        
        // view 3 is the same among screens
        setupView3()
    }
    
    private func setupView1() {
        // View1 looks alike among screens, only the content is different (is provided by ViewModels)
        print("Setup view 1 in the BaseViewController")
    }
    
    // like an abstract method
    func setupView2() {
        // View2 totally looks different among screens, the content is also different.
        fatalError("Setup view 2 in the SubViewController")
    }
    
    private func setupView3() {
        // View1 looks alike among screens, only the content is different (is provided by ViewModels)
        print("Setup view 3 in the base BaseViewController")
    }
}
