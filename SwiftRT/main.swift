//
//  main.swift
//  SwiftRT Text
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation


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
        
        let intersection: Ray.Intersection? = scene.objects
            .compactMap({$0.intersect(ray: ray)})
            .min(by: {$0.distance < $1.distance})

        if (intersection == nil) {
            output.write(x: x, y: y, color: scene.background)
        } else {
            let light = scene.position
            let color = intersection!.object.color
            let N = intersection!.normal()
            let L = (light - intersection!.position()).normalized
            let diffusion = max(min(N.dot(L), 1), 0)
            
            output.write(x: x, y: y, color: color * diffusion)
        }
    }
}

output.frame()
