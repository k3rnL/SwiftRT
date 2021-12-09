//
//  Vector3.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

class Vector3<T: Numeric> {
    let x: T
    let y: T
    let z: T
    
    init(x: T, y: T, z: T) {
        self.x = x
        self.y = y
        self.z = z
    }
}
