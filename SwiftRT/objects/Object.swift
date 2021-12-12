//
//  Object.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 09/12/2021.
//

import Foundation

protocol Object {
    var position: Vector3d { get }
    var color: Color { get }
    func intersect(ray: Ray) -> Ray.Intersection?
    func normal(intersection: Ray.Intersection) -> Vector3d
}
