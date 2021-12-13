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
        let header = "P6\n\(sizeX) \(sizeY)\n255\n"

        out.write(header, maxLength: header.count)

        var toWrite: [UInt8] = Array(repeating: 0, count: buffer.count * 3)

        for i in 0..<buffer.count {
            toWrite[i * 3] = UInt8(buffer[i].x * 255)
            toWrite[i * 3 + 1] = UInt8(buffer[i].y * 255)
            toWrite[i * 3 + 2] = UInt8(buffer[i].z * 255)
        }

        out.write(toWrite, maxLength: toWrite.count)
        out.close()
        print("Done")
    }

}
