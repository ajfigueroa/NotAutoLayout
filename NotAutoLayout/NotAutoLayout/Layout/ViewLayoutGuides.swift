//
//  ViewLayoutGuides.swift
//  NotAutoLayout
//
//  Created by 史　翔新 on 2017/09/13.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct ViewLayoutGuides {
	
	private(set) weak var parentView: UIView?
    
    init(parentView: UIView) {
        
        self.parentView = parentView
        
    }
	
}

extension ViewLayoutGuides {
	
	private func makeGuide(directionGetter: @escaping () -> UIUserInterfaceLayoutDirection?, rect: Rect?) -> Guide {
		
		guard let rect = rect else {
			return .empty
		}
		
		let guide = Guide(directionGetter: directionGetter, rect: rect)
		
		return guide
		
	}
	
}

extension ViewLayoutGuides: LayoutGuideRepresentable {
    
    public var layoutGuide: Guide {
        return self.boundsGuide
    }
    
}

extension ViewLayoutGuides {
    
    public var boundsGuide: Guide {
		return self.makeGuide(directionGetter: { [weak parentView] in parentView?.currentDirection }, rect: self.parentView?.boundsRect)
    }
    
    public var layoutMarginsGuide: Guide {
		return self.makeGuide(directionGetter: { [weak parentView] in parentView?.currentDirection }, rect: self.parentView?.layoutMarginsRect)
    }
    
    public var readableGuide: Guide {
		return self.makeGuide(directionGetter: { [weak parentView] in parentView?.currentDirection }, rect: self.parentView?.readableRect)
    }
    
    @available(iOS 11.0, *)
    public var safeAreaGuide: Guide {
		return self.makeGuide(directionGetter: { [weak parentView] in parentView?.currentDirection }, rect: self.parentView?.safeAreaRect)
    }
    
}

extension ViewLayoutGuides {
    
    public var layoutMargins: UIEdgeInsets {
        return self.parentView?.layoutMargins ?? .zero
    }
    
    @available(iOS 11.0, *)
    public var safeAreaInsets: UIEdgeInsets {
        return self.parentView?.safeAreaInsets ?? .zero
    }
    
}

extension ViewLayoutGuides {
	
	func size(for view: UIView, thatFits fittingSize: CGSize) -> CGSize {
		
		let fittedSize = view.sizeThatFits(fittingSize)
		
		return fittedSize
		
	}
	
}

extension ViewLayoutGuides {
	
	func evaluateSize(from calculation: (ViewLayoutGuides) -> CGSize) -> CGSize {
		
		return calculation(self)
		
	}
	
	func evaluateSize(for view: UIView, from aspect: LayoutElement.Size.AspectSizing) -> CGSize {
		
		let canvasSize = { (safeAreaOnly: Bool) -> CGSize in
			switch safeAreaOnly {
			case true:
				if #available(iOS 11.0, *) {
					return self.safeAreaGuide.size
				} else {
					fallthrough
				}
				
			case false:
				return self.boundsGuide.size
			}
		}(aspect.safeAreaOnly)
		
		let targetRatio = aspect.ratio ?? { (targetView: UIView?) in
			return targetView?.sizeThatFits(.zero).ratio
		}(view) ?? 1
		
		guard targetRatio.isNaN == false,
			canvasSize.ratio.isNaN == false
		else {
			return canvasSize
		}
		
		switch aspect {
		case .fit, .safeAreaFit:
			return CGSize.aspectFitSize(in: canvasSize, with: targetRatio)
			
		case .fill, .safeAreaFill:
			return CGSize.aspectFillSize(in: canvasSize, with: targetRatio)
		}
		
	}
	
}
