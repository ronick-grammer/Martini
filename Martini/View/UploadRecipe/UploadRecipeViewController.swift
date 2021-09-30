//
//  UploadRecipeViewController.swift
//  Martini
//
//  Created by RONICK on 2021/09/15.
//

import UIKit

class UploadRecipeViewController: UIViewController, CustomImagePickerViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 150, weight: .bold)), for: .normal)
        
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.imageView?.layer.cornerRadius = 75
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일 이름"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cocktailName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "칵테일 이름을 입력하세요."
        textField.keyboardType = .namePhonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    
    let cocktailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일 소개"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cocktailDescription: UITextView = {
        let textView = UITextView()
        textView.keyboardType = .namePhonePad
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.layer.cornerRadius = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let hStack_buttons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let baseButton: UIButton = {
        let button = UIButton()
        button.setTitle("베이스", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let tasteButton: UIButton = {
        let button = UIButton()
        button.setTitle("맛", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let ingredientButton: UIButton = {
        let button = UIButton()
        button.setTitle("재료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let colorButton: UIButton = {
        let button = UIButton()
        button.setTitle("색 선택", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let abvLabel: UILabel = {
        let label = UILabel()
        label.text = "알콜 도수"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let alcoholByVolume: UITextField = {
        let textField = UITextField()
        textField.placeholder = "알콜 도수를 입력해주세요"
        textField.keyboardType = .numbersAndPunctuation
        textField.backgroundColor = #colorLiteral(red: 0.7637431026, green: 0.7688452601, blue: 0.7643030286, alpha: 1)
        textField.layer.cornerRadius = 6
        textField.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var vStack_steps: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    let recipeFirstStep: RecipeTextView = {
        let textView = RecipeTextView()
        textView.recipeTextView.keyboardType = .namePhonePad
        textView.configure(number: "1")
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let hstack_stepButton: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.alignment = .center
        hstack.spacing = 5
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        return hstack
    }()
    
    
    let stepPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let stepRemoveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var imagePicker = CustomImagePickerView()
    var cocktailImage: UIImage?
    
    var textViewPlaceHolder: UILabel = {
        let label = UILabel()
        
        label.text = "칵테일에 대한 간단한 소개를 해주세요."
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.sizeToFit()
        label.textColor = .lightGray
        
        return label
    }()
    
    var activeBounds: CGRect? // 현재 작성 중인 뷰의 bounds
    var activeView: UIView? // 현재 작성중인 텍스트 박스(Feild or View)
    var keyboardHeight: CGFloat!
    let KEYBOARD_SPACER: CGFloat = 5 // 키보드와 텍스트 박스 사이의 높이 조절 값
    
    var array_recipeTextView = [RecipeTextView]() // 단계별 레시피 텍스트 필드
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        setupViews()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "공유", style: .plain, target: self, action: #selector(btnShareRecipe(_:)))
        
        
        imageButton.addTarget(self, action: #selector(btnImagePicker(_:)), for: .touchUpInside)
        baseButton.addTarget(self, action: #selector(btnSelection(_:)), for: .touchUpInside)
        tasteButton.addTarget(self, action: #selector(btnSelection(_:)), for: .touchUpInside)
        ingredientButton.addTarget(self, action: #selector(btnSelection(_:)), for: .touchUpInside)
        colorButton.addTarget(self, action: #selector(btnSelection(_:)), for: .touchUpInside)
        stepPlusButton.addTarget(self, action: #selector(btn_addStep), for: .touchUpInside)
        stepRemoveButton.addTarget(self, action: #selector(btn_removeStep), for: .touchUpInside)
        
        cocktailName.delegate = self
        alcoholByVolume.delegate = self
        cocktailDescription.delegate = self
        recipeFirstStep.recipeTextView.delegate = self
        imagePicker.customImagePickerViewDelegate = self
        
        // 키보드 - 화면 높이 조절
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // 화면 터치시 키보드 dismiss
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
        
        textViewPlaceHolder.frame.origin = CGPoint(x: 5, y: (cocktailDescription.font?.pointSize)! / 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        // 칵테일 정보들 초기화
        self.cocktailName.text = nil
        self.cocktailDescription.text = nil
        self.alcoholByVolume.text = nil
        self.imageButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 150, weight: .bold)), for: .normal)
        self.cocktailImage = nil
        
        textViewPlaceHolder.isHidden = false
        
        // 칵테일 레시피 초기화
        let count = self.vStack_steps.arrangedSubviews.count
        for _ in 1 ..< count {
            
            let view = self.vStack_steps.arrangedSubviews[self.vStack_steps.arrangedSubviews.count - 1]
            self.vStack_steps.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        (self.vStack_steps.arrangedSubviews[0] as! RecipeTextView).recipeTextView.text = nil
        self.array_recipeTextView.removeAll()
        self.array_recipeTextView.append(self.vStack_steps.arrangedSubviews[0] as! RecipeTextView)
        
        DATASTORE_COCKTAIL = CocktailDataStore()
    }
    
    func didSelectImage(image: UIImage) {
        imageButton.setImage(image, for: .normal)
        cocktailImage = image
    }
    
    @objc func btnImagePicker(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func btnSelection(_ sender: UIButton) {
        var vc: UIViewController?
        
        switch sender {
        case baseButton:
            vc =  UIStoryboard(name: "BasePreferenceView", bundle: Bundle.main).instantiateViewController(identifier: "basePreference")
            (vc as! BasePreferenceViewController).registrationType = .cocktail
        case tasteButton:
            vc = UIStoryboard(name: "FlavorPreferenceView", bundle: Bundle.main).instantiateViewController(identifier: "flavorPreference")
            (vc as! FlavorPreferenceViewController).registrationType = .cocktail
        case ingredientButton:
            vc = UIStoryboard(name: "IngredientsSelectionView", bundle: Bundle.main).instantiateViewController(identifier: "ingredientsSelection")
            (vc as! IngredientsSelectionViewController).registrationType = .cocktail
        case colorButton:
            vc = UIStoryboard(name: "ColorSelectionView", bundle: Bundle.main).instantiateViewController(identifier: "colorSelection")

        default:
            vc = nil
        }

        if let vc = vc {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func setUpScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        
    }
    
    func setupViews() {
        
        contentView.addSubview(imageButton)
        
        contentView.addSubview(cocktailNameLabel)
        contentView.addSubview(cocktailName)
        
        contentView.addSubview(cocktailDescriptionLabel)
        contentView.addSubview(cocktailDescription)
        cocktailDescription.addSubview(textViewPlaceHolder)
        
        contentView.addSubview(hStack_buttons)
        contentView.addSubview(colorButton)
        
        contentView.addSubview(abvLabel)
        contentView.addSubview(alcoholByVolume)
        
        contentView.addSubview(recipeLabel)
        contentView.addSubview(vStack_steps)
        contentView.addSubview(hstack_stepButton)
        
        NSLayoutConstraint.activate([
            imageButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageButton.widthAnchor.constraint(equalToConstant: 150),
            imageButton.heightAnchor.constraint(equalToConstant: 150),
            
            cocktailNameLabel.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 20),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            cocktailName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cocktailName.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 5),
            cocktailName.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            cocktailName.heightAnchor.constraint(equalToConstant: 30),
            
            cocktailDescriptionLabel.topAnchor.constraint(equalTo: cocktailName.bottomAnchor, constant: 20),
            cocktailDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            cocktailDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cocktailDescription.topAnchor.constraint(equalTo: cocktailDescriptionLabel.bottomAnchor, constant: 5),
            cocktailDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            cocktailDescription.heightAnchor.constraint(equalToConstant: 100),
            
            
            hStack_buttons.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hStack_buttons.topAnchor.constraint(equalTo: cocktailDescription.bottomAnchor, constant: 10),
            hStack_buttons.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            colorButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorButton.topAnchor.constraint(equalTo: hStack_buttons.bottomAnchor, constant: 20),
            colorButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            abvLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 20),
            abvLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            alcoholByVolume.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            alcoholByVolume.topAnchor.constraint(equalTo: abvLabel.bottomAnchor, constant: 5),
            alcoholByVolume.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            alcoholByVolume.heightAnchor.constraint(equalToConstant: 30),
            
            recipeLabel.topAnchor.constraint(equalTo: alcoholByVolume.bottomAnchor, constant: 30),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            vStack_steps.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vStack_steps.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 5),
            vStack_steps.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            hstack_stepButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hstack_stepButton.topAnchor.constraint(equalTo: vStack_steps.bottomAnchor, constant: 5),
            hstack_stepButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
            
        ])
        
        vStack_steps.addArrangedSubview(recipeFirstStep)
        NSLayoutConstraint.activate([
            recipeFirstStep.widthAnchor.constraint(equalTo: vStack_steps.widthAnchor),
            recipeFirstStep.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        hStack_buttons.addArrangedSubview(baseButton)
        hStack_buttons.addArrangedSubview(tasteButton)
        hStack_buttons.addArrangedSubview(ingredientButton)
        NSLayoutConstraint.activate([
            baseButton.widthAnchor.constraint(equalToConstant: 100),
            baseButton.heightAnchor.constraint(equalToConstant: 50),
            
            tasteButton.widthAnchor.constraint(equalToConstant: 100),
            tasteButton.heightAnchor.constraint(equalToConstant: 50),
            
            ingredientButton.widthAnchor.constraint(equalToConstant: 100),
            ingredientButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        hstack_stepButton.addArrangedSubview(stepPlusButton)
        hstack_stepButton.addArrangedSubview(stepRemoveButton)
    }
}
