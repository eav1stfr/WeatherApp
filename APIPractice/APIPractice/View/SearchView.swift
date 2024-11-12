import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchButtonPressed()
}

final class SearchView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: SearchViewDelegate?
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    let textField = TextFieldView(placeH: "Search", width: 250)
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(searchButton)
        return stack
    }()
    
    @objc private func searchButtonPressed() {
        delegate?.searchButtonPressed()
    }
}

private extension SearchView {
    private func setupView() {
        addSubviews()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        searchButton.isUserInteractionEnabled = true
        
    }
    
    private func addSubviews() {
        addSubview(stack)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
