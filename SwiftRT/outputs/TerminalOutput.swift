//
//  TerminalOutput.swift
//  SwiftRT
//
//  Created by Erwan Daniel on 10/12/2021.
//

import Foundation

class TerminalOutput : Output {
    
    let sizeX: Int
    let sizeY: Int
    
    var buffer: [Character]
    
    let greyScale: [Character] = [" ",".",",","-","~",":",";","!","*","=","$","#","@"]
    
    let maxDistance = Colors.black.distance(Colors.white)
    
    init(sizeX: Int, sizeY: Int) {
        self.sizeX = sizeX
        self.sizeY = sizeY
        
        buffer = Array(repeating: " ", count: sizeX * sizeY)
    }
    
    func write(x: Int, y: Int, color: Color) {
        let interpolation = Colors.black.distance(color) / maxDistance
        let index: Int = Int(Double(greyScale.capacity) * interpolation)
        buffer[x + y * sizeX] = greyScale[index]
    }

    func frame() {
        for y in 0..<sizeY {
            let slice = buffer[sizeX * y...sizeX * y + sizeX - 1]
            print(String(slice))
        }
    }
    
}
