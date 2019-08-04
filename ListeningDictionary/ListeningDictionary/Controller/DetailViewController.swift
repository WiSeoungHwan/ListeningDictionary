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
    
    var caption: Caption?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        guard let caption = caption, let time = Float(caption.time) else{return}
        print(time)
        let myURL = URL(string: "https://www.youtube.com/embed/\(caption.videoId)?playsinline=1&start=\(Int(time))&cc_load_policy=1&autoplay=1&controls=2&modestbranding=1&showinfo=0")
        let youtubeRequest = URLRequest(url: myURL!)
        webView.load(youtubeRequest)
    }
    
    

}
