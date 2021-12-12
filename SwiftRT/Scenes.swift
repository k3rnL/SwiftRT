//
//  Scenes.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 12/12/2021.
//

import Foundation

public struct Scene {
    let sizeX: Int
    let sizeY: Int
    let position: Vector3d
    let light: Vector3d
    let background = Colors.black
    let objects: [Object]
    let shaders: [Shader]

    func intersect(ray: Ray) -> Ray.Intersection? {
        objects.intersect(ray: ray)
    }
}

class Scenes {
    static var scene1 = Scene(sizeX: 1920, sizeY: 1080,
            position: Vector3(0, 3, 0),
            light: Vector3(10, 10, -10),
            objects: [
                Sphere(position: Vector3(0, 0, 10), color: Color(0.5, 0.2, 1), material: Materials.Metal, R: 2),
                Plan(position: Vector3(0), color: Colors.white, material: Materials.Mat)
            ],
            shaders: [Shaders.lambertShading, Shaders.specularLightShading, Shaders.reflectionShading]
    )
}
