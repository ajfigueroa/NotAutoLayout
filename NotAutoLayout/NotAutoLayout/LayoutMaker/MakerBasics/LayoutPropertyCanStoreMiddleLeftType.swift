//
//  LayoutPropertyCanStoreMiddleLeftType.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/11/12.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public protocol LayoutPropertyCanStoreMiddleLeftType: LayoutMakerPropertyType {
	
	associatedtype WillSetMiddleLeftProperty: LayoutMakerPropertyType
	
	func storeMiddleLeft <ParentView> (_ middleLeft: LayoutElement.Point, to maker: LayoutMaker<ParentView, Self>) -> LayoutMaker<ParentView, WillSetMiddleLeftProperty>
	
}

extension LayoutMaker where Property: LayoutPropertyCanStoreMiddleLeftType {
	
	public func setMiddleLeft(to middleLeft: CGPoint) -> LayoutMaker<ParentView, Property.WillSetMiddleLeftProperty> {
		
		let middleLeft = LayoutElement.Point.constant(middleLeft)
		let maker = self.didSetProperty.storeMiddleLeft(middleLeft, to: self)
		
		return maker
		
	}
	
	public func setMiddleLeft(by middleLeft: @escaping (_ property: ViewFrameProperty) -> CGPoint) -> LayoutMaker<ParentView, Property.WillSetMiddleLeftProperty> {
		
		let middleLeft = LayoutElement.Point.byParent(middleLeft)
		let maker = self.didSetProperty.storeMiddleLeft(middleLeft, to: self)
		
		return maker
		
	}
	
	public func pinMiddleLeft(to referenceView: UIView?, with middleLeft: @escaping (ViewPinProperty<ViewPinPropertyType.Point>) -> CGPoint) -> LayoutMaker<ParentView, Property.WillSetMiddleLeftProperty> {
		
		return self.pinMiddleLeft(by: { [weak referenceView] in referenceView }, with: middleLeft)
		
	}
	
	public func pinMiddleLeft(by referenceView: @escaping () -> UIView?, with middleLeft: @escaping (ViewPinProperty<ViewPinPropertyType.Point>) -> CGPoint) -> LayoutMaker<ParentView, Property.WillSetMiddleLeftProperty> {
		
		let middleLeft = LayoutElement.Point.byReference(referenceGetter: referenceView, middleLeft)
		let maker = self.didSetProperty.storeMiddleLeft(middleLeft, to: self)
		
		return maker
		
	}
	
}

public protocol LayoutPropertyCanStoreMiddleLeftToEvaluateFrameType: LayoutPropertyCanStoreMiddleLeftType {
	
	func evaluateFrame(middleLeft: LayoutElement.Point, parameters: IndividualFrameCalculationParameters) -> CGRect
	
}

extension LayoutPropertyCanStoreMiddleLeftToEvaluateFrameType {
	
	public func storeMiddleLeft <ParentView> (_ middleLeft: LayoutElement.Point, to maker: LayoutMaker<ParentView, Self>) -> LayoutMaker<ParentView, IndividualLayout> {
		
		let layout = IndividualLayout(frame: { (parameters) -> CGRect in
			return self.evaluateFrame(middleLeft: middleLeft, parameters: parameters)
		})
		let maker = LayoutMaker(parentView: maker.parentView, didSetProperty: layout)
		
		return maker
		
	}
	
}