import UIKit
import DropDown

protocol FormViewActionsProtocol: AnyObject {
    func didSelectMainCategory(mainCatId: Int)
    func didSelectSubCategory(mainCatId: Int, subCatId: Int)
    func didSelectOption(mainCatId: Int, subCatId: Int, propertyId: Int, optionId: Int?, other: Bool?, otherValue: String?)
    func didSelectOptionChild(mainCatId: Int, subCatId: Int, propertyId: Int, optionId: Int, childPropertyId: Int)
}

@objc protocol DropDownBtnsAction: AnyObject {
    func didTapOption(propertyId: Int)
}

class FormView: BaseView {

    weak var delegate: FormViewActionsProtocol?
    weak var dropDownBtnsAction: DropDownBtnsAction?

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
        stackView.distribution = .fill
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
    private var optionDropdowns: [Int: [DropDown]] = [:]
    var optionyButtons: [Int: [UIButton]] = [:]

    lazy var submitButton: UIButton = {
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
            .top(containerView.topAnchor),
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
            .bottom(containerView.bottomAnchor, constant: 80),
            .height(50)
        )
    }

    func setupMainCategoriesDropdown(categories: [Category]) {
        mainCategoryDropdown.anchorView = mainCategoryButton
        mainCategoryDropdown.dataSource = categories.map { $0.name }
        addLabel(for: mainCategoryButton, with: "Category", in: categoryStackView)
        mainCategoryDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.mainCategoryButton.setTitle(item, for: .normal)
            self.delegate?.didSelectMainCategory(mainCatId: categories[index].id)
        }
        guard let selectedCategory = categories.first(where: { $0.selected ?? false }) else {return}
        mainCategoryButton.setTitle(selectedCategory.name, for: .normal)
        setUpSubCategoriesDropdown(categories: categories)
    }

    func setUpSubCategoriesDropdown(categories: [Category]) {
        subCategoryDropdown.anchorView = subCategoryButton
        addLabel(for: subCategoryButton, with: "Sub Category", in: categoryStackView)
        guard let selectedCategory = categories.first(where: {$0.selected ?? false}), let subCategories = selectedCategory.children else {return}
        subCategoryDropdown.dataSource = subCategories.map { $0.name }
        subCategoryDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.subCategoryButton.setTitle(item, for: .normal)
            self.delegate?.didSelectSubCategory(mainCatId: selectedCategory.id, subCatId: subCategories[index].id)
        }
        guard let selectedSubCategory = subCategories.first(where: { $0.selected == true }) else {return}
        subCategoryButton.setTitle(selectedSubCategory.name, for: .normal)
        allPropertiesStackView.removeAllArrangedSubviews()
        setupPropertyButtons(categories: categories)
    }

    func setupPropertyButtons(categories: [Category]) {
        propertyButtons = []
        guard let selectedCategory = categories.first(where: {$0.selected ?? false}),
              let subCategories = selectedCategory.children,
              let selectedSubCategory = subCategories.first(where: { $0.selected == true }),
              let properties = selectedSubCategory.options else {return}
        for property in properties {
            let singlePropertyStackView = createSinglePropertyStackView()
            let button = UIButton()
            button.setTitle(property.name, for: .normal)
            button.addTarget(self, action: #selector(propertyButtonTapped(_:)), for: .touchUpInside)
            button.backgroundColor = .white
            button.makeRoundedCorner(cornerRadius: 8, borderColor: .lightGray, borderWidth: 1)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            if let selectedOption = property.options?.first(where: {$0.selected ?? false}) {
                button.setTitle(selectedOption.name, for: .normal)
            }
            propertyButtons.append(button)
            singlePropertyStackView.addArrangedSubview(button)
            addLabel(for: button, with: property.name, in: singlePropertyStackView)
            if property.other ?? false {
                let textField = UITextField()
                textField.placeholder = "Other"
                textField.borderStyle = .roundedRect
                button.setTitle("Other", for: .normal)
                singlePropertyStackView.addArrangedSubview(textField)
                textField.anchor(.height(35),
                                 .leading(singlePropertyStackView.leadingAnchor),
                                 .trailing(singlePropertyStackView.trailingAnchor))
                textField.text = property.otherValue ?? ""
            }
            guard let selectedOptions = property.options?.filter({$0.selected ?? false && $0.options?.isEmpty == false}),
                  !selectedOptions.isEmpty else {
                allPropertiesStackView.addArrangedSubview(singlePropertyStackView)
                continue
            }
            setUpChildOptionsDropdownButtons(singlePropertyStackView: singlePropertyStackView, categoryId: selectedCategory.id, subCategoryId: selectedSubCategory.id, propertId: property.id, options: selectedOptions)
            allPropertiesStackView.addArrangedSubview(singlePropertyStackView)
        }
        setupPropertiesDropdowns(categoryId: selectedCategory.id, subCategoryId: selectedSubCategory.id, properties: properties)
    }

    func setupPropertiesDropdowns(categoryId: Int, subCategoryId: Int, properties: [Propery]) {
        propertyDropdowns = []
        for propertyIndex in 0...properties.count - 1 {
            let dropdown = DropDown()
            dropdown.anchorView = propertyButtons[propertyIndex]
            var optionsString = properties[propertyIndex].options?.map { $0.name } ?? []
            optionsString.append("Other")
            dropdown.dataSource = optionsString
            dropdown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let self = self else { return }
                if item == "Other" {
                    let textField = allPropertiesStackView.arrangedSubviews[propertyIndex] as? UITextField
                    self.delegate?.didSelectOption(mainCatId: categoryId,
                                                   subCatId: subCategoryId,
                                                   propertyId: properties[propertyIndex].id,
                                                   optionId: nil,
                                                   other: true,
                                                   otherValue: textField?.text ?? "")
                } else {
                    self.delegate?.didSelectOption(mainCatId: categoryId,
                                                   subCatId: subCategoryId,
                                                   propertyId: properties[propertyIndex].id,
                                                   optionId: properties[propertyIndex].options?[index].id ?? 0,
                                                   other: false,
                                                   otherValue: nil)
                }
            }
            propertyDropdowns.append(dropdown)
        }
    }

    func setUpChildOptionsDropdownButtons(singlePropertyStackView: UIStackView, categoryId: Int, subCategoryId: Int, propertId: Int, options: [Option]) {
        optionyButtons[propertId] = [UIButton]()
        for optionIndex in 0...options.count - 1 {
            let option = options[optionIndex]
            let button = UIButton()
            button.setTitle(option.name, for: .normal)
            button.addTarget(self, action: #selector(childPropertyButtonTapped(_:)), for: .touchUpInside)
            button.backgroundColor = .white
            button.makeRoundedCorner(cornerRadius: 8, borderColor: .lightGray, borderWidth: 1)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            button.tag = propertId
            if option.selected ?? false {
                button.setTitle(option.name, for: .normal)
            }
            optionyButtons[propertId]?.append(button)
            singlePropertyStackView.addArrangedSubview(button)
            addLabel(for: button, with: option.name, in: singlePropertyStackView)
        }
        setUpChildOptionsDropdowns(mainCatId: categoryId, subCatId: subCategoryId, propertyId: propertId, options: options)
    }

    func setUpChildOptionsDropdowns(mainCatId: Int,
                                    subCatId: Int,
                                    propertyId: Int,
                                    options: [Option]) {
        optionDropdowns[propertyId] = [DropDown]()
        for optionIndex in 0...options.count - 1 {
            let dropdown = DropDown()
            dropdown.anchorView = optionyButtons[propertyId]?[optionIndex]
            dropdown.dataSource = options[optionIndex].options?.map { $0.name } ?? []
            dropdown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let self = self else { return }
                self.delegate?.didSelectOptionChild(mainCatId: mainCatId, subCatId: subCatId, propertyId: propertyId, optionId: options[optionIndex].id, childPropertyId: options[optionIndex].options?[index].id ?? 0)
            }
            optionDropdowns[propertyId]?.append(dropdown)
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

    @objc private func childPropertyButtonTapped(_ sender: UIButton) {
        let key = sender.tag
        let array = optionyButtons[key]
        guard let index = array?.firstIndex(of: sender) else { return }
        optionDropdowns[key]?[index].show()
    }

    private func addLabel(for dropDownButton: UIButton, with title: String, in stackView: UIStackView) {
        let label = PaddingLabel()
        label.text = title
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.backgroundColor = .white
        stackView.addSubview(label)
        labels.append(label)
        label.anchor(
            .bottom(dropDownButton.topAnchor, constant: -5),
            .leading(dropDownButton.leadingAnchor, constant: 15)
        )
    }

    private func createSinglePropertyStackView() -> UIStackView {
        let singlePropertyStackView = UIStackView()
        singlePropertyStackView.axis = .vertical
        singlePropertyStackView.spacing = 15
        singlePropertyStackView.distribution = .fillEqually
        return singlePropertyStackView
    }
}
