//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//

// Credit: https://www.brightec.co.uk/blog/creating-a-zoomable-image-view-in-swift

import UIKit

class PanZoomImageView: UIScrollView {
	
	@IBInspectable
	private var imageName: String? {
		didSet {
			guard let imageName = imageName else {
				return
			}
			imageView.image = UIImage(named: imageName)
		}
	}
	
	var imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	convenience init(named: String) {
		self.init(frame: .zero)
		self.imageName = named
	}
	
	private func commonInit() {
		// Setup image view
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		addSubview(imageView)
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalTo: widthAnchor),
			imageView.heightAnchor.constraint(equalTo: heightAnchor),
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
		
		// Setup scroll view
		minimumZoomScale = 1
		maximumZoomScale = 3
		showsHorizontalScrollIndicator = false
		showsVerticalScrollIndicator = false
		delegate = self

		// Setup tap gesture
		let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
		doubleTapRecognizer.numberOfTapsRequired = 2
		addGestureRecognizer(doubleTapRecognizer)
	}

	@objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
		if zoomScale == 1 {
			setZoomScale(3, animated: true)
		} else {
			setZoomScale(1, animated: true)
		}
	}
	
}

extension PanZoomImageView: UIScrollViewDelegate {
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
}
