//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import UIKit

/// Common styling constants and methods

// MARK: - Colors
struct AppColor {
	/// Config colors
	// Color strings
	static private let activeColor = "22A45D";
	static private let mainTextColor = "010F07";
	static private let bodyTextColor = "868686";
	static private let accentColor = "EF9920";
	static private let googleColor = "4285F4";
	static private let facebookColor = "395998";
	static private let inputColor = "FBFBFB";
	static private let inputStrokeColor = "F3F2F2";
	static private let bgColor = "FFFFFF";
	
	// Background
	static let viewBackgroundPrimary: UIColor = getColor(fromHex: bgColor);
	static let buttonBackgroundPrimary: UIColor = getColor(fromHex: activeColor);
	
	// Text inputs
	static let inputBackground: UIColor = getColor(fromHex: inputColor);
	static let inputStroke: UIColor = getColor(fromHex: inputStrokeColor);

	// Text
	static let textPrimary: UIColor = getColor(fromHex: mainTextColor);
	static let textSecondary: UIColor = getColor(fromHex: bodyTextColor);
	
	// Tint
	static let tintPrimary: UIColor = getColor(fromHex: activeColor);
	static let tintSecondary: UIColor = getColor(fromHex: bodyTextColor);

	// Numeric figures


	/// Resolve color code
	/// - Parameter hex: Color Hex value.
	static func getColor(fromHex hex:String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}
		
		if ((cString.count) != 6) {
			return UIColor.gray
		}
		
		var rgbValue:UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}

// MARK: - Fonts
struct AppFont {
	var size: CGFloat;
	var weight: UIFont.Weight;

	/// Constant collection of all app's font names per language and font weight
	let fontNames: [FontName] = [];

	struct FontName {
		var language: Language;
		var weight: UIFont.Weight;
		var name: String;
	}

	/// Get font name per language and font wight
	var fontName: String? {
		return fontNames.first(where: { $0.language == LocaleManager.language && $0.weight == weight })?.name;
	}
	
	/// Get UIFont from font data
	var font: UIFont {
		guard let fontName = fontName else {
			return UIFont.systemFont(ofSize: size, weight: weight);
		}
		
		return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight);
	}
}

// MARK: - Standard Text Styles
enum TextStyle {
	case h1
	case h2
	case h3
	case headline
	case subhead
	case body
	case caption
	case button
	
	var fontSize: CGFloat {
		switch self {
			case .h1: return !DeviceTrait.isLargeWindow ? 34 : 42;
			case .h2: return !DeviceTrait.isLargeWindow ? 28 : 36;
			case .h3: return !DeviceTrait.isLargeWindow ? 24 : 32;
			case .headline: return !DeviceTrait.isLargeWindow ? 30 : 38;
			case .subhead: return !DeviceTrait.isLargeWindow ? 20 : 33;
			case .body: return !DeviceTrait.isLargeWindow ? 18 : 24;
			case .caption: return !DeviceTrait.isLargeWindow ? 12 : 18;
			case .button: return !DeviceTrait.isLargeWindow ? 14 : 20;
		}
	}
	
	var fontWeight: UIFont.Weight {
		switch self {
			case .h1,
				 .h2,
				 .h3: return .bold;

			case .headline,
				 .subhead: return .semibold;

			case .body,
				 .caption,
				 .button: return .regular;
		}
	}
	
	var font: UIFont {
		return AppFont(size: fontSize, weight: fontWeight).font;
	}
}

// MARK: - Sizes
struct AppSizes {
	struct ProductsList {
		static let sectionInsetTop: CGFloat = !DeviceTrait.isLargeWindow ? 10 : 10;
		static let sectionInsetBottom: CGFloat = !DeviceTrait.isLargeWindow ? 10 : 10;
		static let sectionInsetLeft: CGFloat = !DeviceTrait.isLargeWindow ? 20 : 20;
		static let sectionInsetRight: CGFloat = !DeviceTrait.isLargeWindow ? 20 : 20;
		static let rowSpacing: CGFloat = !DeviceTrait.isLargeWindow ? 5 : 5;
		static let columnSpacing: CGFloat = !DeviceTrait.isLargeWindow ? 0 : 20;
	}
}
