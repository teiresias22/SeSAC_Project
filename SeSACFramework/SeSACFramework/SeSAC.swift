//
//  SeSAC.swift
//  SeSACFramework
//
//  Created by Joonhwan Jeon on 2022/01/08.
//

import Foundation
import UIKit
import WebKit

open class SeSACOpen: UIViewController {
    
    var name: String = "고래밥"
    
    func openFunction() {
        
    }
    public enum TransitionStyle {
        case present, push
    }
    
    
    public func presentWebViewController(url: String, transitionStyle: TransitionStyle, vc: UIViewController) {
        let webViewController = WebViewController()
        webViewController.url = url
        switch transitionStyle {
        case .present:
            vc.present(webViewController, animated: true, completion: nil)
        case .push:
            vc.navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}

public class SeSACPublic: UIViewController {
    
    var name: String = "고래밥"
    
    func publicFunction() {
        
    }
    
}

internal class SeSACInternal: UIViewController {
    
    
}

fileprivate class SeSACFilePrivate: UIViewController {
    
    
}

private class SeSACPrivate: UIViewController {
    
    
}

