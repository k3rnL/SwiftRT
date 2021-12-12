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
    let background = Colors.black
    let objects: [Object]
}

class Scenes {
    static var scene1 = Scene(sizeX: 1280, sizeY: 720,
                              position: Vector3(0, 3, 0),
                              objects: [
                                Sphere(position: Vector3(0, 0, 10), color: Color(0.5, 0.2, 1), R: 2),
                                Plan(position: Vector3(0), color: Colors.white)
                              ])
}
