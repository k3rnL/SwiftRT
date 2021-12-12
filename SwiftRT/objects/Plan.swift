//
//  Plan.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 12/12/2021.
//

import Foundation

class Plan : Object {
    let position: Vector3d
    let color: Color
    let material: Material

    init(position: Vector3d, color: Color, material: Material) {
        self.position = position
        self.color = color
        self.material = material
    }
    
    func intersect(ray: Ray) -> Ray.Intersection? {
        let d = -(ray.position.y - position.y) / ray.direction.y

        if (d < Constants.Epsilon) {
            return nil
        }
        return ray.intersection(on: self, withDistance: d)
    }
    
    func normal(intersection: Ray.Intersection) -> Vector3d {
        return Vector3(0, 1, 0)
    }
    
    
}
