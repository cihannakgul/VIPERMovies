//
//  MoviesViewController.swift
//  MovieVIPERPattern
//
//  Created by cihan on 20.12.22.
//

import UIKit
import Kingfisher
import Lottie

 class MoviesViewController: UIViewController {
 
    let searchBar = UISearchBar()
    var localMovieList : [Movie] = []
    var presenter : ViewToPresenterProtocol?
     
     var animationView : LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
        searchBar.delegate = self
        
        //LottieAnimation()

        newCollection.dataSource = self
        newCollection.delegate = self
        
         
 
        self.newCollection.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "customMovieCell")
      
  
   Router.createModule(ref: self)
       
        
        getDatasFromInteractor()
    }
   
     func LottieAnimation(){
         animationView = .init(name: "movie")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
          animationView!.animationSpeed = 0.5
        
          view.addSubview(animationView!)
           animationView!.play()
         
     }
 
    
    private lazy var newCollection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
          layout.itemSize = CGSize(width: 200, height: 300)
        layout.scrollDirection = .vertical
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "customMovieCell")
 
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       return collectionView
        }()
   
    func getDatasFromInteractor(){
        presenter?.getJSONDatas(searchKey: "harry")
        
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
         searchBar.sizeToFit()
   
       navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
     
        
        navigationItem.title = "Movies List"
      let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemMint
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated: true)
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
      //        presenter?.getJSONDatas(searchKey: "Harry")
      
        if searchText != nil{
            presenter?.getJSONDatas(searchKey: searchText)
        }
    }
}
 
//MARK: - PresenterToViewProtocol

extension MoviesViewController : PresenterToViewProtocol{
    func sendPresenterToView(data: [Movie]) {
         localMovieList = data
        newCollection.reloadData()
     }
}

 
extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customMovieCell", for: indexPath) as? SubclassedCollectionViewCell
          let data = localMovieList[indexPath.item]
 
        cell!.textView.text = data.Title ?? "not"
       

         cell?.imageView.kf.setImage(with: URL(string: data.Poster ?? ""))
  
        return cell ?? UICollectionViewCell()
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return localMovieList.count
    }
    
    
    
}


class SubclassedCollectionViewCell: UICollectionViewCell {
       lazy var textView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 15)
         return textView
    }()
  
    
    lazy var imageView : UIImageView = {
    
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
         return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.contentView.addSubview(imageView)
        //self.contentView.addSubview(textView)
        imageView.addSubview(textView)
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
           
             textView.widthAnchor.constraint(equalToConstant: 200),
            textView.heightAnchor.constraint(equalToConstant: 50)
           
            

        ])
    
        textView.textAlignment = .center
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
     
}
