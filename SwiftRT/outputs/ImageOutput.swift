//
//  ImageOutput.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation

class ImageOutput : Output {

    let file: String
    let sizeX: Int
    let sizeY: Int

    var buffer: [Color]

    init(file: String, sizeX: Int, sizeY: Int) {
        self.file = file
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.buffer = Array(repeating: Colors.black, count: sizeX * sizeY)
    }

    func write(x: Int, y: Int, color: Color) {
        buffer[x + y * sizeX] = color
    }

    func frame() {
        let out: OutputStream = OutputStream(toFileAtPath: file, append: false)!
        out.open()
        let header = "P3\n\(sizeX) \(sizeY)\n255\n"

        out.write(header, maxLength: header.count)

        let buffer: [Vector3i] = buffer.map({$0 * 255}).map { v in Vector3i(Int(v.x), Int(v.y), Int(v.z)) }
        var toWrite = ""

        for y in 0..<sizeY {
            for x in 0..<sizeX {
                let color = buffer[sizeX * y + x]
                toWrite.append("\(color.x) \(color.y) \(color.z)\n")
            }
        }

        out.write(toWrite, maxLength: toWrite.count)
        out.close()
        print("Done")
    }

}
