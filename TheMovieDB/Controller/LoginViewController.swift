//
//  LoginViewController.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 03. 01..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var guestSessionId: String?
    var sessionId: String?
    
    let userDefaults = UserDefaults.standard
    
    @IBAction func guestSessionButtonTapped(_ sender: Any) {
        if NetworkManager.apiKey == "YOUR_API_KEY_HERE" {
            displayAlert(for: "Missing API key", with: "You have to insert the API Key to the NetworkManager class")
        } else {
            AuthenticationManager.getGuestSession { (guestSession) -> (Void) in
                if guestSession.success {
                    self.displayAlert(for: "Success", with: "The authentication was successful!")
                } else {
                    self.displayAlert(for: "Wrong response", with: "Something is wrong with the authentication :(")
                }
            }

        }
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "authenticationViewController") as? AuthenticationViewController {
            
            if NetworkManager.apiKey == "YOUR_API_KEY_HERE" {
                displayAlert(for: "Missing API key", with: "You have to insert the API Key to the NetworkManager class")
            } else {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func moviesButtonTapped(_ sender: Any) {
        
        guestSessionId = userDefaults.object(forKey: "guestSessionId") as? String
        sessionId = userDefaults.object(forKey: "sessionId") as? String
        
        if guestSessionId != nil || sessionId != nil {
            performSegue(withIdentifier: "moviesSegue", sender: nil)
        } else {
            displayAlert(for: "Not authenticated", with: "You have to login first!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func displayAlert(for title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
