//
//  ViewController.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    // ViewModel
    let viewModel = StatusViewModel()
    
    // Views
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.backgroundColor = .black
        activityIndicatorView.alpha = 0
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .allCharacters
        return textField
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        setupTableView()
        setupTextField()
        bindViewModel()
    }
    
    func addSubViews() {
        view.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            inputTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            inputTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            inputTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RoadStatusCell.self, forCellReuseIdentifier: RoadStatusCell.cellReuseIdentifier)
        
        let dismissKeyboardGesture = UITapGestureRecognizer(
            target: self, action: #selector(hideKeyboard)
        )
        dismissKeyboardGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(dismissKeyboardGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func setupTextField() {
        inputTextField.delegate = self
        inputTextField.placeholder = viewModel.imputPlaceholder
    }
    
    func bindViewModel() {
        viewModel.tableViewStatusRow.bindValue { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.isLoading.bindValue{ [weak self] (isLoading: Bool) in
            if isLoading {
                self?.activityIndicatorView.startAnimating()
                self?.activityIndicatorView.alpha = 0.4
            } else {
                self?.activityIndicatorView.stopAnimating()
                self?.activityIndicatorView.alpha = 0
            }
        }
        
        viewModel.alert.bindValue { [weak self] (model: AlertModel?) in
            if let model = model {
                let alert = UIAlertController(
                    title: model.title,
                    message: model.message,
                    preferredStyle: UIAlertController.Style.alert
                )
                alert.addAction(
                    UIAlertAction(
                        title: model.button,
                        style: UIAlertAction.Style.default,
                        handler: { _ in
                            self?.viewModel.alert.value = nil
                        }
                    )
                )
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.searchRoads(text: textField.text)
        return true
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewStatusRow.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoadStatusCell.cellReuseIdentifier)
        
        if let cell = cell as? RoadStatusCell {
            cell.setupWithModel(model: viewModel.tableViewStatusRow.value[indexPath.row])
        }
        return cell!
    }
    
}
