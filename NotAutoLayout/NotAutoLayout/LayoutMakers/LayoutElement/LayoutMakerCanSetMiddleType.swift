//
//  LayoutMakerCanSetMiddleType.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/11/12.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public protocol LayoutMakerCanSetMiddleType: LayoutMakerType {
	
	associatedtype WillSetMiddleMaker
	
	func setMiddle(_ middle: LayoutElement.Float) -> WillSetMiddleMaker
	
}

extension LayoutMakerCanSetMiddleType {
	
	public func setMiddle(to middle: CGFloat) -> WillSetMiddleMaker {
		
		let middle = LayoutElement.Float.constant(middle)
		
		let maker = self.setMiddle(middle)
		
		return maker
		
	}
	
	public func setMiddle(by middle: @escaping (_ parameter: LayoutControlParameter) -> CGFloat) -> WillSetMiddleMaker {
		
		let middle = LayoutElement.Float.closure(middle)
		
		let maker = self.setMiddle(middle)
		
		return maker
		
	}
	
	public func pinMiddle(to referenceView: UIView?, s reference: CGRect.HorizontalBaseLine, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false) -> WillSetMiddleMaker {
		
		let referenceView = { [weak referenceView] in referenceView }
		
		return self.pinMiddle(by: referenceView, s: reference, offsetBy: offset, ignoresTransform: ignoresTransform)
		
	}
	
	@available(iOS 11.0, *)
	public func pinMiddle(to referenceView: UIView?, s reference: CGRect.HorizontalBaseLine, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false, safeAreaOnly shouldOnlyIncludeSafeArea: Bool) -> WillSetMiddleMaker {
		
		let referenceView = { [weak referenceView] in referenceView }
		
		return self.pinMiddle(by: referenceView, s: reference, offsetBy: offset, ignoresTransform: ignoresTransform)
		
	}
	
	public func pinMiddle(by referenceView: @escaping () -> UIView?, s reference: CGRect.HorizontalBaseLine, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false) -> WillSetMiddleMaker {
		
		let middle = self.parentView.horizontalReference(reference, of: referenceView, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: false)
		
		let maker = self.setMiddle(middle)
		
		return maker
		
	}
	
	@available(iOS 11.0, *)
	public func pinMiddle(by referenceView: @escaping () -> UIView?, s reference: CGRect.HorizontalBaseLine, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false, safeAreaOnly shouldOnlyIncludeSafeArea: Bool) -> WillSetMiddleMaker {
		
		let middle = self.parentView.horizontalReference(reference, of: referenceView, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: shouldOnlyIncludeSafeArea)
		
		let maker = self.setMiddle(middle)
		
		return maker
		
	}
	
}

public protocol LayoutMakerCanSetMiddleToMakeLayoutEditorType: LayoutMakerCanSetMiddleType where WillSetMiddleMaker == LayoutEditor {
	
	func makeFrame(middle: LayoutElement.Float, evaluatedFrom parameter: LayoutControlParameter) -> CGRect
	
}

extension LayoutMakerCanSetMiddleToMakeLayoutEditorType {
	
	public func setMiddle(_ middle: LayoutElement.Float) -> WillSetMiddleMaker {
		
		let layout = Layout(frame: { (parameter) -> CGRect in
			return self.makeFrame(middle: middle, evaluatedFrom: parameter)
		})
		
		let editor = LayoutEditor(layout)
		
		return editor
		
	}
	
}
