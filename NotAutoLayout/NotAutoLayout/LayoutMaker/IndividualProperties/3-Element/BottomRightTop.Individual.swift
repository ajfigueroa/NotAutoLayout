//
//  BottomRightTop.Individual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension IndividualProperty {
	
	public struct BottomRightTop {
		
		let bottomRight: LayoutElement.Point
		
		let top: LayoutElement.Vertical
		
	}
	
}

// MARK: - Make Frame
extension IndividualProperty.BottomRightTop {
	
	private func makeFrame(bottomRight: Point, top: Float, width: Float) -> Rect {
		
		let x = bottomRight.x - width
		let y = top
		let height = bottomRight.y - top
		let frame = Rect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension IndividualProperty.BottomRightTop: LayoutPropertyCanStoreWidthToEvaluateFrameType {
	
	public func evaluateFrame(width: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> Rect {
		
		let bottomRight = self.bottomRight.evaluated(from: parameters)
		let top = self.top.evaluated(from: parameters)
		let height = bottomRight.y - top
		let width = width.evaluated(from: parameters, withTheOtherAxis: .height(height))
		
		return self.makeFrame(bottomRight: bottomRight, top: top, width: width)
		
	}
	
}
