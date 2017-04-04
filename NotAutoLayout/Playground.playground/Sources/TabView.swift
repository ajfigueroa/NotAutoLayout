import Foundation
import NotAutoLayout

public class TabView: UIScrollView, LayoutControllable {
	
	public var layoutInfo: [LayoutControllable.Hash: [LayoutMethod]] = [:]
	public var orderInfo: [LayoutControllable.Hash : Int] = [:]
	public var zIndexInfo: [LayoutControllable.Hash: Int] = [:]
	
	fileprivate let tabItemSize = CGSize(width: 48, height: 48)
	fileprivate let tabItemHorizontalMargin: CGFloat = 8
	
	public var layoutOptimization: LayoutOptimization = .sequence
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		self.layoutControl()
	}
	
}

extension TabView {
	
	public func makeTabItemLayoutMethods() -> [LayoutMethod] {
		
		let position = LayoutPosition
			.makeAbsolute(initialFrame: CGRect(origin: CGPoint(x: self.tabItemHorizontalMargin,
			                                                   y: self.tabItemHorizontalMargin),
			                                   size: self.tabItemSize),
			              margin: self.tabItemHorizontalMargin,
			              direction: .horizontal)
		
		let method = LayoutMethod(constantPosition: position)
		
		return [method]
		
	}
	
}

extension TabView {
	
	public func updateContentSize() {
		
		let height = self.bounds.height
		let width = self.subviews.reduce(0) { (width, view) -> CGFloat in
			let viewRightPosition = view.frame.origin.x + view.frame.width
			return max(width, viewRightPosition)
		} + self.tabItemHorizontalMargin
		
		self.contentSize = CGSize(width: width, height: height)
		
	}
	
}