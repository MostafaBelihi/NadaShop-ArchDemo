//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//
/// Source: https://medium.freecodecamp.org/how-to-handle-internet-connection-reachability-in-swift-34482301ea57

import Foundation
import Reachability

protocol MonitoringConnection {
	var reachability: Reachability! { get };
	
	func setup(reachability: Reachability);
	func networkStatusChanged(_ notification: Notification);
	func stopNotifier() -> Void;

	var isReachable: Bool { get };
	var isUnreachable: Bool { get };
	var isReachableViaWWAN: Bool { get };
	var isReachableViaWiFi: Bool { get };
}

class ConnectionManager: NSObject, MonitoringConnection {

	// MARK: - Dependencies
	var reachability: Reachability!
	
	// MARK: - Init
	override init() {
		super.init()
	}
	
	func setup(reachability: Reachability) {
		// Initialise reachability
		self.reachability = reachability;
		
		// Register an observer for the network status
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(networkStatusChanged(_:)),
			name: .reachabilityChanged,
			object: reachability
		)
		do {
			// Start the network status notifier
			try reachability.startNotifier()
		}
		catch {
			print("Unable to start notifier")
		}
	}
	
	@objc func networkStatusChanged(_ notification: Notification) {
		// Do something globally here!
	}
	
	func stopNotifier() -> Void {
		do {
			// Stop the network status notifier
			try (self.reachability).startNotifier()
		}
		catch {
			print("Error stopping notifier")
		}
	}
	
	// Network is reachable
	var isReachable: Bool {
		get {
			return (self.reachability).connection != .unavailable;
		}
	}
	
	// Network is unreachable
	var isUnreachable: Bool {
		get {
			return (self.reachability).connection == .unavailable;
		}
	}
	
	// Network is reachable via WWAN/Cellular
	var isReachableViaWWAN: Bool {
		get {
			return (self.reachability).connection == .cellular;
		}
	}

	// Network is reachable via WiFi
	var isReachableViaWiFi: Bool {
		get {
			return (self.reachability).connection == .wifi;
		}
	}
}
