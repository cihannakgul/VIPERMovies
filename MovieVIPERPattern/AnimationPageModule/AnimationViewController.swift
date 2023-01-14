//
//  AnimationViewController.swift
//  MovieVIPERPattern
//
//  Created by cihan on 14.01.23.
//

import Foundation
import UIKit
import Lottie

 var animationView : LottieAnimationView?

class AnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        animationView = .init(name: "movie")
       animationView!.frame = view.bounds
       animationView!.contentMode = .scaleAspectFit
         animationView!.animationSpeed = 0.5
       
         view.addSubview(animationView!)
          animationView!.play()
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
           self.navigationController?.pushViewController(MoviesViewController(), animated: true)
         }
    }
    
    

}

