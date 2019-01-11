//
//  Util.swift
//  EddystoneScanner
//
//  Created by Amit Prabhu on 14/01/18.
//  Copyright © 2018 Amit Prabhu. All rights reserved.
//

import Foundation

public extension Collection where Iterator.Element == UInt8 {
    
    //
    // Converts the UInt8 array into a Data object
    //
    public var data: Data {
        return Data(self)
    }
    
    ///
    /// Converts the UInt8 array into its quvivalent hex string
    ///
    public var hexString: String {
        return map { String(format: "%02X", $0) }.joined()
    }
    
    ///
    /// Converts the UInt8 array into system-dependent unsigned int
    ///
    public var UIntValue: UInt {
        return bytesToAnyUInt(byteArray: ArraySlice(self)) ?? 0
    }
    
    /// Converts the UInt8 array into bytes-specified unsigned int
    ///
    ///// 64bit
    public var UInt64Value: UInt64 {
        return bytesToAnyUInt(byteArray: ArraySlice(self)) ?? 0
    }
    ///// 32bit
    public var UInt32Value: UInt32 {
        return bytesToAnyUInt(byteArray: ArraySlice(self)) ?? 0
    }
}

/**
 Convert the bytes array into a UInt object
 
 - Parameter byteArray: The `ArraySlice<UInt8>` byte array
 */
// Specificly for 'UInt' type (for compatibility to existing code)
internal func bytesToUInt(byteArray: ArraySlice<UInt8>) -> UInt? {
    return bytesToAnyUInt(byteArray: byteArray)
}

internal func bytesToAnyUInt<T: UnsignedInteger>(byteArray: ArraySlice<UInt8>) -> T? {
    let maxCount = MemoryLayout<T>.size / MemoryLayout<UInt8>.size
    guard byteArray.count <= maxCount else {
        debugPrint("Byte array cannot be converted into a specified integer object. Elements greater than \(maxCount)")
        return nil
    }
    
    var result: T = 0
    for idx in 0..<(byteArray.count) {
        let shiftAmount = T((byteArray.count) - idx - 1) * 8
        let value = T(byteArray[byteArray.startIndex + idx])
        result += value << shiftAmount
    }
    return result
}
