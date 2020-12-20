//
//  HLSParser.swift
//  HLSParser
//
//  Created by Mahsa Mo on 9/25/1399 AP.
//

import Foundation

// let InputLink = https://d2zihajmogu5jn.cloudfront.net/sintel/master.m3u8

public struct HLSParser {
    
    public typealias success = (_ parsedResponse:[Any], _ data:Data?) -> Void
    public typealias failed = (_ error:Error?) -> Void
    
    public init() {}
        
    public func parseStreamTags(link: String,successBlock: @escaping success, failedBlock:@escaping failed) {
        var request = URLRequest(url: URL(string: link)!)
        request.httpMethod = "Get"
        var resultArr = [Any]()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Check if an error occured
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                failedBlock(error) // return data & close
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            let tmpStr = "#EXT-X-STREAM-INF:"
            let ArrayCop = responseString?.components(separatedBy: tmpStr)
            var croppedArr =  [Any]()
            croppedArr =  Array((ArrayCop?.dropFirst())!)
            let enterChar = "\n"
            let spaceChar = ","
            
            
            for i in 0..<(croppedArr.count) {
                var parsedDic = [String:Any]()
                let tmpArr1 =  ((croppedArr[i] as! String).trimmingCharacters(in: .whitespacesAndNewlines) ).components(separatedBy: enterChar)
                parsedDic["LINK"] = tmpArr1.last!
                let finalStr = tmpArr1[0]
                let arrayofCom = finalStr.components(separatedBy: spaceChar)
                for ind in 0..<arrayofCom.count {
                    if arrayofCom[ind].contains("BANDWIDTH=") {
                        parsedDic["BANDWIDTH"] = arrayofCom[ind].dropFirst(10)
                    }
                    if arrayofCom[ind].contains("RESOLUTION=") {
                        parsedDic["RESOLUTION"] = arrayofCom[ind].dropFirst(11)
                    }
                }
                resultArr.append(parsedDic)
            }
            successBlock(resultArr,data)
            
        }
        
        task.resume()
    }
}
