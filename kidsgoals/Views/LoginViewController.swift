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
    
    private var emailField = CustomTextField(fieldType: .email)
    private var passwordField = CustomTextField(fieldType: .password)
    
    private var signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private var newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private var forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    private let roleSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Parent", "Child"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    //MARK: - Lifecycle
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
    
    //MARK: - Functions
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupHeader()
        setupRoleSegmentedControl()
        setupEmailField()
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
    
    private func setupRoleSegmentedControl() {
        view.addSubview(roleSegmentedControl)
        roleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roleSegmentedControl.topAnchor.constraint(equalTo: header.view.bottomAnchor, constant: 20),
            roleSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roleSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupEmailField() {
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: roleSegmentedControl.bottomAnchor, constant: 20),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPasswordField() {
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
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
    
    private func didTapNewUser() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapSignIn() {
        guard let username = emailField.text, let password = passwordField.text else {
            return
        }
        
        let isParent = roleSegmentedControl.selectedSegmentIndex == 0
        
        if isParent {
            // Navigate to parent view controller
            let parentVC = ParentViewController(viewModel: viewModel, parent: Parent(username: username, password: password, email: "", name: "", female: false, personalID: "", children: []))
            self.navigationController?.pushViewController(parentVC, animated: true)
        } else {
            // Navigate to child view controller
            let childVC = ChildViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(childVC, animated: true)
        }
    }
    
}
