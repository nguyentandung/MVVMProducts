//
//  ColorsViewModel.swift
//  TekoTestProject
//
//  Created by Nguyen Tan Dung on 11/29/21.
//

import UIKit

class ColorsViewModel: NSObject {
    private var apiService : APIService!
    private(set) var colors : [Color]! {
        didSet {
            debugPrint("Call back with list color")
            self.bindingColorViewModelToController()
        }
    }
    
    var bindingColorViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        debugPrint("Init Color viewModel")
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.getColors { (colors) in
            debugPrint("Receive colors from API")
            self.colors = colors
        }
    }
}
