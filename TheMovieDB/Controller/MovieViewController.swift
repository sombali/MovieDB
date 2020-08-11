//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var sessionId: String? = nil
    var guestSessionId: String? = nil

    @IBAction func guestSessionIdButtonTapped(_ sender: Any) {
        AuthenticationManager.getGuestSession { (guestSession) -> (Void) in
            self.guestSessionId = guestSession.guestSessionId
        }
        
        displayAlert(for: "Success", with: "Congratulations, you can head to the movies!")
        
    }
    
    @IBAction func moviesButtonTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        sessionId = defaults.object(forKey: "sessionId") as? String
        guestSessionId = defaults.object(forKey: "guestSessionId") as? String
        
        if sessionId != nil || guestSessionId != nil {
            performSegue(withIdentifier: "moviesSegue", sender: nil)
        } else {
            displayAlert(for: "Not authenticated", with: "Sorry, you have to authenticate yourself first!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayAlert(for title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

