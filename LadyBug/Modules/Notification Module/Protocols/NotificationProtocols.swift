//
//  NotificationProtocols.swift
//  LadyBug
//
//  Created by Mohamed Abdelhamed Ahmed on 2/24/21.
//

import Foundation
    
    protocol NotificationPresenterProtocol {
        var localizer: NotificationLocalizer { get }
        var images: NotificationImages { get }
        func attach()
        func getNotificationCount() -> Int
    }
    protocol NotificationViewProtocol: class {
        
    }
