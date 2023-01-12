//
//  Presenter.swift
//  MovieVIPERPattern
//
//  Created by cihan on 12.01.23.
//

import Foundation

//MARK: - Presenter
  class Presenter : ViewToPresenterProtocol{
    var interactor: PresenterToInteractorProtocol?
    
    var viewControl: PresenterToViewProtocol?
    
    func getJSONDatas() {
        print("Over here3")
        interactor?.getJSONDatasInteractor()
    }
  
    
}

extension Presenter : InteractorToPresenterProtocol{
    func sendInteractorToPresenter(data: [Movie]) {
        viewControl?.sendPresenterToView(data: data)
    }
    
    
}
