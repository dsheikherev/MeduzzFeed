//
//  FullScreenSpinnerView.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 17.03.2021.
//

import UIKit

public class FullScreenSpinnerView {
    
    private static var spinner: UIActivityIndicatorView?
    
    public static func show() {
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
            
            if spinner == nil, let window = UIApplication.shared.windows.last {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.style = .large
                window.addSubview(spinner)
                spinner.startAnimating()
                self.spinner = spinner
            }
        }
    }
    
    public static func hide() {
        DispatchQueue.main.async {
            if let spinner = spinner {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                self.spinner = nil
            }
        }
    }
    
    @objc public static func update() {
        DispatchQueue.main.async {
            if spinner != nil {
                hide()
                show()
            }
        }
    }
}
