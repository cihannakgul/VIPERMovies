//
//  Interactor.swift
//  MovieVIPERPattern
//
//  Created by cihan on 12.01.23.
//

import Alamofire
import Foundation

  class Interactor : PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
      
    // MARK: - Alamofire
      
      func getJSONDatasInteractor(searchKey:String) {
    
         let url = "http://www.omdbapi.com/"
           let parameters: Parameters = [
               "s": searchKey,
               "apikey":"ff740049"
               ]

           AF.request(url,
                             method: .get,
                      parameters: parameters
           ).response { response in
               if let data = response.data
               {
                   do{
                       let cevap = try JSONDecoder().decode(MovieResponse.self, from: data)
                       if let liste = cevap.Search{
                           self.presenter?.sendInteractorToPresenter(data: liste)
                           for kisi in liste{
                            print(kisi.Title!)
                           }
                       }
                   }
                   catch{
                       print(String(describing: error))
                   }
               }
           }
          
          
        
          

    }
    
    
    
}
