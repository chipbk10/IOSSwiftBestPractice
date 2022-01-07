//
//  MVVM_ScreenA.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

import UIKit

protocol MVVM_A_ViewModeling {
    var data_for_view2: String { get }
}

struct MVVM_A_ViewModel: MVVM_BaseViewModeling {
    let data_for_view1 = "data for view1 in screen A"
    let data_for_view3 = "data for view3 in screen A"
}

extension MVVM_A_ViewModel: MVVM_A_ViewModeling {
    var data_for_view2: String {
        "data for view 2 in screen A"
    }        
}

final class MVVM_ViewControllerA: MVVM_BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: MVVM_BaseViewModeling & MVVM_A_ViewModeling
    
    // MARK: - Init methods
    
    init(viewModel: MVVM_BaseViewModeling & MVVM_A_ViewModeling) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    override func setupView2() {
        print("Setup view 2 using \(viewModel.data_for_view2)")
    }
}
