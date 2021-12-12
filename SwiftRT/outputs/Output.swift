//
//  Output.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation

protocol Output {
    func write(x: Int, y: Int, color: Color)
    func frame()
}
