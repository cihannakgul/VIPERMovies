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
    var localMovieList : [Movie] = []
    var presenter : ViewToPresenterProtocol?
    
    var collectionView: UICollectionView!
    
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        searchBar.delegate = self
    
        
        newCollection.dataSource = self
        newCollection.delegate = self
        
         
 
        self.newCollection.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "customMovieCell")
      
  
        //Router.createModule(ref: self)
       
        
        getDatasFromInteractor()
    }
   
    
     
    
    private lazy var newCollection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
           // layout.minimumLineSpacing = .zero
           // layout.minimumInteritemSpacing = .zero
           // layout.sectionInset = .zero
        
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.scrollDirection = .vertical
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "customMovieCell")
        collectionView.backgroundColor = .black
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       return collectionView
        }()
   
    func getDatasFromInteractor(){
         presenter?.getJSONDatas()
        
    }
   
    
    @objc func searchBarFunc(){
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
        
        
        
        view.addSubview(newCollection)
        view.backgroundColor = .white
        searchBar.sizeToFit()
      //
   
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
  
 
        NSLayoutConstraint.activate([
        
            newCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           // newCollection.heightAnchor.constraint(equalToConstant: 100)
            newCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            
        ])
       
        searchBarShow(shouldShow: true)
         
     
        
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
 
//MARK: - PresenterToViewProtocol

extension MoviesViewController : PresenterToViewProtocol{
    func sendPresenterToView(data: [Movie]) {
        localMovieList = data
        print(localMovieList[0].Year)
    }
}







extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customMovieCell", for: indexPath) as? SubclassedCollectionViewCell
            let data = self.data[indexPath.item]
        cell?.setupCell(color: data)
        
        return cell ?? UICollectionViewCell()
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    
    
}


class SubclassedCollectionViewCell: UICollectionViewCell {
    
     
     
    func setupCell(color: UIColor) {
        self.backgroundColor = color
       
    
    }
}
