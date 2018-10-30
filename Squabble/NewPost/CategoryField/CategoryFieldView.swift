//
//  CategoryFieldView.swift
//  Squabble
//
//  Created by Brandon In on 10/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol CategoryFieldViewDelegate{
    func setCategory(category: Category);
}

class CategoryFieldView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var categories: [Category]?
//    var selectedCategory: Category?;
    
    var categoryFieldDelegate: CategoryFieldViewDelegate?;
    
    lazy var categoryTitleLabel: NormalUILabel = {
        let categoryTitleLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        categoryTitleLabel.text = "Category: ";
        return categoryTitleLabel;
    }()
    
    lazy var categoryField: NormalUITextField = {
        let categoryField = NormalUITextField();
        categoryField.translatesAutoresizingMaskIntoConstraints = false;
        categoryField.text = "General";
        categoryField.textColor = UIColor.black;
        categoryField.font = UIFont.montserratRegular(fontSize: 14);
        categoryField.layer.borderWidth = 0.5;
        categoryField.layer.borderColor = UIColor.black.cgColor;
        categoryField.textAlignment = .center;
        return categoryField;
    }()
    
    lazy var pickerView = UIPickerView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        
        setupCategoryTitleLabel();
        setupCategoryField();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCategoryTitleLabel(){
        self.addSubview(categoryTitleLabel);
        categoryTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        categoryTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        categoryTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        categoryTitleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
    }
    
    fileprivate func setupCategoryField(){
        self.addSubview(categoryField);
        categoryField.leftAnchor.constraint(equalTo: self.categoryTitleLabel.rightAnchor).isActive = true;
        categoryField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        categoryField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        categoryField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        categoryField.inputView = self.pickerView;
        
        categoryField.addTarget(self, action: #selector(self.handleMoveFrameUp), for: .editingDidBegin)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories!.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories![row].categoryName!;
    }
    
    func resignTextField(){
        self.categoryField.resignFirstResponder();
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryField.text = categories![row].categoryName!;
        
        let selectedCategory = categories![row];
        self.categoryFieldDelegate?.setCategory(category: selectedCategory);
    }
    
}

extension CategoryFieldView{
    @objc func handleMoveFrameUp(){
        let name = Notification.Name(rawValue: categoryPickerNotification);
        NotificationCenter.default.post(name: name, object: nil);
    }
}
