//
//  Ray.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation

class Ray {
    
    public let position: Vector3d
    public let direction: Vector3d
    
    init(position: Vector3d, direction: Vector3d) {
        self.position = position
        self.direction = direction
    }
    
    func intersection(on: Object, withDistance: Double) -> Intersection {
        return Intersection(ray: self, hit: true, object: on, distance: withDistance)
    }
    
    class Intersection {
        let ray: Ray
        let hit: Bool
        let object: Object
        let distance: Double
        
        init(ray: Ray, hit: Bool, object: Object, distance: Double) {
            self.ray = ray
            self.hit = hit
            self.object = object
            self.distance = distance
        }
        
        func normal() -> Vector3d { return object.normal(intersection : self) }
        func position() -> Vector3d { return ray.position + ray.direction * distance }
    }
    
}
