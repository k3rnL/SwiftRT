//
//  main.swift
//  SwiftRT Text
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation

let start = DispatchTime.now()

print(FileManager.default.currentDirectoryPath)

let ray: Ray = Ray(position: Vector3(0), direction: Vector3(0, 0, 1))

let scene = Scenes.scene1

print(Colors.black.distance(Color(1)) / Colors.black.distance(Colors.white))

//let output = TerminalOutput(sizeX: scene.sizeX, sizeY: scene.sizeY)
let output = ImageOutput(file: "/Users/edaniel/Documents/test.ppm", sizeX: scene.sizeX, sizeY: scene.sizeY)

for y in 0..<scene.sizeY {
    for x in 0..<scene.sizeX {
        let imageAspectRatio: Double = Double(scene.sizeX) / Double(scene.sizeY); // assuming width > height
        let Px = ((2.0 * ((Double(x) + 0.5) / Double(scene.sizeX)) - 1.0)) * tan(Constants.fov / 2.0 * 3.14 / 180.0) * imageAspectRatio
        let Py = (1.0 - 2.0 * ((Double(y) + 0.5) / Double(scene.sizeY))) * tan(Constants.fov / 2.0 * 3.14 / 180.0)
        
        let ray = Ray(position: scene.position, direction: Vector3(Px, Py, 1).normalized)
        
        if let intersection: Ray.Intersection = ray.intersect(scene: scene) {
            output.write(x: x, y: y, color: scene.shaders.shade(intersection: intersection, scene: scene))
        } else {
            output.write(x: x, y: y, color: scene.background)
        }

    }
}

output.frame()

let end = DispatchTime.now()
let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

print("Time to generate : \(timeInterval) seconds")
