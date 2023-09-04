//
//  CreateViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 02.09.2023.
//

import UIKit
import IQKeyboardManagerSwift

class CreateViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9450979829, green: 0.9450979829, blue: 0.9450981021, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "highlighter"), for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .white
        button.tintColor = .black
        button.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleRecipe: CreateTextField = {
        let tf = CreateTextField()
        tf.placeholder = "Enter recipe title "
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.red.cgColor
        tf.layer.borderWidth = 1
        tf.tag = 3
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        tf.smartInsertDeleteType = .no
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var servesView = CreateView()
    
    private lazy var cookTimeView = CreateView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.cellID)
        tableView.register(AddIngredientTableViewCell.self, forCellReuseIdentifier: AddIngredientTableViewCell.cellID)
        tableView.register(IngredientHeaderView.self, forHeaderFooterViewReuseIdentifier: IngredientHeaderView.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var createRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create recipe", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 16)
        button.layer.cornerRadius = 10
        button.backgroundColor = .primaryColor
//        button.isEnabled = false
        button.addTarget(self, action: #selector(createRecipeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var activeTextField: UITextField? = nil
        
    // MARK: - Properties For Realm
    
    private var titleNewRecipe = ""
    private var ingredients: [String: String] = [:]
    
    // MARK: - Life View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleRecipe)
        stackView.addArrangedSubview(servesView)
        servesView.congigureView(with: .serves, and: .serves)
        stackView.addArrangedSubview(cookTimeView)
        cookTimeView.congigureView(with: .cookTime, and: .cookTime)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            titleRecipe.heightAnchor.constraint(equalToConstant: 43.6),
            servesView.heightAnchor.constraint(equalToConstant: 60),
            cookTimeView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        imageView.addSubview(addImageButton)
        NSLayoutConstraint.activate([
            addImageButton.widthAnchor.constraint(equalToConstant: 32),
            addImageButton.heightAnchor.constraint(equalToConstant: 32),
            addImageButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            addImageButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8)
        ])
        
        view.addSubview(createRecipeButton)
        NSLayoutConstraint.activate([
            createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13),
            createRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createRecipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: createRecipeButton.topAnchor, constant: -16)
        ])
        
        servesView.button.addTarget(self, action: #selector(servesViewButtonTapped), for: .touchUpInside)
        cookTimeView.button.addTarget(self, action: #selector(cookTimeViewButtonTapped), for: .touchUpInside)
    }

    // MARK: - Objc Methods
    
    @objc func addImageButtonTapped() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    @objc func createRecipeButtonTapped() {
        print(#function)
//        saveInfoAboutIngredients()
    }
    
    @objc func servesViewButtonTapped() {
        print(#function)
        showAlert(title: "Serves", message: "Specify the number of persons") { text in
            print(text)
            self.servesView.countLabel.text = text
        }
    }
    
    @objc func cookTimeViewButtonTapped() {
        print(#function)
        showAlert(title: "Cook time", message: "Specify the cooking time of the dish (minutes)") { text in
            print(text)
            self.cookTimeView.countLabel.text = "\(text) min"
        }
    }
    
    @objc func deleteIngredientButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        if (ingredients.count + 2) != 2 {
            let index = sender.tag
            let indexPath = IndexPath(row: index, section: 0)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY
            let topOfKeyboard = view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
            
            if shouldMoveViewUp {
                view.frame.origin.y = 0 - keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
}

// MARK: - UITableViewDataSource

extension CreateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastIndex = tableView.numberOfRows(inSection: 0) - 1
        
        switch indexPath.row {
        case lastIndex:
            guard let addCell = tableView.dequeueReusableCell(withIdentifier: AddIngredientTableViewCell.cellID, for: indexPath) as? AddIngredientTableViewCell
            else { return UITableViewCell() }
            return addCell
        default:
            guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.cellID, for: indexPath) as? IngredientTableViewCell
            else { return UITableViewCell() }
            
            ingredientCell.configureCell(for: indexPath)
            ingredientCell.deleteIngredientButton.addTarget(self, action: #selector(deleteIngredientButtonTapped), for: .touchUpInside)
            ingredientCell.selectionStyle = .none
            ingredientCell.nameIngredient.delegate = self
            ingredientCell.quantityIngredient.delegate = self
            
            return ingredientCell
        }
    }
}

// MARK: - UITableViewDelegate

extension CreateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: IngredientHeaderView.reuseID) as? IngredientHeaderView
        else { return UIView() }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        numberOfRows += 1
        
        let indexRow = tableView.numberOfRows(inSection: 0) - 1
        print("indexRow: \(indexRow)")
        
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.reloadData()
        
//        if indexPath.row == indexRow {
//            guard let ingredientCell = tableView.cellForRow(at: indexPath) as? IngredientTableViewCell else { return }
//        }
        
    }

}

// MARK: - UITextFieldDelegate

extension CreateViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print(#function)
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        // название рецепта
        if textField.tag == 3 {
            guard let text = textField.text, !text.isEmpty else {
                textField.resignFirstResponder()
                showAlert(title: "Warning!", message: "Enter recipe name.")
                return true
            }
            titleNewRecipe = text
        }
        
        // название ингридиента
        if textField.tag == 0 {
            guard let text = textField.text, !text.isEmpty else {
                textField.resignFirstResponder()
                showAlert(title: "Warning!", message: "Enter ingredient name.")
                return true
            }
            ingredients[text] = ""
        }
        
        // количество ингридиента
        if textField.tag == 1 {
            guard let text = textField.text, !text.isEmpty else {
                textField.resignFirstResponder()
                showAlert(title: "Warning!", message: "Enter ingredient quantity.")
                return true
            }
            guard let cell = textField.superview?.superview as? IngredientTableViewCell else { return true }
            guard let table = cell.superview as? UITableView else { return true }
            guard let indexPath = table.indexPath(for: cell) else { return true }
            guard let ingredient = cell.nameIngredient.text else { return true }
            print(ingredient)
            ingredients[ingredient] = text
        }
        
        
        print("название рецепта: \(titleNewRecipe)")
        print("ингридиенты: \(ingredients)")
        
        activeTextField = nil

        view.endEditing(true)
        return true
    }
    
    private func saveInfoAboutIngredients() {
        ingredients = [:]
        let rows = tableView.numberOfRows(inSection: 0)
        for row in 0..<rows {
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? IngredientTableViewCell else { return }
            if let ingerdient = cell.nameIngredient.text, let quantity = cell.quantityIngredient.text {
                print("ingerdient: \(ingerdient)")
                print("quantity: \(quantity)")
                ingredients[ingerdient] = quantity
            }
        }
        
        print("new ingredients: \(ingredients)")
    }

    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(#function)
//        activeTextField = nil
//        view.endEditing(true)
//        print(textField.placeholder)
//        if let text = textField.text, !text.isEmpty {
//            switch textField {
//            case titleRecipe:
//                titleNewRecipe = text
//            default:
//                print("EMPTY")
//            }
//        } else {
//            showAlert(title: "Warning!", message: "Enter recipe information")
//        }
//    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension CreateViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
//        guard let imageURL = info[.imageURL] as? String else { return }
        
//        guard let imageData = UIImageJPEGRepresentation(image) else { return }
        
        self.imageView.image = image
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        print(imagePath)
//
//        if let jpegData = image.jpegData(compressionQuality: 0.8) {
//            try? jpegData.write(to: imagePath)
//        }
        
        dismiss(animated: true)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


