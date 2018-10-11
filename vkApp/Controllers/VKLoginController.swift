//
//  VKLoginController.swift
//  vkApp
//
//  Created by Olga Martyanova on 29/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    var tok:String = ""
    @IBOutlet weak var webview: WKWebView!{
        didSet{
            webview.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let request = vkAuthRequest(){
        webview.load(request)
        }
    }
    
    func vkAuthRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6642592"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.80")
        ]
        if let url = urlComponents.url{
            return URLRequest(url:url)
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? UITabBarController {
            if let navigationcontroller = destinationController.viewControllers?[0] as? UINavigationController{
                if let controller = navigationcontroller.viewControllers.first as? MyFriendsController{
                    if let sendToken = sender as? (String, String){
                        controller.token = sendToken.0
                        controller.id = sendToken.1
                    }
                }
            }
            if let navigationcontroller = destinationController.viewControllers?[1] as? UINavigationController{
                if let controller = navigationcontroller.viewControllers.first as? MyGroupsController{
                    if let sendToken = sender as? (String, String){
                        controller.token = sendToken.0
                        controller.id = sendToken.1
                    }
                }
            }
            if let navigationcontroller = destinationController.viewControllers?[2] as? UINavigationController{
                if let controller = navigationcontroller.viewControllers.first as? NewsController{
                    if let sendToken = sender as? (String, String){
                        controller.token = sendToken.0
                    }
                }
            }
        }
    }
}
    


extension VKLoginController:WKNavigationDelegate {
   func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void){
    guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
        decisionHandler(.allow)
        return
    }
    
    let params = fragment
        .components(separatedBy: "&")
        .map{$0.components(separatedBy: "=")}
        .reduce([String: String]()){result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
    }
    
    let token = (params["access_token"], params["user_id"])
  //  let id = params["user_id"]
    
    performSegue(withIdentifier: "menuSegue", sender: token)
    decisionHandler(.cancel)
    
    }
}


