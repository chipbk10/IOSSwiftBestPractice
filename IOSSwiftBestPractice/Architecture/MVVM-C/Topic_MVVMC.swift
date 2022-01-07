//
//  Topic_MVVMC.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

import Foundation
import UIKit

final class Topic_MVVMC: TopicProtocol {
    
    static func run() {
        let topic = Topic_MVVMC()
        topic.question1()
    }
    
    // Question: design a set of screens that looks quite similar to each other, and only few UI componenets are different using MVVM
    // Answer: use Inheritance approach.
    //         create a base ViewController with all common UI components. Other ViewControllers will inherit from this ViewController
    //         create a base ViewModel, that provide data for this base ViewController. Other ViewModels will inherit from this ViewModel
    private func question1() {
        
        let viewControllerA = MVVM_ViewControllerA(viewModel: MVVM_A_ViewModel())
        viewControllerA.setupUIComponents()
        
        let viewContrllerB = MVVM_ViewControllerB(viewModel: MVVM_B_ViewModel())
        viewContrllerB.setupUIComponents()
    }
}
