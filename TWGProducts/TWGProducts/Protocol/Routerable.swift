//
//  AnyRouter.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 28/09/21.
//
import Foundation

protocol Routerable {
    associatedtype V
    
    var entry: V? { get }
}
