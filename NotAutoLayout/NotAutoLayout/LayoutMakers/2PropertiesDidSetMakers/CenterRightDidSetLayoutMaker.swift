//
//  CenterRightDidSetLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct CenterRightDidSetLayoutMaker {
	
	public unowned let parentView: UIView
	
	let center: LayoutElement.Float
	
	let right: LayoutElement.Float
	
}

// MARK: - Set A Line -
// MARK: Top
extension CenterRightDidSetLayoutMaker: LayoutMakerCanSetTopType {
	
	public typealias WillSetTopMaker = CenterRightTopDidSetLayoutMaker
	
	public func setTop(_ top: LayoutElement.Float) -> CenterRightTopDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 right: self.right,
					 top: top)
		
	}
	
}

// MARK: Middle
extension CenterRightDidSetLayoutMaker: LayoutMakerCanSetMiddleType {
	
	public typealias WillSetMiddleMaker = CenterRightMiddleDidSetLayoutMaker
	
	public func setMiddle(_ middle: LayoutElement.Float) -> CenterRightMiddleDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 right: self.right,
					 middle: middle)
		
	}
	
}

// MARK: Bottom
extension CenterRightDidSetLayoutMaker: LayoutMakerCanSetBottomType {
	
	public typealias WillSetBottomMaker = CenterRightBottomDidSetLayoutMaker
	
	public func setBottom(_ bottom: LayoutElement.Float) -> CenterRightBottomDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 right: self.right,
					 bottom: bottom)
		
	}
	
}
