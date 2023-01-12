//
//  Protocols.swift
//  MovieVIPERPattern
//
//  Created by cihan on 12.01.23.
//

import Foundation


protocol PresenterToInteractorProtocol{
    var presenter:InteractorToPresenterProtocol?{get set}
    
    func getJSONDatasInteractor()

}

protocol InteractorToPresenterProtocol{
    
    func sendInteractorToPresenter(data:[Movie])
}
protocol ViewToPresenterProtocol{
    var interactor:PresenterToInteractorProtocol?{get set}
    var viewControl: PresenterToViewProtocol?{get set}
    func getJSONDatas()
}

protocol PresenterToViewProtocol{
    func sendPresenterToView(data:[Movie])

}

protocol PresenterToRouterProtocol{
    static func createModule(ref:MoviesViewController)
}
