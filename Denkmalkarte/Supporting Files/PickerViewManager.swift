//
//  PickerViewManager.swift
//  Denkmalkarte
//
//  Created by Julian on 1/11/19.
//  Copyright © 2019 htw.berlin. All rights reserved.
//

import Foundation
import UIKit

enum PickerOption: Int, CustomStringConvertible, CaseIterable {

    case title = 0
    case text
    case bauherr
    case strasse
    case datierung
    case ort
    
    var description: String {
        switch self {
        case .title: return "Title"
        case .text: return "Text"
        case .bauherr: return "Bauherr"
        case .strasse: return "Strasse"
        case .datierung: return "Datierung"
        case .ort: return "Ort"
        }
    }
}

protocol PickerManagerDelegate: class {
    func manager(_ manager: PickerManager, didPickOption option: PickerOption)
}

class PickerManager: NSObject {

    lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setOption))
        return doneButton
    }()

    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }()

    let optionPicker = UIPickerView()

    private var option: PickerOption

    weak var delegate: PickerManagerDelegate?

    init(option: PickerOption?) {
        self.option = option ?? .title
        super.init()
        optionPicker.delegate = self
        optionPicker.dataSource = self
        optionPicker.selectRow(self.option.rawValue, inComponent: 0, animated: false)
    }

    // MARK: - Helpers

    @objc private func setOption() {
        delegate?.manager(self, didPickOption: option)
    }
}

extension PickerManager: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerOption.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerOption(rawValue: row)?.description
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        option = PickerOption(rawValue: row) ?? .title
    }
}
