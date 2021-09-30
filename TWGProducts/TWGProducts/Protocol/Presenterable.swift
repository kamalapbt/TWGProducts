//
//  AnyPresenter.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 28/09/21.
//

import Foundation


protocol Presenterable {
    associatedtype I
    associatedtype R
    associatedtype V
    associatedtype D
    
    var router: R {get set}
    var interactor: I { get set }
    var view: V{get set}
    
    func didRecieveData(with result: Result<D, Error>)
}

