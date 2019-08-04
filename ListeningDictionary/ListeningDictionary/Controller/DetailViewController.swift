//
//  DetailViewController.swift
//  ListeningDictionary
//
//  Created by Wi on 03/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        let myURL = URL(string: "https://www.youtube.com/embed/UuskKfv2zxI?playsinline=1&start=40&cc_load_policy=1&autoplay=1&controls=2&modestbranding=1&showinfo=0")
        let youtubeRequest = URLRequest(url: myURL!)
        webView.load(youtubeRequest)
    }
    
    

}
