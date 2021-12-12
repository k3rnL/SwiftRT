//
// Created by Erwan Daniel on 12/12/2021.
//

import Foundation

struct Material {
    let ambient: Double
    let diffuse: Double
    let roughness: Double
    let specular: Double
    let reflection: Double
    let refraction: Double

    init(ambient: Double = 0.0,
         diffuse: Double = 0.0,
         roughness: Double = 0.0,
         specular: Double = 0.0,
         reflection: Double = 0.0,
         refraction: Double = 0.0) {
            self.ambient = ambient
            self.diffuse = diffuse
            self.roughness = roughness
            self.specular = specular
            self.reflection = reflection
            self.refraction = refraction
    }
}

class Materials {
    static let Mat = Material(ambient: 0.1, diffuse: 0.6, roughness: 20)
    static let Metal = Material(ambient: 0.35, diffuse: 0.2, roughness: 1200, specular: 0.5, reflection: 0.5)
}