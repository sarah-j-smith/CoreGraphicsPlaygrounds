//: Playground - noun: a place where people can play

import Cocoa
import SpriteKit


// 200 x 193
var img = #imageLiteral(resourceName: "Chest.png")

let cgImage = img.cgImage(forProposedRect: nil, context: nil, hints: nil)
let sz = CGSize(width: cgImage!.width, height: cgImage!.height)
let rect = CGRect(origin: CGPoint.zero, size: sz)

let pixelsWide = Int(sz.width)
let pixelsHigh = Int(sz.height)

let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
let context = CGContext(data: nil, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!


context.setFillColor(SKColor.clear.cgColor)
context.fill(CGRect(x: 0, y: 0, width: sz.width, height: sz.height))
let transparentBackground = context.makeImage()
let canvas = CIImage(cgImage: transparentBackground!)

context.setFillColor(#colorLiteral(red: 0.4270328879, green: 0.4252764583, blue: 0.4288662076, alpha: 1).cgColor)
context.fill(rect)

let outImage = context.makeImage()
let greyInput = CIImage(cgImage: outImage!)

let shadowMask = CIImage(cgImage: cgImage!)
let params = [
    kCIInputImageKey: greyInput,
    kCIInputMaskImageKey: shadowMask,
    kCIInputBackgroundImageKey: canvas
]
let maskWithAlpha = CIFilter(name: "CIBlendWithAlphaMask", withInputParameters: params)
let ciImage = maskWithAlpha!.outputImage!

let result = NSImage(size: sz)
result.addRepresentation(NSCIImageRep(ciImage: ciImage))
print(result.size)

let shadow = result
