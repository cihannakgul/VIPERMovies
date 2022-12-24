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
      
        //getNew()
        //get()
        configureUI()
    }
    
    
    func configureUI(){
        view.backgroundColor = .white
  
  

       navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Movies List"
      

        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemMint
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
       // navigationController?.navigationBar.backgroundColor = UIColor(red: 255/255, green: 225/255, blue: 125/255, alpha: 1)
        
    }
    
    
    
    
    
    func getNew(){ 
        
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
    
     

}

  
