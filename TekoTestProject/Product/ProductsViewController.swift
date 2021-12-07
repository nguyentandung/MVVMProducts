//
//  ProductsViewController.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/24/21.
//

import UIKit
import Alamofire

class ProductsViewController: UIViewController {
    
    private var productsViewModel : ProductsViewModel!
    private var colorsViewModel : ColorsViewModel!
   
    var products = [Product]()
    var colors = [Color]()
    
    var colortest = Color(id: 11, name: "Blue")

    @IBOutlet weak var tblProducts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViewProduct()
        createThreadCallAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default
         .removeObserver(self, name:  NSNotification.Name(KEY_PASS_DATA), object: nil)
    }
    
    func configTableViewProduct() {
        self.tblProducts.separatorStyle = .none
        self.tblProducts.allowsSelection = false
        self.tblProducts.register(UINib(nibName: "ProductItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductItemTableViewCell")
    }
    
    @IBAction func actionBack(_ sender: Any) {
        let color = ["Color": ["id": 6, "name": "Black"]]
        NotificationCenter.default.post(name: NSNotification.Name(KEY_PASS_DATA), object: nil, userInfo: color)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createThreadCallAPI() {
       let queue = DispatchQueue(label: "queue.product")
        queue.sync {
            self.callTogetListColor()
        }
        queue.async {
            self.callToGetListProducts()
        }
    }
    
    func callTogetListColor() {
        self.colorsViewModel = ColorsViewModel()
        self.colorsViewModel.bindingColorViewModelToController = {
            self.colors = self.colorsViewModel.colors
            debugPrint("Show List Corlor to Screen")
            debugPrint(self.colorsViewModel.colors.count)
            self.callToGetListProducts()
        }
    }
    
    func callToGetListProducts(){
            self.productsViewModel =  ProductsViewModel()
            self.productsViewModel.bindEmployeeViewModelToController = {
                self.products = self.productsViewModel.empData
                debugPrint("Show List product to Screen")
                self.updateDataSource()
        }
        
    }
        
    func updateDataSource(){
        DispatchQueue.main.async {
            self.tblProducts.reloadData()
        }
    }
}

extension ProductsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblProducts.dequeueReusableCell(withIdentifier: "ProductItemTableViewCell", for: indexPath) as! ProductItemTableViewCell
        let product = self.products[indexPath.row]
        cell.position = indexPath.row
        cell.delegate = self
        cell.product = product
        cell.colors = self.colors
        cell.setInformationItem()
        if product.image?.count == 0 {
            cell.imgItem.image = UIImage(named: IMAGE_DEFAULT)
        }else {
            cell.imgItem.loadImage(url: URL(string: product.image!)!)
        }
        
        if product.color == nil {
            cell.lblItemColor.text = "Undefined"
        }else {
           if let index = self.colors.firstIndex(where: {$0.id == product.color}) {
                cell.lblItemColor.text = colors[index].name
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension ProductsViewController : HandleProductDelegate {
    func clickOnProduct(position: Int) {
       if let cell = tblProducts.cellForRow(at: IndexPath(row: position, section: 0)) as? ProductItemTableViewCell {
        debugPrint("Click on tableview at position \(position)")
        cell.focusView = true
        self.tblProducts.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            cell.focusView = false
            self.tblProducts.beginUpdates()
            self.tblProducts.reloadRows(at: [IndexPath(row: position, section: 0)], with: .none)
            self.tblProducts.endUpdates()
        })
        }
    }
}

protocol HandleProductDelegate {
    func clickOnProduct(position:Int)
}
