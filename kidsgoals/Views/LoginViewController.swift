//
//  LoginViewController.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: MainViewModel
    
    private var header = UIHostingController(rootView: AuthHeaderView(title: "Sign In", description: "Sign in to your account"))
    
    private var usernameField = CustomTextField(fieldType: .username)
    private var passwordField = CustomTextField(fieldType: .password)
    
    private var signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private var newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private var forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupHeader()
        setupUsernameField()
        setupPasswordField()
        setupSignInButton()
        setupNewUserButton()
        setupForgotPasswordButton()
        setupActions()
    }

    private func setupHeader() {
        view.addSubview(header.view)
        header.view.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate([
            header.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.view.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    private func setupUsernameField() {
        view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: header.view.bottomAnchor, constant: 20),
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            usernameField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPasswordField() {
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupNewUserButton() {
        view.addSubview(newUserButton)
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            newUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupActions() {
        signInButton.addAction(UIAction { [weak self] _ in
            self?.didTapSignIn()
        }, for: .touchUpInside)
        
        newUserButton.addAction(UIAction { [weak self] _ in
            self?.didTapNewUser()
        }, for: .touchUpInside)

    }
    
//    @objc private func loginButtonTapped() {
//        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
//        let (success, isParent) = viewModel.login(username: username, password: password)
//        if success {
//            let nextViewController: UIViewController
//            if isParent {
//                nextViewController = ParentViewController(viewModel: viewModel, username: username)
//            } else {
//                nextViewController = ChildViewController(viewModel: viewModel, username: username)
//            }
//            navigationController?.pushViewController(nextViewController, animated: true)
//        } else {
//            // Show error message
//        }
//    }
    
    private func didTapNewUser() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapSignIn() {
        let vc = ParentViewController(viewModel: MainViewModel(), parent: Parent(username: "exampleParent", password: "password", email: "parent@example.com", name: "John Doe", female: false, personalID: "123456", children: []))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}

