import UIKit
import DropDown

protocol FormViewActionsProtocol: AnyObject {
    func didSelectSubCategory(id: Int)
    func didSelectProperty(index: Int, id: Int)
    func didSelectOptionChild(id: Int)
}

class FormView: BaseView {

    weak var delegate: FormViewActionsProtocol?

    private var labels: [PaddingLabel] = []

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var allPropertiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var mainCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Main Category", for: .normal)
        button.addTarget(self, action: #selector(mainCategoryButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.makeRoundedCorner(cornerRadius: 8, borderColor: .lightGray, borderWidth: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        return button
    }()

    lazy var subCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Sub Category", for: .normal)
        button.addTarget(self, action: #selector(subCategoryButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.makeRoundedCorner(cornerRadius: 8, borderColor: .lightGray, borderWidth: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        return button
    }()

    var propertyButtons: [UIButton] = []
    private let mainCategoryDropdown = DropDown()
    private let subCategoryDropdown = DropDown()
    private var propertyDropdowns: [DropDown] = []

    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.makeRoundedCorner(cornerRadius: 8)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        return button
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.anchor(.leading(leadingAnchor),
                          .trailing(trailingAnchor),
                          .top(topAnchor),
                          .bottom(bottomAnchor))

        scrollView.addSubview(containerView)
        containerView.anchor(.leading(scrollView.leadingAnchor),
                             .trailing(scrollView.trailingAnchor),
                             .top(scrollView.topAnchor),
                             .bottom(scrollView.bottomAnchor))

        containerView.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor
        ).isActive = true
        let constraint = containerView.heightAnchor.constraint(
            equalTo: scrollView.heightAnchor
        )
        constraint.priority = UILayoutPriority(250)
        constraint.isActive = true

        containerView.addSubview(mainStackView)
        mainStackView.anchor(
            .top(containerView.topAnchor, constant: 70),
            .leading(containerView.leadingAnchor, constant: 20),
            .trailing(containerView.trailingAnchor, constant: 20)
        )

        mainStackView.addArrangedSubview(categoryStackView)

        categoryStackView.addArrangedSubview(mainCategoryButton)
        mainCategoryButton.anchor(.height(35))
        categoryStackView.addArrangedSubview(subCategoryButton)
        subCategoryButton.anchor(.height(35))

        mainStackView.addArrangedSubview(allPropertiesStackView)

        containerView.addSubview(submitButton)
        submitButton.anchor(
            .top(mainStackView.bottomAnchor, constant: 30),
            .leading(containerView.leadingAnchor, constant: 20),
            .trailing(containerView.trailingAnchor, constant: 20),
            .bottom(containerView.bottomAnchor, constant: 30),
            .height(50)
        )
    }

    func setupPropertyButtons(properties: [Option]) {
        propertyButtons.removeAll()
        propertyDropdowns.removeAll()
        allPropertiesStackView.removeAllArrangedSubviews()
        for property in properties {
            let singlePropertyStackView = createSinglePropertyStackView()

            let button = UIButton()
            button.setTitle(property.name, for: .normal)
            button.addTarget(self, action: #selector(propertyButtonTapped(_:)), for: .touchUpInside)
            button.backgroundColor = .white
            button.makeRoundedCorner(cornerRadius: 8, borderColor: .lightGray, borderWidth: 1)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            propertyButtons.append(button)
            singlePropertyStackView.addArrangedSubview(button)
            allPropertiesStackView.addArrangedSubview(singlePropertyStackView)
        }
        setupPropertyDropdowns(properties: properties)
    }

    func setupDropdowns(categories: [Category]) {
        mainCategoryDropdown.anchorView = mainCategoryButton
        mainCategoryDropdown.dataSource = categories.map { $0.name }
        addLabel(for: mainCategoryDropdown, with: "Category", in: categoryStackView)
        mainCategoryDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.mainCategoryButton.setTitle(item, for: .normal)
            self.didSelectMainCategory(categories[index])
        }

        subCategoryDropdown.anchorView = subCategoryButton
        addLabel(for: subCategoryDropdown, with: "Sub Category", in: categoryStackView)
        subCategoryDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.subCategoryButton.setTitle(item, for: .normal)
            self.didSelectSubCategory(categories[index].children?[0] ?? SubCategory(id: 0, name: ""))
        }
    }

    func setupPropertyDropdowns(properties: [Option]) {
        for (index, property) in properties.enumerated() {
            let dropdown = DropDown()
            dropdown.anchorView = propertyButtons[index]
            var propertiesString = properties.map { $0.name }
            propertiesString.append("Other")
            dropdown.dataSource = propertiesString
            addLabel(for: dropdown, with: property.name, in: allPropertiesStackView)

            dropdown.selectionAction = { [unowned self] (selectedIndex, selectedItem) in
                if selectedIndex == properties.count {
                    self.didSelectProperty(index, nil)
                } else {
                    self.didSelectProperty(index, properties[selectedIndex])
                }
            }
            propertyDropdowns.append(dropdown)
        }
    }

    @objc private func mainCategoryButtonTapped() {
        mainCategoryDropdown.show()
    }

    @objc private func subCategoryButtonTapped() {
        subCategoryDropdown.show()
    }

    @objc private func propertyButtonTapped(_ sender: UIButton) {
        guard let index = propertyButtons.firstIndex(of: sender) else { return }
        propertyDropdowns[index].show()
    }

    private func didSelectMainCategory(_ category: Category) {
        let subcategories = category.children ?? []
        subCategoryDropdown.dataSource = subcategories.map { $0.name }
        subCategoryDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.subCategoryButton.setTitle(item, for: .normal)
            self.didSelectSubCategory(subcategories[index])
        }

        for subview in allPropertiesStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }

    private func didSelectSubCategory(_ subCategory: SubCategory) {
        for subview in allPropertiesStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }

        self.delegate?.didSelectSubCategory(id: subCategory.id)
    }

    private func didSelectProperty(_ index: Int, _ selectedProperty: Option?) {
        // Remove existing input field for the selected property if it exists
        let existingInputField = allPropertiesStackView.arrangedSubviews.first { view in
            if let textField = view as? UITextField, textField.tag == index {
                return true
            }
            return false
        }

        if let existingInputField = existingInputField {
            existingInputField.removeFromSuperview()
        }

        if selectedProperty == nil {
            propertyButtons[index].setTitle("Other", for: .normal)
            showInputField(for: index)
        } else {
            propertyButtons[index].setTitle(selectedProperty?.name, for: .normal)
            self.delegate?.didSelectProperty(index: index, id: selectedProperty!.id)
        }
        rebuildPropertyStackView()
    }

    func updateChildPropertyDropdown(at index: Int, with childProperties: [Option]) {
        guard index + 1 < propertyDropdowns.count else { return }

        // Check bounds for allPropertiesStackView
        guard index + 2 <= allPropertiesStackView.arrangedSubviews.count else { return }

        propertyDropdowns[index + 1].dataSource = childProperties.map({ $0.name })

        // Remove existing buttons and labels for child properties
        let upperBound = min(index + 2, allPropertiesStackView.arrangedSubviews.count)
        for i in 0 ..< upperBound {
            guard (i - 2) < labels.count, (i - 2) >= 0 else { continue }  // Check bounds for labels array
            allPropertiesStackView.arrangedSubviews[i].removeFromSuperview()
            labels[i - 2].removeFromSuperview()
        }
    }

    private func addLabel(for dropDown: DropDown, with title: String, in stackView: UIStackView) {
        let label = PaddingLabel()
        label.text = title
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.backgroundColor = .white
        stackView.addSubview(label)
        labels.append(label) // Store the label in the array

        if let anchorButton = dropDown.anchorView as? UIButton {
            // Set constraints for the label relative to the anchorButton
            label.anchor(
                .bottom(anchorButton.topAnchor, constant: -5),
                .leading(anchorButton.leadingAnchor, constant: 15)
            )
        }
    }

    private func showInputField(for index: Int) {
        guard index < propertyButtons.count else { return }

        let singlePropertyStackView = allPropertiesStackView.arrangedSubviews[index] as? UIStackView

        let inputField = UITextField()
        inputField.placeholder = "Enter custom value"
        inputField.borderStyle = .roundedRect
        inputField.tag = index // Assign a unique tag to identify the text field later

        if let existingInputField = singlePropertyStackView?.arrangedSubviews.compactMap({ $0 as? UITextField }).first {
            // If there's already an input field, replace it
            existingInputField.removeFromSuperview()
        }

        singlePropertyStackView?.addArrangedSubview(inputField)

        // Set constraints for the inputField relative to the previous button
        if index > 0 {
            inputField.anchor(
                .leading(propertyButtons[index - 1].trailingAnchor, constant: 15)
            )
        } else {
            // If it's the first input field, set constraints relative to mainCategoryButton
            inputField.anchor(
                .leading(mainCategoryButton.trailingAnchor, constant: 15)
            )
        }
    }


    private func rebuildPropertyStackView() {
        resetStackView(stackView: allPropertiesStackView)

        // Add other views or input fields based on the user's selections
        // For example, add property buttons and input field if a property is selected
        for button in propertyButtons {
            allPropertiesStackView.addArrangedSubview(button)
        }
    }

    private func resetStackView(stackView: UIStackView) {
        // Remove all arrangedSubviews from the stackView
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()

            // Also remove the corresponding label from the array
            if let label = subview as? PaddingLabel, let index = labels.firstIndex(of: label) {
                labels.remove(at: index)
            }
        }
    }

    private func createSinglePropertyStackView() -> UIStackView {
        let singlePropertyStackView = UIStackView()
        singlePropertyStackView.axis = .vertical
        singlePropertyStackView.spacing = 15
        return singlePropertyStackView
    }
}
