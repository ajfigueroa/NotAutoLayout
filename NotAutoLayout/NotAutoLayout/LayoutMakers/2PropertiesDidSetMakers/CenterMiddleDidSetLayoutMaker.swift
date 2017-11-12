//
//  CenterMiddleDidSetLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct CenterMiddleDidSetLayoutMaker {
	
	public unowned let parentView: UIView
	
	let center: LayoutElement.Float
	
	let middle: LayoutElement.Float
	
}

// MARK: - Make Frame
extension CenterMiddleDidSetLayoutMaker {
	
	private func makeFrame(center: CGFloat, middle: CGFloat, size: CGSize) -> CGRect {
		
		let left = center - size.width.half
		let top = middle - size.height.half
		let origin = CGPoint(x: left, y: top)
		let size = size
		let frame = CGRect(origin: origin, size: size)
		
		return frame
		
	}
	
}

// MARK: - Set A Size -
// MARK: Size
extension CenterMiddleDidSetLayoutMaker {
	
	public func setSize(to size: CGSize) -> LayoutEditor {
		
		return self.setSize(by: { _ in size })
		
	}
	
	public func setSize(by size: @escaping (_ parameter: LayoutControlParameter) -> CGSize) -> LayoutEditor {
		
		let layout = Layout(frame: { (parameter) -> CGRect in
			
			let center = self.center.evaluated(from: parameter)
			let middle = self.middle.evaluated(from: parameter)
			let size = size(parameter)
			let frame = self.makeFrame(center: center, middle: middle, size: size)
			
			return frame
			
		})
		
		let editor = LayoutEditor(layout)
		
		return editor
		
	}
	
	public func fitSize(by fittingSize: CGSize = .zero) -> LayoutEditor {
		
		let layout = Layout(frame: { (fitting, parameter) -> CGRect in
			
			let center = self.center.evaluated(from: parameter)
			let middle = self.middle.evaluated(from: parameter)
			let size = fitting(fittingSize)
			let frame = self.makeFrame(center: center, middle: middle, size: size)
			
			return frame
			
		})
		
		let editor = LayoutEditor(layout)
		
		return editor
		
	}
	
}

// MARK: - Set A Line -
// MARK: Bottom
extension CenterMiddleDidSetLayoutMaker: LayoutMakerCanSetBottomType {
	
	public typealias WillSetBottomMaker = CenterMiddleBottomDidSetLayoutMaker
	
	public func setBottom(_ bottom: LayoutElement.Float) -> CenterMiddleBottomDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 middle: self.middle,
					 bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension CenterMiddleDidSetLayoutMaker {
	
	public func setWidth(to width: CGFloat) -> CenterMiddleWidthDidSetLayoutMaker {
		
		let width = LayoutElement.Float.constant(width)
		
		let maker = CenterMiddleWidthDidSetLayoutMaker(parentView: self.parentView,
		                                               center: self.center,
		                                               middle: self.middle,
		                                               width: width)
		return maker
		
	}
	
	public func setWidth(by width: @escaping (_ parameter: LayoutControlParameter) -> CGFloat) -> CenterMiddleWidthDidSetLayoutMaker {
		
		let width = LayoutElement.Float.closure(width)
		
		let maker = CenterMiddleWidthDidSetLayoutMaker(parentView: self.parentView,
		                                               center: self.center,
		                                               middle: self.middle,
		                                               width: width)
		
		return maker
		
	}
	
}

// MARK: Height
extension CenterMiddleDidSetLayoutMaker {
	
	public func setHeight(to height: CGFloat) -> CenterMiddleHeightDidSetLayoutMaker {
		
		let height = LayoutElement.Float.constant(height)
		
		let maker = CenterMiddleHeightDidSetLayoutMaker(parentView: self.parentView,
		                                                center: self.center,
		                                                middle: self.middle,
		                                                height: height)
		return maker
		
	}
	
	public func setHeight(by height: @escaping (_ parameter: LayoutControlParameter) -> CGFloat) -> CenterMiddleHeightDidSetLayoutMaker {
		
		let height = LayoutElement.Float.closure(height)
		
		let maker = CenterMiddleHeightDidSetLayoutMaker(parentView: self.parentView,
		                                                center: self.center,
		                                                middle: self.middle,
		                                                height: height)
		
		return maker
		
	}
	
}
