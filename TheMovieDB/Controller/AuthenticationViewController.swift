//
//  AuthenticationViewController.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import UIKit
import WebKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        AuthenticationManager.getSession()
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthenticationManager.getNewRequestToken { (auth) -> (Void) in
            if auth.success {
                print(auth.requestToken)
                let url = URL(string: "https://www.themoviedb.org/authenticate/\(String(describing: auth.requestToken))")!
                self.webView.load(URLRequest(url: url))
            } else {
                self.displayAlert(for: "Wrong authentication", with: "Can not access RequestToken")
            }
        }
        
    }
    
    func displayAlert(for title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
