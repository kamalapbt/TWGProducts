//
//  Viewable.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 29/09/21.
//

import Foundation

protocol Viewable {
    associatedtype P
    associatedtype D
    
    var presenter: P{get set}
    func didRecieveData(with data: D);
    func didRecieveError(with error: Error);
}
