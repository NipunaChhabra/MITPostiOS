//
//  SLCMViewController.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 28/06/21.
//

import UIKit
import SDWebImage

class SLCMViewController: UIViewController, UITextFieldDelegate {
    
//    MARK:- Properties
    
    var captcha: CaptchaModel?
    
    
   private var slcmData:[SlcmData]?
    
    lazy var mitPostLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "postLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.setDimensions(width: 150, height: 150)
        return imageView
    }()
    
    lazy var registrationNumberField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var captchaField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    lazy var loginButton: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.backgroundColor = .systemOrange
        button.setTitle("Login", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        if isSmalliPhone(){
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }else{
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        button.layer.cornerRadius = isSmalliPhone() ? 20 : 25
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    lazy var captchaImageView: LoadingImageView = {
        let iv = LoadingImageView()
        iv.contentMode = .scaleToFill
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.setDimensions(width: view.frame.width/3+16, height: 84)
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.backgroundColor = .gray
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        return iv
        }()
    
    lazy var refreshcaptchaImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "arrow.clockwise")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        iv.setDimensions(width: 30, height: 30)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshCaptcha)))
        return iv
        }()
    
    let slcmInternalVC = SlcmInternalController(style: .grouped)

    var slcmNav : UINavigationController?
   

    
//    MARK:- Lifecycle functions
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slcmInternalVC.slcmController = self
//        navigationController?.navigationBar.prefersLargeTitles = true
        self.slcmNav = MasterNavigationBarController(rootViewController: slcmInternalVC)
        if(UserDefaults.standard.isLoggedIn()){
            setupViewLoggedIn()
        }else{
            setupNavigationBar()
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
            observeKeyboardNotifications()
            setupViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "defaultBG")
        setupNavigationBar()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        observeKeyboardNotifications()
        setupViews()
        getCaptcha()
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func setupViewLoggedIn(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        let navSlcmInternal = MasterNavigationBarController(rootViewController: slcmInternalVC)
        UserDefaults.standard.setIsLoggedIn(value: true)
        if let nav = slcmNav{
        view.addSubview(nav.view!)
        nav.view.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        }
    }
    
    
//MARK:- Helper functions
    
   

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @objc func hideKeyboard(){
        view.endEditing(true)
    }

    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.mitPostLogoImageView.alpha = 1
        }, completion: nil)
    }
    
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            var y: CGFloat = -100
            if self.isSmalliPhone(){
                y = -80
            }
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            self.mitPostLogoImageView.alpha = 0
        }, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.tag)
        if textField.tag == 0{
            passwordField.becomeFirstResponder()
        }else if(textField.tag == 1){
            captchaField.becomeFirstResponder()
        }else{
            hideKeyboard()
        }
        return true
    }
    
    @objc func infoPressed(){
     let vc =  InfoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doneButtonTapped(){
        passwordField.becomeFirstResponder()
    }
    
    @objc func refreshCaptcha(){
        self.captchaImageView.image = nil
        self.captchaImageView.showLoading()
        Networking.sharedInstance.getCaptchaData(method: HTTPMethods.get.description) { captchaData in
            self.captchaImageView.hideLoading()
            self.captcha = captchaData
            self.captchaImageView.sd_setImage(with: captchaData.imageUrl!, completed: nil)
            self.captchaImageView.backgroundColor = .clear
        } errorCompletion: { error in
            self.captchaImageView.hideLoading()
            print("Error in fetching captcha", error)
        }
        
    }
    
    func getCaptcha(){
        captchaImageView.showLoading()
        Networking.sharedInstance.getCaptchaData(method: HTTPMethods.get.description) { captchaData in
            self.captchaImageView.hideLoading()
            self.captcha = captchaData
            self.captchaImageView.sd_setImage(with: captchaData.imageUrl!, completed: nil)
        } errorCompletion: { error in
            self.captchaImageView.hideLoading()
            print("Error in fetching captcha", error)
        }

    }
    
    
//    MARK:- Setting up UI
    fileprivate func setupNavigationBar(){
//        navigationController.pre
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "SLCM"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3")?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(infoPressed))

    }
    
    func setupViews(){
        
        registrationNumberField.configure(color: UIColor(named: "noticeTitleColor")!,
                             font: isSmalliPhone() ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 18),
                                       cornerRadius: isSmalliPhone() ? 2 : 5,
                                       borderColor:  .systemOrange,
                                       backgroundColor:  UIColor(named: "articleCellBG")!,
                                       borderWidth: 1.0)
        registrationNumberField.keyboardType = .numberPad
        registrationNumberField.autocorrectionType = .no
        registrationNumberField.autocapitalizationType = .none
        registrationNumberField.placeholder = "Registration Number"
        registrationNumberField.clipsToBounds = true
        registrationNumberField.delegate = self
        registrationNumberField.tag = 0
        registrationNumberField.addDoneToolbar(onDone: (target: self, action: #selector(doneButtonTapped)))
        registrationNumberField.attributedPlaceholder = NSAttributedString(string: "Registration Number", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: isSmalliPhone() ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 18)
            ])
        
        
        passwordField.configure(color: UIColor(named: "noticeTitleColor")!,
                                font: isSmalliPhone() ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 18),
                                cornerRadius: isSmalliPhone() ? 2 : 5,
                                borderColor: .systemOrange,
                                backgroundColor: UIColor(named: "articleCellBG")!,
                                borderWidth: 1.0)
        passwordField.isSecureTextEntry = true
        passwordField.clipsToBounds = true
        passwordField.delegate = self
        passwordField.tag = 1
        passwordField.attributedPlaceholder = NSAttributedString(string: "SCLM Password", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: isSmalliPhone() ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 18)
            ])
        
        
        
        captchaField.configure(color: UIColor(named: "noticeTitleColor")!,
                                font: isSmalliPhone() ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 18),
                                cornerRadius: isSmalliPhone() ? 2 : 5,
                                borderColor: .systemOrange,
                                backgroundColor:  UIColor(named: "articleCellBG")!,
                                borderWidth: 1.0)
        captchaField.isSecureTextEntry = false
        captchaField.clipsToBounds = true
        captchaField.delegate = self
        captchaField.tag = 2
        captchaField.attributedPlaceholder = NSAttributedString(string: "Enter Captcha", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: isSmalliPhone() ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 18)
            ])

        if captcha != nil{
            if let url = captcha?.imageUrl{
            captchaImageView.sd_setImage(with: url, completed: nil)
            }
        }
        
        if isSmalliPhone(){
            view.addSubview(mitPostLogoImageView)
            mitPostLogoImageView.setDimensions(width: 100, height: 100)
            mitPostLogoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
            
            view.addSubview(registrationNumberField)
            _ = registrationNumberField.anchor(top: mitPostLogoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 48, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 40)
            
            
            view.addSubview(passwordField)
            _ = passwordField.anchor(top: registrationNumberField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 40)
            
            view.addSubview(captchaField)
            _ = captchaField.anchor(top: passwordField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 40)
            
            view.addSubview(captchaImageView)
            captchaImageView.setDimensions(width:view.frame.width/3+16, height: 64)
            captchaImageView.centerX(inView: view, topAnchor: captchaField.bottomAnchor, paddingTop: 16)
            
            view.addSubview(refreshcaptchaImageView)
            refreshcaptchaImageView.setDimensions(width: 30, height: 30)
            refreshcaptchaImageView.anchorWithConstants(top: captchaImageView.topAnchor, left: captchaImageView.rightAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 0)
            
    
            
            view.addSubview(loginButton)
            _ = loginButton.anchor(top: captchaImageView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 16, leftConstant: 48, bottomConstant: 16, rightConstant: 48, widthConstant: 120, heightConstant: 40)
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
        }else{
            view.addSubview(mitPostLogoImageView)
            mitPostLogoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24)
            
            view.addSubview(registrationNumberField)
            _ = registrationNumberField.anchor(top: mitPostLogoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 32, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 50)
            view.addSubview(passwordField)
            _ = passwordField.anchor(top: registrationNumberField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 50)
            
            view.addSubview(captchaField)
            _ = captchaField.anchor(top: passwordField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 50)
            
            view.addSubview(captchaImageView)
            captchaImageView.centerX(inView: view, topAnchor: captchaField.bottomAnchor, paddingTop: 16)
            
            view.addSubview(refreshcaptchaImageView)
            refreshcaptchaImageView.anchorWithConstants(top: captchaImageView.topAnchor, left: captchaImageView.rightAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 16, bottomConstant: 0, rightConstant: 0)
            
            
            view.addSubview(loginButton)
            _ = loginButton.anchor(top: captchaImageView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 32, leftConstant: 64, bottomConstant: 16, rightConstant: 64, widthConstant: 150, heightConstant: 50)
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    
//    MARK:- API call
    
    @objc func handleLogin(){
        
        self.hideKeyboard()
        
        guard let id = captcha?.id else { return}
        
        guard let token = captchaField.text else {return}
        
        guard let registration = registrationNumberField.text else{return}
        
        guard let password = passwordField.text else{ return}
        
        
        loginButton.showLoading()
        loginButton.activityIndicator.tintColor = .white
        
        
        Networking.sharedInstance.getSLCMData(method: HTTPMethods.post.description, id: id , token: token, registration: String(registration), password: password) { slcmData in
           
            if let nav = self.slcmNav{
            Caching.sharedInstance.saveSlcmDataToCache(slcmData: slcmData ?? nil)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.view.addSubview(nav.view!)
            nav.view.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor)
            UserDefaults.standard.setIsLoggedIn(value: true)
                self.loginButton.hideLoading()
            }
        } errorCompletion: { err in
            print("Error in fetching data",err)
            self.loginButton.hideLoading()
        }

       
    }
    
    
    @objc func handleLogout(){
        
        let actionSheet = UIAlertController(title: "Are you sure you want to log out?", message: nil, preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let sureAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.synchronize()
            if let nav = self.slcmNav{
                nav.view!.removeFromSuperview()
            }
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.setupViews()
            self.captchaImageView.image = nil
            self.captchaField.text = ""
        }
        actionSheet.addAction(sureAction)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
        
    }



}
