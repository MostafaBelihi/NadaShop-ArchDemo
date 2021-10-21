//
//  LanguageSwitcher.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 20/08/2021.
//

import UIKit

class LanguageSwitcher: UIAlertController {
	func config(completed: @escaping VoidClosure) {
		title = NSLocalizedString("chooseLang", comment: "");
		message = "";

		// Add languages as actions
		for lang in Language.allCases {
			let langActionButton = UIAlertAction(title: lang.name, style: .default) { action -> Void in
				if(LocaleManager.languageCode! != lang.code) {
					Bundle.set(language: lang);
					completed();
				}
			}
			
			addAction(langActionButton);
		}
		
		// Cancel actions
		let cancelActionButton = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil);
		addAction(cancelActionButton);
	}
}
