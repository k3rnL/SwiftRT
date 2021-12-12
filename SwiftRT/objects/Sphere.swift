//
//  Sphere.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

class Sphere : Object {
    
    init(position: Vector3d, color: Color, R: Double) {
        self.position = position
        self.color = color
        self.R = R
    }
    
    var position: Vector3d
    var color: Color
    let R: Double
    
    func intersect(ray: Ray) -> Ray.Intersection? {
        let oc = ray.position - position
        let a = ray.direction.dot(ray.direction)
        let b = 2.0 * (oc.dot(ray.direction))
        let c = (oc.dot(oc)) - R * R
        let d = b * b - 4 * a * c

        if (d < Constants.Epsilon) {
            return nil
        }
        let distance = (-b - sqrt(d)) / (2.0 * a)

        if (distance < Constants.Epsilon) {
            return nil
        }
        else {
            return ray.intersection(on: self, withDistance: distance)
        }
    }
    
    func normal(intersection: Ray.Intersection) -> Vector3d {
        return (intersection.position() - position).normalized
    }
    
}
