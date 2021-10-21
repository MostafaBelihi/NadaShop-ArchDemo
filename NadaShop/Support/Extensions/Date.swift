//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation

extension Date {
	/// Get Date Components
	func getComponents() -> DateComponents {
		let calendar = Calendar.current;
		return calendar.dateComponents([.day, .month, .year, .hour, .minute, .second, .timeZone, .weekday], from: self);
	}
	
	/// Gets Date from DateComponents
	static func get(from components: DateComponents) -> Date? {
		let calendar = Calendar.current;
		return calendar.date(from: components);
	}
	
	/// Change date value
	func alter(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
		var dateComponent = DateComponents();
		
		dateComponent.second = seconds;
		dateComponent.minute = minutes;
		dateComponent.hour = hours;
		dateComponent.day = days;
		dateComponent.month = months;
		dateComponent.year = years;
		
		return Calendar.current.date(byAdding: dateComponent, to: self)!;
	}
}
