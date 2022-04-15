//
//  NotificationCenter.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 12/04/2022.
//

import Foundation
import UIKit

protocol NotificationObserver: AnyObject {
    func notify()
}

class NotificationCenter {
        
    // consider to use `WeakReference<NotificationObserver>` to steer away the retain cycle
    // consider to use a set instead of using an array
    private var observers: [String: [NotificationObserver]] = [:]
    
    func notify(forNotification event: String) {
        if let obs = observers[event] {
            obs.forEach {
                $0.notify()
            }
        }
    }
    
    func add(observer: NotificationObserver, forNotification event: String) {
        observers[event, default: [NotificationObserver]()].append(observer)
    }
    
    func remove(_ observer: NotificationObserver) {
        for (key, obs) in observers {
            for (i, ob) in obs.enumerated() {
                if ob === observer {
                    observers[key]?.remove(at: i)
                }
            }
        }
    }
    
    func removeAll() {
        observers.removeAll()
    }
}

let notificationCenter = NotificationCenter()

class NotifCenterVC: UIViewController, NotificationObserver {
                    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.add(observer: self, forNotification: "A_Specific_Event")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.remove(self)
    }
    
    func notify() {
        // update the change here ...
    }
}
