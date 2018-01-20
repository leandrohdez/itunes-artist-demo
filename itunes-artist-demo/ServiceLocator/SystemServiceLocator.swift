//
//  SystemServiceLocator.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import UIKit


class SystemServiceLocator: ServiceLocatorModule {
    
    func registerServices(serviceLocator: ServiceLocator) {
        serviceLocator.register { self.mainWindow }
    }
    
    private var mainWindow: UIWindow {
        return UIApplication.shared.windows.first!
    }
}
