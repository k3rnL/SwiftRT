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

    func intersect(scene: Scene) -> Ray.Intersection? {
        scene.intersect(ray: self)
    }

    func intersection(on: Object, withDistance: Double) -> Intersection {
        Intersection(ray: self, hit: true, object: on, distance: withDistance)
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

        func reflectedVector(_ vector: Vector3d) -> Ray {
            Ray(position: position, direction: vector - normal * 2 * (vector.dot(normal)))
        }

        func reflectedRay(_ ray: Ray) -> Ray {
            Ray(position: position, direction: ray.direction - normal * 2 * (ray.direction.dot(normal)))
        }

        var reflectedRay: Ray {
            reflectedRay(ray)
        }

        var refractedRay: Ray {
            var cosi = max(min(ray.direction.dot(normal), 1), -1)
            var etai = 1.0
            var etat = object.material.refraction;
            var N = normal
            if (cosi < 0) {
                cosi = -cosi;
            } else {
                let tmp = etai
                etai = etat
                etat = tmp
                N = !N;
            }
            let eta = etai / etat;
            let k = 1 - eta * eta * (1 - cosi * cosi);
            if (k < 0) {
                return Ray(position: position, direction: Vector3(0))
            }
            let dir = ray.direction * eta + N * (eta * cosi - sqrt(k))
            return Ray(position: position, direction: dir)
        }

        var normal: Vector3d {
            object.normal(intersection: self)
        }

        var position: Vector3d {
            ray.position + ray.direction * distance
        }
    }

}
