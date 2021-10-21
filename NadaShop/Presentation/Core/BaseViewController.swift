//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: StyleUIViewControllerBase, ShowingLoadingIndicator, DismissingKeyboard, Scrollable, CheckingConnectionStatus, ShowingError {
	
	// MARK: - VC Events
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// Dependencies
		alert = AppDelegate.dependencyRegistry.container.resolve(Alerting.self)!;
		alert.setParentView(as: self);
		connectionkManager = AppDelegate.dependencyRegistry.container.resolve(MonitoringConnection.self)!;
		spinner = AppDelegate.dependencyRegistry.makeSpinnerView(indicatorColor: .none, backgroundColor: .none);

		// Tap Gesture
		setupTapGesture();
		
		// Connectivity
		checkConnection();

    }

	// MARK: - Spinner/Indicator
	private var spinner: SpinnerView!;
	var isFetchingData: Bool = false;
	
	internal func showIndicator(isFetchingData: Bool = false) {
		self.isFetchingData = isFetchingData;
		
		view.addSubview(spinner);
		
		// Constraints
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
	internal func hideIndicator() {
		self.isFetchingData = false;
		spinner.removeFromSuperview();
	}
	
	// MARK: - Error View
	private var alert: Alerting!;
	
	internal func showError(message: String, actionButtonText: String? = nil, action: @escaping ()->() = { return; }) {
		if let actionButtonText = actionButtonText {
			alert.error(message, actionButtonText: actionButtonText) { (alertAction) in
				action();
			}
		}
		else {
			alert.info(message: message);
		}
	}
	
	// MARK: - Gesture: Dismiss Keyboard
	internal func setupTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapHandler(recognizer:)));
		tapGesture.cancelsTouchesInView = false;
		self.view.addGestureRecognizer(tapGesture);
	}
	
	@objc internal func viewTapHandler(recognizer: UISwipeGestureRecognizer) {
		self.dismissKeyboard();
	}
	
	internal func dismissKeyboard() {
		self.view.endEditing(true);
	}

	// MARK: - Check Connection Status
	//TODO: DI
	private var connectionkManager: MonitoringConnection!;

	internal func checkConnection() {
		if (connectionkManager.isUnreachable) {
			alert.info(message: ErrorType.noConnection.message);
		}
	}
	
	// MARK: - Scrolling
	
	/*
	Refer to this link for details:
		https://www.notion.so/mstdev/Implement-Scrolling-Using-My-BaseViewController-Step-by-Step-a8937942fd7a46a699a9681875cbea86
	
	Brief steps:
	- Set top view's size to Freeform
	- Add a content view (ViewContent) with no siblings, use appropriate contraints for it
	- Follow the mentioned link about its size and position
	- Reference the ViewContent in your code
	- Call the setupScrollView method, and pass the ViewContent to it
	*/
	
	var scrollView = UIScrollView();
	var viewScrolledContent = UIView();

	// Call this method only if you have scrolling in your ViewConroller, take care of the Prerequisites above
	internal  func setupScrollView(contentView: UIView){
		// Detach the content view from super view
		contentView.removeFromSuperview();
		
		/// Build control hierarchy for scrolling
		// ScrollView
		scrollView.translatesAutoresizingMaskIntoConstraints = false;
		view.addSubview(scrollView);
		scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true;
		scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true;
		scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
		scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
		
		// ViewScrolledContent
		viewScrolledContent.translatesAutoresizingMaskIntoConstraints = false;
		scrollView.addSubview(viewScrolledContent);
		viewScrolledContent.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
		viewScrolledContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
		viewScrolledContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
		viewScrolledContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
		viewScrolledContent.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
		
		// Content View
		contentView.translatesAutoresizingMaskIntoConstraints = false;
		viewScrolledContent.addSubview(contentView);
		contentView.topAnchor.constraint(equalTo: viewScrolledContent.topAnchor).isActive = true;
		contentView.bottomAnchor.constraint(equalTo: viewScrolledContent.bottomAnchor).isActive = true;
		contentView.leadingAnchor.constraint(equalTo: viewScrolledContent.leadingAnchor).isActive = true;
		contentView.trailingAnchor.constraint(equalTo: viewScrolledContent.trailingAnchor).isActive = true;
	}
	
}
