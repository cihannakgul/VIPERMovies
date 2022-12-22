//
//  MoviesViewController.swift
//  MovieVIPERPattern
//
//  Created by cihan on 20.12.22.
//

import UIKit
import Alamofire
class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
        title = "Movies List"
        //getNew()
        //get()
    }
    
    
    
    
    
    func getNew(){ // oldWay
        
        AF.request("http://www.omdbapi.com/?s=harry&apikey=ff740049", method: .get).response{ response in
            if let data = response.data
            {
                do{
                    let cevap = try JSONDecoder().decode(MovieResponse.self, from: data)
                    if let liste = cevap.Search{
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
    
    func get(){ // oldWay
        
        AF.request("http://www.omdbapi.com/?s=harry&apikey=ff740049", method: .get).response{ response in
            if let data = response.data
            {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]{
                        if let kisiler = json["Search"] as? [[String:Any]]{
                            for kisi in kisiler{
                                print(kisi["Title"])
                            }
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

