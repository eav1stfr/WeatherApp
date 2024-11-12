import UIKit

final class TextFieldView: UITextField {
    private var placeHolderText: String
    private let textFieldWidth: CGFloat
    
    init(frame: CGRect = .zero, placeH: String, width: CGFloat) {
        self.placeHolderText = placeH
        self.textFieldWidth = width
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        placeholder = placeHolderText
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        
        layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        rightViewMode = .always
        leftViewMode = .always
        textColor = .black
        
        tintColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        setupConstraints()
    }
    
    private func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: self.textFieldWidth).isActive = true
    }
}
