//
//  ProductItemTableViewCell.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/24/21.
//

import UIKit
import Kingfisher

class ProductItemTableViewCell: UITableViewCell {

    @IBOutlet weak var viewItem: UIView!
    @IBOutlet weak var lblItemColor: UILabel!
    @IBOutlet weak var lblItemSKU: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemDescription: UILabel!
    
    var product = Product()
    var colors = [Color]()
    
    var delegate : HandleProductDelegate?
    var position = 0
    var focusView = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        self.imgItem.image = UIImage(named: IMAGE_DEFAULT)
    }

    func customView() {
        
        viewItem.layer.shadowOpacity = 0.7
        viewItem.layer.shadowRadius = 2
        viewItem.layer.shadowColor = UIColor.lightGray.cgColor
        viewItem.layer.shadowOffset = .zero

        viewItem.layer.cornerRadius = 8
    }
    
    func setInformationItem() {
       
//        if product.image?.count == 0 {
//            self.imgItem.image = UIImage(named: IMAGE_DEFAULT)
//        }else {
//            self.imgItem.kf.setImage(with: URL(string: product.image!))
//        }
        
//        if product.color == nil {
//            self.lblItemColor.text = "Undefined"
//        }else {
//           if let index = self.colors.firstIndex(where: {$0.id == product.id}) {
//                self.lblItemColor.text = colors[index].name
//            }
//        }
        
        self.lblItemSKU.text = product.sku
        self.lblItemName.text = product.name
        self.lblItemDescription.text = product.errorDescription
        
        self.viewItem.backgroundColor = self.focusView ? UIColor.cyan : UIColor.white
    }
    
    
    @IBAction func actionHightLightView(_ sender: Any) {
        self.delegate?.clickOnProduct(position: position)
    }
    
}
