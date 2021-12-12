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
        
        for y in 0..<sizeY {
            for x in 0..<sizeX {
                for component in 0...2 {
                    let value: Int = Int(buffer[sizeX * y + x][component] * 255.0)
                    let text = "\(value) "
                    out.write("\(value) ", maxLength: text.count)
                }
                out.write("\n", maxLength: 1)
            }
        }
        
        out.close()
        print("Done")
    }
    
    
}
