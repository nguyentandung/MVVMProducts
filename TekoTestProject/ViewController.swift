//
//  ViewController.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewIntroduce: UIView!
    
    @IBOutlet weak var viewInformation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customGradientViewWellCome()
//        createObserver()
        
//        print(test(array: [155,5,10,7,15,20,6,55,100,4,11,22]))
    }
    
    func createObserver() {
        NotificationCenter.default.addObserver(self,
                                       selector:#selector(loginSuccess(_:)), name: NSNotification.Name(KEY_PASS_DATA), object: nil)
    }
    
    @objc func loginSuccess(_ notification: Notification){
        print("Dung ne")
        print(notification.userInfo?["Color"] as? [String: Any] ?? [:])
    }
    
    func customGradientViewWellCome() {
        //View Information
        self.viewInformation.layer.borderColor = UIColor.orange.cgColor
        self.viewInformation.layer.borderWidth = 1
        self.viewInformation.layer.cornerRadius = 6
        
        //View Wellcome
        let colorTop =  UIColor(red: 255.0/255.0, green: 150.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.colors = [colorTop, colorBottom]
        gradientLayer1.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer1.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer1.frame = self.viewIntroduce.bounds
        gradientLayer1.cornerRadius = 6

        self.viewIntroduce.layer.insertSublayer(gradientLayer1, at:0)
    
    }
    
    @IBAction func actionShowTestProject(_ sender: Any) {
        let viewcontroller : ProductsViewController?
        viewcontroller = UIStoryboard.productsViewController()
        self.navigationController?.pushViewController(viewcontroller!, animated: true)
    }
    
    @IBAction func actionPassData(_ sender: Any) {
        let color = ["Color": ["id": 6, "name": "Black"]]
        NotificationCenter.default.post(name: NSNotification.Name(KEY_PASS_DATA), object: nil, userInfo: color)
        debugPrint("Posted")
    }
    
}

extension ViewController {
    
}
