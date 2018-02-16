//
//  LayoutPropertyCanStoreRightType.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/11/12.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public protocol LayoutPropertyCanStoreRightType: LayoutMakerPropertyType {
	
	associatedtype WillSetRightProperty: LayoutMakerPropertyType
	
	func storeRight <ParentView> (_ right: LayoutElement.Horizontal, to maker: LayoutMaker<ParentView, Self>) -> LayoutMaker<ParentView, WillSetRightProperty>
	
}

extension LayoutMaker where Property: LayoutPropertyCanStoreRightType {
	
	public func setRight(to right: CGFloat) -> LayoutMaker<ParentView, Property.WillSetRightProperty> {
		
		let right = LayoutElement.Horizontal.constant(right)
		let maker = self.didSetProperty.storeRight(right, to: self)
		
		return maker
		
	}
	
	public func setRight(by right: @escaping (_ property: ViewFrameProperty) -> CGFloat) -> LayoutMaker<ParentView, Property.WillSetRightProperty> {
		
		let right = LayoutElement.Horizontal.byParent(right)
		let maker = self.didSetProperty.storeRight(right, to: self)
		
		return maker
		
	}
	
	public func pinRight(to referenceView: UIView?, with right: @escaping (ViewPinProperty<ViewPinPropertyType.Horizontal>) -> CGFloat) -> LayoutMaker<ParentView, Property.WillSetRightProperty> {
		
		return self.pinRight(by: { [weak referenceView] in referenceView }, with: right)
		
	}
	
	public func pinRight(by referenceView: @escaping () -> UIView?, with right: @escaping (ViewPinProperty<ViewPinPropertyType.Horizontal>) -> CGFloat) -> LayoutMaker<ParentView, Property.WillSetRightProperty> {
		
		let right = LayoutElement.Horizontal.byReference(referenceGetter: referenceView, right)
		let maker = self.didSetProperty.storeRight(right, to: self)
		
		return maker
		
	}
	
}

public protocol LayoutPropertyCanStoreRightToEvaluateFrameType: LayoutPropertyCanStoreRightType {
	
	func evaluateFrame(right: LayoutElement.Horizontal, parameters: IndividualFrameCalculationParameters) -> CGRect
	
}

extension LayoutPropertyCanStoreRightToEvaluateFrameType {
	
	public func storeRight <ParentView> (_ right: LayoutElement.Horizontal, to maker: LayoutMaker<ParentView, Self>) -> LayoutMaker<ParentView, IndividualLayout> {
		
		let layout = IndividualLayout(frame: { (parameters) -> CGRect in
			return self.evaluateFrame(right: right, parameters: parameters)
		})
		let maker = LayoutMaker(parentView: maker.parentView, didSetProperty: layout)
		
		return maker
		
	}
	
}