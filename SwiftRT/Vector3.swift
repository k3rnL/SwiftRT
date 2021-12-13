//
//  Vector3.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

func +<T: Numeric>(left: Vector3<T>, right: Vector3<T>) -> Vector3<T> {
    return Vector3(left.x + right.x, left.y + right.y, left.z + right.z)
}

func -<T: Numeric>(left: Vector3<T>, right: Vector3<T>) -> Vector3<T> {
    return Vector3(left.x - right.x, left.y - right.y, left.z - right.z)
}

func *<T: Numeric>(left: Vector3<T>, right: T) -> Vector3<T> {
    return Vector3(left.x * right, left.y * right, left.z * right)
}

func *<T: Numeric>(left: T, right: Vector3<T>) -> Vector3<T> {
    return Vector3(left * right.x, left * right.y, left * right.z)
}

prefix func !<T: Numeric>(value: Vector3<T>) -> Vector3<T> {
    return value * -1
}

typealias Vector3f = Vector3<Float>
typealias Vector3d = Vector3<Double>
typealias Vector3i = Vector3<Int>

class Vector3<T: Numeric> : CustomStringConvertible {
    let x: T
    let y: T
    let z: T
    
    init(_ x: T, _ y: T, _ z: T) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ scalar: T) {
        self.x = scalar
        self.y = scalar
        self.z = scalar
    }
    
    func dot(_ that: Vector3<T>) -> T {
        return x * that.x + y * that.y + z * that.z
    }
    
    public var description : String {
        return "(\(x), \(y), \(z))"
    }
}

extension Vector3 where T: SignedInteger {
    var length: Double {
        sqrt(Double(dot(self)))
    }
    
    var normalized: Vector3<Double> {
        Vector3<Double>(Double(x) / length, Double(y) / length, Double(z) / length)
    }
    
    func distance(_ that: Vector3<T>) -> Double {
        return (self - that).length
    }
}

extension Vector3 where T: FloatingPoint {
    var length: T {
        sqrt(dot(self))
    }
    
    var normalized: Vector3<T> {
        Vector3<T>(x / length, y / length, z / length)
    }
    
    func distance(_ that: Vector3<T>) -> T {
        return (self - that).length
    }
}
