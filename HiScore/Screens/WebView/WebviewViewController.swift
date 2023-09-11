//
//  WebviewViewController.swift
//  HiScore
//
//  Created by RATPC-043 on 11/09/23.
//

import Foundation
import UIKit
import WebKit

class WebviewViewController: BaseViewController, WKUIDelegate {
    @IBOutlet weak var webview: WKWebView!
    var url: URL?
}
// MARK: - View life cycle
extension WebviewViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    fileprivate func loadWebView() {
        webview.uiDelegate = self
        let myRequest = URLRequest(url: url!)
        webview.load(myRequest)
    }
}
