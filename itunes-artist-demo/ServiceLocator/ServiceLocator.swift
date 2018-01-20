//
//  ServiceLocator.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation


protocol ServiceLocatorModule {
    func registerServices(serviceLocator: ServiceLocator)
}

class ServiceLocator {
    
    static let sharedLocator = ServiceLocator()
    
    private var registry = [ObjectIdentifier: Any]()
    
    static func registerModules() {
        
        sharedLocator.registerModules([
            SystemServiceLocator(),
            ArtistServiceLocator()
        ])
    }
    
    // MARK: Registration
    func register<Service>(_ factory: @escaping () -> Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = factory
    }
    
    // MARK: Register singleton functions
    func registerSingleton<Service>(_ singletonInstance: Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = singletonInstance
    }
    
    // MARK: Register modules funtions
    func registerModules(_ modules: [ServiceLocatorModule]) {
        modules.forEach { $0.registerServices(serviceLocator: self) }
    }
    
    static func registerModules(_ modules: [ServiceLocatorModule]) {
        sharedLocator.registerModules(modules)
    }
    
    // MARK: Injection
    static func inject<Service>() -> Service {
        return sharedLocator.inject()
    }
    
    // This method is private because no service which wants to request other services should
    // bind itself to specific instance of a service locator.
    private func inject<Service>() -> Service {
        let serviceId = ObjectIdentifier(Service.self)
        if let factory = registry[serviceId] as? () -> Service {
            return factory()
        } else if let singletonInstance = registry[serviceId] as? Service {
            return singletonInstance
        } else {
            fatalError("No registered entry for \(Service.self)")
        }
    }
}
