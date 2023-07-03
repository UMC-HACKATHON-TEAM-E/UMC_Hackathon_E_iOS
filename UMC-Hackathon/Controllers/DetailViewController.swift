//
//  DetailViewController.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit


class DetailViewController: UIViewController {
    
    
    

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var titleFont: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        
        
        self.view.setGradient(color1: UIColor(red: 0.69, green: 0.32, blue: 0.87, alpha: 1.00), color2: UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00))
        
        //bottomView
        bottomView.backgroundColor = UIColor.white
        bottomView.layer.cornerRadius = 20
        
        //middleView
        middleView.backgroundColor = UIColor.white
        middleView.layer.cornerRadius = middleView.layer.frame.height/2
        
        
        //뷰 앞으로 가져오기
        self.view.bringSubviewToFront(bottomView)
        self.view.bringSubviewToFront(middleView)
        self.view.bringSubviewToFront(titleFont)
    }


}

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
