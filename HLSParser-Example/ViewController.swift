//
//  ViewController.swift
//  HLSParser-Example
//
//  Created by Mohamad Farhand on 2020-12-20.
//

import UIKit
import HLSParser
class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    let URL = "https://d2zihajmogu5jn.cloudfront.net/sintel/master.m3u8"
    //let HLS = HLSParser()
    lazy var HLS : HLSParser = {
        return HLSParser()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = "Starting..."
        // Do any additional setup after loading the view.
        let tags = self.HLS.parseStreamTags(link: URL) { (response ,data) in
            // Process and work with extracted tags
            print(response)
            DispatchQueue.main.async {
                let responseString = String(describing: response)
                self.textView.text = self.textView.text + "\n" + responseString
            }
        } failedBlock: { (error) in
            // Handle Error
            print(error)
        }
    }
}

// TODO : We can parse the response to a standard model.
//struct responseModel: Codable {
//    let bandwidth, resolution, link: String
//
//    enum CodingKeys: String, CodingKey {
//        case bandwidth = "BANDWIDTH"
//        case resolution = "RESOLUTION"
//        case link = "LINK"
//    }
//}


