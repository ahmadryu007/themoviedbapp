//
//  Utility.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import UIKit

class Utility {
    
    class func basicAlert(controller: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    class func basicLoading(superView: UIView) {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tag = 1001
        
        superView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: 0).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.startAnimating()
        
    }
    
    class func hideBasicLoading(superView: UIView) {
        if let activityInticator = superView.viewWithTag(1001) as? UIActivityIndicatorView {
            activityInticator.removeFromSuperview()
        }
    }
}
