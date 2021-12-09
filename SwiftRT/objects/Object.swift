//
//  Object.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

protocol Object {
    var position: Int { get }
    func intersect()
}
