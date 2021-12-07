//
//  ProductsViewModel.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/29/21.
//

import Foundation

class ProductsViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var empData : [Product]! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        debugPrint("Start Call API product")
        self.apiService.getProducts { (empData) in
            self.empData = empData
            debugPrint("Get listProduct Success")
        }
    }
}
