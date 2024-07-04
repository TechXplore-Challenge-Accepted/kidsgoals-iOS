//
//  RegisterViewController.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit
import SwiftUI

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    private var header = UIHostingController(rootView: AuthHeaderView(title: "Sign Up", description: "Create your account"))
    
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign In", fontSize: .med)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupHeader()
        setupUsernameField()
        setupEmailField()
        setupPasswordField()
        setupSignUpButton()
        setupSignInButton()
    }
    
    private func setupHeader() {
        view.addSubview(header.view)
        header.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupUsernameField() {
        view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: header.view.bottomAnchor, constant: 12),
            usernameField.centerXAnchor.constraint(equalTo: header.view.centerXAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 40),
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupEmailField() {
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 22),
            emailField.centerXAnchor.constraint(equalTo: header.view.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupPasswordField() {
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            passwordField.centerXAnchor.constraint(equalTo: header.view.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            signUpButton.centerXAnchor.constraint(equalTo: header.view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 11),
            signInButton.centerXAnchor.constraint(equalTo: header.view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    // MARK: - Selectors
    @objc func didTapSignUp() {
        print("DEBUG PRINT:", "didTapSignUp")
    }
    
    @objc private func didTapSignIn() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
