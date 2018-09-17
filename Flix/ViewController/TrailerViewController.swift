//
//  TrailerViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/16/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var videoPlayerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo() {
        //let videoURL = URL(string: "https://www.youtube.com/watch?v=NpG8iaM0Sfs")
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        if let videoURL:URL = URL(string: "https://www.youtube.com/watch?v=NpG8iaM0Sfs") {
            let request:URLRequest = URLRequest(url: videoURL)
            webView.load(request)
        }
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
