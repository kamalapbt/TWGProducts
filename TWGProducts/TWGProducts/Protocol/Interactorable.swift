//
//  AnyInteractor.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 28/09/21.
//

import Foundation

protocol Interactorable {
    associatedtype P
    var output: P {get set}
}
