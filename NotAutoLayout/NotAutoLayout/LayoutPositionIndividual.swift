//
//  LayoutPositionIndividual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/03/18.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension LayoutPosition.Individual {
	
	fileprivate func getPosition(of frame: LayoutFrame, in boundSize: CGSize, _ method: PositioningMethod) -> Position {
		
		let frame = method.absoluteFrame(frame, by: boundSize)
		let position = frame.position(in: boundSize)
		return position
		
	}
	
	fileprivate func getPosition(of frame: CGRect, in boundSize: CGSize, _ method: PositioningMethod) -> Position {
		
		let frame = method.absoluteFrame(frame, by: boundSize)
		let position = frame.position(in: boundSize)
		return position
		
	}
	
}

extension LayoutPosition.Individual {
	
	fileprivate func getPosition(by insets: UIEdgeInsets, in boundSize: CGSize) -> Position {
		
		let x = insets.left
		let y = insets.top
		let width = boundSize.width - (insets.left + insets.right)
		let height = boundSize.height - (insets.top + insets.bottom)
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return Position(frame: frame)
		
	}
	
}

extension LayoutPosition.Individual {
	
	fileprivate func getPosition(of transform: SizeToFrame, in boundSize: CGSize) -> Position {
		
		let frame = transform(boundSize)
		let position = frame.position(in: boundSize)
		
		return position
		
	}
	
	fileprivate func getPosition(of originTransform: SizeToPoint, _ sizeTransform: SizeToSize, in boundSize: CGSize) -> Position {
		
		let origin = originTransform(boundSize)
		let size = sizeTransform(boundSize)
		let frame = CGRect(origin: origin, size: size)
		let position = Position(frame: frame)
		
		return position
		
	}
	
	fileprivate func getPosition(of xTransform: SizeToFloat, _ yTransform: SizeToFloat, _ widthTransform: SizeToFloat, _ heightTransform: SizeToFloat, in boundSize: CGSize) -> Position {
		
		let x = xTransform(boundSize)
		let y = yTransform(boundSize)
		let width = widthTransform(boundSize)
		let height = heightTransform(boundSize)
		let frame = CGRect(x: x, y: y, width: width, height: height)
		let position = Position(frame: frame)
		
		return position
		
	}
	
	fileprivate func getPosition(of transform: FitSizeBoundSizeToFrame, for view: UIView, thatFits fittingSize: CGSize, in boundSize: CGSize) -> Position {
		
		let fitSize = view.sizeThatFits(fittingSize)
		let frame = transform(fitSize, boundSize)
		let position = frame.position(in: boundSize)
		
		return position
		
	}
	
}

extension LayoutPosition.Individual {
	
	func absolutePosition(of view: UIView, in boundSize: CGSize) -> Position {
		
		switch self {
		case .absolute(let frame):
			return self.getPosition(of: frame, in: boundSize, .absolutely)
			
		case .relative(let frame):
			return self.getPosition(of: frame, in: boundSize, .relatively)
			
		case .insets(let insets):
			return self.getPosition(by: insets, in: boundSize)
			
		case .customByFrame(frame: let frameTransform):
			return self.getPosition(of: frameTransform, in: boundSize)
			
		case .customByOriginSize(origin: let originTransform, size: let sizeTransform):
			return self.getPosition(of: originTransform, sizeTransform, in: boundSize)
			
		case .customByXYWidthHeight(x: let xTransform, y: let yTransform, width: let widthTransform, height: let heightTransform):
			return self.getPosition(of: xTransform, yTransform, widthTransform, heightTransform, in: boundSize)
			
		case .customFitsSizeByFrame(fittingSize: let fittingSize, frame: let frame):
			return self.getPosition(of: frame, for: view, thatFits: fittingSize, in: boundSize)
			
		}
		
	}
	
}
