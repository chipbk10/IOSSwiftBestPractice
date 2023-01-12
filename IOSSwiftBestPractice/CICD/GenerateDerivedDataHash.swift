import Foundation
import CommonCrypto


extension Array where Element == CChar {
    
    init(hashSlice: UInt64) {
        var array = Self(repeating: 0, count: 15)
        var tmp = hashSlice
        (0...array.count - 2).reversed().forEach {
            array[$0] = CChar((tmp % 26) + 97)
            tmp /= 26
        }
        self = array
    }
}

extension Array where Element == String {
    
    mutating func skipSystemFolders() -> Array<String> {
        self = self.filter { !$0.contains(".DS_Store") && !$0.hasPrefix(".") }
        return self
    }
}


extension Data {
    
    var uint64Pair: (first: UInt64, second: UInt64) {
        guard count >= Int(CC_MD5_DIGEST_LENGTH) else {
            return (0, 0)
        }
        
        return (first: withUnsafeBytes({ $0.load(as: UInt64.self) }).bigEndian,
                second: subdata(in: Data.Index(8)..<Data.Index(16)).withUnsafeBytes({ $0.load(as: UInt64.self) }).bigEndian)
    }
}

extension String {
    
    var md5: Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = data(using: .utf8)!
        var digestData = Data(count: length)
        
        // This ugly trick is only needed to hide the deprecation warning (if we call CC_MD5 directly)
        typealias CCMD5T = @convention(c) (_ data: UnsafeRawPointer?, _ len: CC_LONG, _ md: UnsafeMutablePointer<UInt8>?) -> UnsafeMutablePointer<UInt8>?
        guard let rtldDefault = UnsafeMutableRawPointer(bitPattern: -2), let functionAddress = dlsym(rtldDefault, "CC_MD5") else {
            fatalError("Cannot resolve CC_MD5")
        }
        
        let ccMD5 = unsafeBitCast(functionAddress, to: CCMD5T.self)
        
        digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    _ = ccMD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
            }
        }
        return digestData
    }
    
    
    var derivedDataHash: String {
        let pair = md5.uint64Pair
        return String(cString: [CChar](hashSlice: pair.first)) + String(cString: [CChar](hashSlice: pair.second))
    }
}

let name = "MyWorkspace.xcworkspace"
let hash = name.derivedDataHash
print("hash = \(hash)")
