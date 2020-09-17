//
//  ViewController.swift
//  LinkLabel
//
//  Created by 13216146 on 17/09/20.
//  Copyright © 2020 13216146. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ClickableLableProtocol, ClickableLabelInfoProtocol {
    
    var urlString: String = ""
    var fullTextColor: UIColor = .black
    var fullText: String =  "Please Accept Terms & Condition"
    var clickableText: String = "Terms & Condition"
    var linkColor: UIColor = .blue
    

    @IBOutlet weak var tnc2: ClickableLabel!
    @IBOutlet weak var tnm: ClickableLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fullText = "Google"
        self.clickableText = "Google"
        self.urlString = "http://www.google.com"
        self.tnc2.configureLable(with: self, withFont: UIFont.systemFont(ofSize: 12))
        self.tnc2.delegate = self
        
        self.fullText = "Facebook"
        self.clickableText = "Facebook"
        self.urlString = "http://www.facebook.com"
        self.tnm.configureLable(with: self, withFont: UIFont.systemFont(ofSize: 12))
        self.tnm.delegate = self
    }
    func handleTap(_ urlString: String) {
        print("\(urlString)")
       guard let url = URL(string: urlString) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

}

