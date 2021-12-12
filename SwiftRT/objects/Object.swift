//
//  Object.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

extension Array where Element == Object {
    func intersect(ray: Ray) -> Ray.Intersection? {
        compactMap({$0.intersect(ray: ray)}).min(by: {$0.distance < $1.distance})
    }
}

protocol Object {
    var position: Vector3d { get }
    var color: Color { get }
    var material: Material { get }
    func intersect(ray: Ray) -> Ray.Intersection?
    func normal(intersection: Ray.Intersection) -> Vector3d
}
