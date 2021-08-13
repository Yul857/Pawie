//
//  LoginController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/6/21.
//

import UIKit

protocol AuthenticationDelegate: class {
    func authenticationDidComplete()
}

class LoginController: UIViewController {
    //MARK: - Properties
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
       
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextfield: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)

        return button
    }()
    
    private let forgetPasswordtButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forget your password?", secondPart: "Get help signing in")
        button.addTarget(self, action:#selector(handleShowResetPassword), for: .touchUpInside)

        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Actions
    
    @objc func handleShowResetPassword() {
        let controller =  ResetPasswordController()
        controller.delegate = self
        controller.email = emailTextField.text
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleShowSignUp(){
        let controller = RegisterController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
        print("Button tapped")
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField{
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }

        updateForm()
    }
    
    @objc func handleLogIn() {
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextfield.text else{return}
        AuthService.LogUserIn(withEmail: email, password: password) { (results, error) in
            if let error = error{
                print("DEBUG: Failed to Log User in, \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete()
        }

    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextfield, loginButton, forgetPasswordtButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: - FormViewModel

extension LoginController: formViewModel{
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}

//MARK: ResetPasswordControllerDelegate

extension LoginController: ResetPasswordControllerDelegate {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordController) {
        print("viola")
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: "Success",
                    message: "We sent a link to your email to reset your password")
    }
    
    
}
