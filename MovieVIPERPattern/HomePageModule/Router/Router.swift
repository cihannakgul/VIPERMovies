//
//  Router.swift
//  MovieVIPERPattern
//
//  Created by cihan on 12.01.23.
//

import Foundation

//MARK: - Router

class Router : PresenterToRouterProtocol{
    static func createModule(ref: MoviesViewController) {
        let presenter = Presenter()
        // View
        ref.presenter = presenter
        // Presenter
        ref.presenter?.interactor = Interactor()
        ref.presenter?.viewControl = ref
        // Interactor
        ref.presenter?.interactor?.presenter = presenter
        
        
        
        
    }
    
    
}
