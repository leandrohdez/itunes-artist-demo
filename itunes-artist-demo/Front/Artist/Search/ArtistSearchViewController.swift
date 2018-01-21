//
//  ArtistSearchViewController.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit
import Spring

class ArtistSearchViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.styleSearchField()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var boxView: SpringView! {
        didSet {
            boxView.styleSearchView()
        }
    }
    
    @IBOutlet var topBoxLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet var searchButton: SpringButton! {
        didSet {
            searchButton.stylePrimaryButton()
        }
    }
    
    
    // MARK: Presenter
    var artistPresenter: ArtistSearchPresenter!
    override var presenter: Presenter! {
        return artistPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard Observers
        NotificationCenter.default.addObserver(self, selector: #selector(ArtistSearchViewController.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ArtistSearchViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(ArtistSearchViewController.dismissKeyboard) )
        view.addGestureRecognizer(tap)
        
        customizeUI()
    }

    private func customizeUI() {
        self.title = ""
        self.navigationController?.performTransparentBackground()
        
        // cerrar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(ArtistSearchViewController.closeButtonTapped))
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}

// MARK: - Actions
extension ArtistSearchViewController {
    @objc func closeButtonTapped() {
        self.dismissKeyboard()
        self.artistPresenter.closeView()
    }
    
    @IBAction func searchButtonTapped() {
        self.dismissKeyboard()
        let name = self.nameTextField.text!
        self.artistPresenter.searchArtist(byName: name)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Presenter Methods
extension ArtistSearchViewController: ArtistSearchPresenterView {
  
}

// MARK: - Observers
extension ArtistSearchViewController {
    @objc func keyboardWillShow(notification:NSNotification) {
        print("abre teclado")
        self.adjustingConstraint(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        print("cierra teclado")
        self.adjustingConstraint(show: false, notification: notification)
    }
    
    func adjustingConstraint(show:Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let navBarHeight    = CGFloat(64.0)
        let scala           = CGFloat(0.05)

        let newAdjustConstraintValue = navBarHeight + self.view.frame.height * scala
        self.topBoxLayoutConstraint.constant = (show) ? newAdjustConstraintValue : 150
        
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}


// MARK: - UITextFieldDelegate
extension ArtistSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
