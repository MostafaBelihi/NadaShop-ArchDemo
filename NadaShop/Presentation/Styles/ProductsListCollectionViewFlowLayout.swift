//
//  TopAlignedCollectionViewFlowLayout.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 09/05/2021.
//

import UIKit

class ProductsListCollectionViewFlowLayout: UICollectionViewFlowLayout {
	// Custom layout to align cells to top from: https://stackoverflow.com/a/51389412/7128177
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let attributes = super.layoutAttributesForElements(in: rect)?
			.map { $0.copy() } as? [UICollectionViewLayoutAttributes]
		
		attributes?
			.reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
				guard $1.representedElementCategory == .cell else { return $0 }
				
				return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
					($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
				}
			}
			.values.forEach { minY, line in
				line.forEach {
					$0.frame = $0.frame.offsetBy(
						dx: 0,
						dy: minY - $0.frame.origin.y
					)
				}
			}
		
		return attributes
	}
}
