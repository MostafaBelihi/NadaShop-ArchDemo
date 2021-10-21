//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import UIKit

class SpecialTextInput: UIView {
	private let contentNibName = "SpecialTextInput"
	
	// MARK: - Controls
	@IBOutlet private var view: UIView!
	@IBOutlet weak var viewContent: UIView!
	@IBOutlet private weak var imgIcon: UIImageView!
	@IBOutlet weak var txtInput: UITextField!
	
	// MARK: - Properties
	// Text field
	private var textPlaceholder = "";
	private var isSecureField = false;

	@IBInspectable
	var text: String {
		set {
			txtInput.text = newValue;
		}
		get {
			return txtInput.text ?? "";
		}
	}

	@IBInspectable
	var placeholder: String {
		set {
			if ((txtInput.text?.isEmpty)! || txtInput.text == textPlaceholder) {
				txtInput.text = newValue;
				txtInput.textColor = AppColor.textSecondary;
			}

			textPlaceholder = newValue;
		}
		get {
			return textPlaceholder;
		}
	}
	
	@IBInspectable
	var contentType: UITextContentType {
		set {
			txtInput.textContentType = newValue
		}
		get {
			return txtInput.textContentType;
		}
	}
	
	@IBInspectable
	var keyboardType: UIKeyboardType {
		set {
			txtInput.keyboardType = newValue
		}
		get {
			return txtInput.keyboardType;
		}
	}
	
	@IBInspectable
	var isSecureTextEntry: Bool {
		set {
			txtInput.isSecureTextEntry = newValue;
		}
		get {
			return txtInput.isSecureTextEntry;
		}
	}

	// Icon
	@IBInspectable
	var iconIsShown: Bool = true;
	
	@IBInspectable
	var iconIsInLeft: Bool = true;

	@IBInspectable
	var iconLeadingSpace: CGFloat = 8;

	@IBInspectable
	var iconTrailingSpace: CGFloat = 5;
	
	@IBInspectable
	var iconImage: UIImage {
		set {
			imgIcon.image = newValue
		}
		get {
			return imgIcon.image!;
		}
	}

	// MARK: - Styling
	
	
	// MARK: - Inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		Bundle.main.loadNibNamed(contentNibName, owner: self, options: nil);
		view.fixInView(self);
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()

		// Init values
		if (txtInput.text?.isEmpty)! {
			txtInput.text = textPlaceholder;
			txtInput.textColor = AppColor.textSecondary;
		}
		
		// Text direction
		if (LocaleManager.isRightToLeft) {
			txtInput.textAlignment = .right;
		}
		else {
			txtInput.textAlignment = .left;
		}
		
		view.clipsToBounds = true;
		setupTextDelegate();
		setupConstraints(iconIsShown: iconIsShown, iconIsInLeft: iconIsInLeft);
	}
	
	private func setupConstraints(iconIsShown: Bool = true, iconIsInLeft: Bool = true) {
		// Disable auto-ganerated contraints
		imgIcon.translatesAutoresizingMaskIntoConstraints = false;
		txtInput.translatesAutoresizingMaskIntoConstraints = false;

		if (iconIsShown) {
			if (iconIsInLeft) {
				// Icon
				NSLayoutConstraint.activate([
					imgIcon.heightAnchor.constraint(equalTo: imgIcon.widthAnchor, multiplier: 1/1),
					imgIcon.heightAnchor.constraint(equalToConstant: 25),
					imgIcon.centerYAnchor.constraint(equalTo: txtInput.centerYAnchor),
					imgIcon.leadingAnchor.constraint(equalTo: imgIcon.superview!.leadingAnchor, constant: iconLeadingSpace)
				]);
				
				// TextField
				NSLayoutConstraint.activate([
					txtInput.topAnchor.constraint(equalTo: txtInput.superview!.topAnchor, constant: 0),
					txtInput.leadingAnchor.constraint(equalTo: imgIcon.trailingAnchor, constant: iconTrailingSpace),
					txtInput.bottomAnchor.constraint(equalTo: txtInput.superview!.bottomAnchor, constant: 0),
					txtInput.trailingAnchor.constraint(equalTo: txtInput.superview!.trailingAnchor, constant: -8)
				]);
			}
			else {
				// TextField
				NSLayoutConstraint.activate([
					txtInput.topAnchor.constraint(equalTo: txtInput.superview!.topAnchor, constant: 0),
					txtInput.leadingAnchor.constraint(equalTo: txtInput.superview!.leadingAnchor, constant: 8),
					txtInput.bottomAnchor.constraint(equalTo: txtInput.superview!.bottomAnchor, constant: 0),
					txtInput.trailingAnchor.constraint(equalTo: imgIcon.leadingAnchor, constant: iconTrailingSpace * -1)
				]);
				
				// Icon
				NSLayoutConstraint.activate([
					imgIcon.heightAnchor.constraint(equalTo: imgIcon.widthAnchor, multiplier: 1/1),
					imgIcon.heightAnchor.constraint(equalToConstant: 25),
					imgIcon.centerYAnchor.constraint(equalTo: txtInput.centerYAnchor),
					imgIcon.trailingAnchor.constraint(equalTo: imgIcon.superview!.trailingAnchor, constant: iconLeadingSpace * -1)
				]);
			}
		}
		else {
			// Remove Icon
			imgIcon.removeFromSuperview();
			
			// TextField
			NSLayoutConstraint.activate([
				txtInput.topAnchor.constraint(equalTo: txtInput.superview!.topAnchor, constant: 0),
				txtInput.leadingAnchor.constraint(equalTo: txtInput.superview!.leadingAnchor, constant: 8),
				txtInput.bottomAnchor.constraint(equalTo: txtInput.superview!.bottomAnchor, constant: 0),
				txtInput.trailingAnchor.constraint(equalTo: txtInput.superview!.trailingAnchor, constant: -8)
			]);
		}
	}
}

// MARK: - Placeholder handling
extension SpecialTextInput : UITextFieldDelegate {
	func setupTextDelegate() {
		txtInput.delegate = self;
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if let textInput = txtInput.text, textInput == textPlaceholder {
			txtInput.text = nil;
			txtInput.textColor = AppColor.textPrimary;
			txtInput.isSecureTextEntry = isSecureField;
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if (txtInput.text?.isEmpty)! {
			txtInput.text = textPlaceholder;
			txtInput.textColor = AppColor.textSecondary;
			txtInput.isSecureTextEntry = false;
		}
	}
}
