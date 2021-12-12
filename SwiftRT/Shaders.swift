//
// Created by Erwan Daniel on 12/12/2021.
//

import Foundation

class Shader {
    let callback: (Ray.Intersection, Scene) -> Color

    init(_ callback: @escaping (Ray.Intersection, Scene) -> Color) {
        self.callback = callback
    }

    func callAsFunction(_ intersection: Ray.Intersection, _ scene: Scene) -> Color {
        callback(intersection, scene)
    }
}

func !=(left: Shader, right: Shader) -> Bool {
    return left != right
}

extension Array where Element == Shader {
    func shade(intersection: Ray.Intersection, scene: Scene) -> Color {
        map { shader -> Color in shader(intersection, scene)}
                .reduce(Color(0), { (result, color) in result + color })
    }
}

class Shaders {
    static let lambertShading: Shader = Shader({ intersection, scene in
        let light = scene.light
        let color = intersection.object.color
        let N = intersection.normal
        let L = (light - intersection.position).normalized
        let diffusion = max(min(N.dot(L), 1), 0)

        return intersection.object.color * diffusion * intersection.object.material.diffuse
    })

    static let specularLightShading: Shader = Shader({ intersection, scene in
        let light = scene.light
        let material = intersection.object.material
        if (material.specular > 0) {
            let L = (light - intersection.position).normalized
            let R = intersection.reflectedVector(L).direction
            let specular = pow(max(0, R.dot(intersection.ray.direction)), material.roughness)

//            var shadow = false
//            for (elem <- scene.objects if elem != intersection.that && !shadow) {
//                val inter = elem intersect intersection.shadowRay(light)
//                if (inter.hit && inter.distance < (light - intersection.position).length)
//                shadow = true
//            }

//            if (shadow) Colors.Black else Colors.White * specular * material.specular
            return Colors.white * specular * material.specular
        }
        else {
            return Colors.black
        }
    })


    static func toto() {}
    static func tata() {}

    static let reflectionShading: Shader = Shader({ intersection, scene in
        let material = intersection.object.material
        if (material.reflection > 0) {
//            withUnsafePointer(to: Shader) { (pointer: UnsafePointer<T>) -> Result in  }
            var color = scene.background
            var bounce = intersection
            for _ in 0...10 where bounce.hit && bounce.object.material.reflection != 0 {
                if let inter = bounce.reflectedRay.intersect(scene: scene) {
                    let shadedColor = scene.shaders.filter({$0 != reflectionShading}).map({$0(inter, scene)}).reduce(Color(0), +)
                    color = color + shadedColor * bounce.object.material.reflection

                    bounce = inter
                } else {
                    break
                }
            }

            return color
        }
        else {
            return Colors.black
        }
    })
}