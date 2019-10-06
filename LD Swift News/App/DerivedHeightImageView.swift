//
//  DerivedHeightImageView.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 06/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

public class DerivedHeightImageView: UIImageView {

    public override var intrinsicContentSize: CGSize {
        previousLayoutWidth = bounds.width

        guard let image = self.image else {
            return super.intrinsicContentSize
        }

        return CGSize(
            width: bounds.width,
            height: bounds.width / image.size.aspectRatio
        )
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if previousLayoutWidth != bounds.width {
            invalidateIntrinsicContentSize()
        }
    }

    // Track the width that the intrinsic size was computed for,
    // to invalidate the intrinsic size when needed
    private var previousLayoutWidth: CGFloat = 0
}

extension CGSize {
    public var aspectRatio: CGFloat {
        return width / height
    }
}
