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
    // MARK: - Properties
    
    
    // MARK: UI field
    let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("tap", for: .normal)
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()
    
    // MARK: data field
    var caption: Caption?
    var searchWord: String?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        view.addSubview(button)
        button.frame = CGRect(x: 250, y: 500, width: 50, height: 50)
        guard let caption = caption, let time = Float(caption.time) else{return}
        print(time)
        let myURL = URL(string: "https://www.youtube.com/embed/\(caption.videoId)?playsinline=1&start=\(Int(time))&cc_load_policy=1&autoplay=1&controls=2&modestbranding=1&showinfo=0")
        let youtubeRequest = URLRequest(url: myURL!)
        webView.load(youtubeRequest)
    }
    
    // MARK: - Action
    
    @objc private func test(){
        if let searchWord = self.searchWord, UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: searchWord){
            let rlVC = UIReferenceLibraryViewController(term: searchWord)
            self.navigationController?.pushViewController(rlVC, animated: true)
        }
        
    }
    
    

}
