//
//  main.swift
//  SwiftRT Text
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation
import _Concurrency

@main
struct SwiftRT {
    static func main() async {
        let start = DispatchTime.now()

        print(FileManager.default.currentDirectoryPath)

        let scene = Scenes.scene2

        //let output = TerminalOutput(sizeX: scene.sizeX, sizeY: scene.sizeY)
        let output = ImageOutput(file: "/Users/edaniel/Documents/test.ppm", sizeX: scene.sizeX, sizeY: scene.sizeY)

        let imageAspectRatio: Double = Double(scene.sizeX) / Double(scene.sizeY); // assuming width > height
        let factorX = tan(Constants.fov / 2.0 * 3.14 / 180.0) * imageAspectRatio
        let factorY = tan(Constants.fov / 2.0 * 3.14 / 180.0)

        let columns = slice(array: Array(0..<scene.sizeX), into: scene.sizeX / 10)
        DispatchQueue.concurrentPerform(iterations: 10) { index in
            print(index)
            for y in 0..<scene.sizeY {
                for x in columns[index] {
                    let Px = ((2.0 * ((Double(x) + 0.5) / Double(scene.sizeX)) - 1.0)) * factorX
                    let Py = (1.0 - 2.0 * ((Double(y) + 0.5) / Double(scene.sizeY))) * factorY

                    let ray = Ray(position: scene.position, direction: Vector3(Px, Py, 1).normalized)

                    if let intersection: Ray.Intersection = ray.intersect(scene: scene) {
                        output.write(x: x, y: y, color: scene.shaders.shade(intersection: intersection, scene: scene))
                    } else {
                        output.write(x: x, y: y, color: scene.background)
                    }
                }
            }
            print("Finished \(index)")
        }

        let deltaGeneration = delta(last: start)
        let writeStart = DispatchTime.now()

        output.frame()

        let deltaWrite = delta(last: writeStart)

        print("Total time : \(deltaGeneration + deltaWrite) seconds")
        print("Time to generate : \(deltaGeneration) seconds")
        print("Including time to write : \(deltaWrite) seconds")
    }

    static func slice<Element>(array: [Element], into size: Int) -> [[Element]] {
        return stride(from: 0, to: array.count, by: size).map {
            Array(array[$0..<Swift.min($0 + size, array.count)])
        }
    }

    static func delta(last: DispatchTime) -> Double {
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - last.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
        return Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
    }

}