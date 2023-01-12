//
//  MoviesViewController.swift
//  MovieVIPERPattern
//
//  Created by cihan on 20.12.22.
//

import UIKit
import Alamofire
class MoviesViewController: UIViewController {
 
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
      
        configureUI()
    }
    
    @objc func searchBarFunc(){
        print("it work")
        search(shouldShow: true)

        searchBar.becomeFirstResponder() // for showing keyboard
        
    }
    
    
    func search(shouldShow:Bool){
      searchBarShow(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func searchBarShow(shouldShow:Bool){
        if shouldShow{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarFunc))
        }else{
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func configureUI(){
        view.backgroundColor = .white
        searchBar.sizeToFit()
   
       navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
     
        
        navigationItem.title = "Movies List"
      
 
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemMint
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        searchBarShow(shouldShow: true)
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

extension MoviesViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      
      search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text) // searchText
    }
}

  
