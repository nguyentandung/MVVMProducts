//
//  StoryboardManager.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/24/21.
//

import UIKit

extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func productsViewController() -> ProductsViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController
    }
}
