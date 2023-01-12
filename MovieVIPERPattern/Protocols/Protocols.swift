//
//  Protocols.swift
//  MovieVIPERPattern
//
//  Created by cihan on 12.01.23.
//

import Foundation


protocol PresenterToInteractorProtocol{
    
}

protocol InteractorToPresenterProtocol{
    
    func sendInteractorToPresenter(data:String)
}
protocol ViewToPresenterProtocol{
    
}

protocol PresenterToViewProtocol{
    func sendPresenterToView(data:String)

}
