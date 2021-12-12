//
//  Sphere.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

class Sphere : Object {

    let position: Vector3d
    let color: Color
    let material: Material
    let R: Double

    init(position: Vector3d, color: Color, material: Material, R: Double) {
        self.position = position
        self.color = color
        self.material = material
        self.R = R
    }
    
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
        (intersection.position - position).normalized
    }
    
}
