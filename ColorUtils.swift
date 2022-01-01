import Foundation
import SwiftUI

func interpolate(color1: Color, color2: Color, fraction: Double) -> Color {
    if (fraction <= 0) {
        return color1
    }
    if (fraction >= 1) {
        return color2
    }
    
    var r1: CGFloat = 0
    var g1: CGFloat = 0
    var b1: CGFloat = 0
    var a1: CGFloat = 0
    var r2: CGFloat = 0
    var g2: CGFloat = 0
    var b2: CGFloat = 0
    var a2: CGFloat = 0
    
    if (!UIColor(color1).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)) {
        return .purple
    }
    if (!UIColor(color2).getRed(&r2, green: &g2, blue: &b2, alpha: &a2)) {
        return .purple
    }
    
    let a: Double = a1 + fraction * (a2 - a1)
    let r: Double = r1 + fraction * (r2 - r1)
    let g: Double = g1 + fraction * (g2 - g1)
    let b: Double = b1 + fraction * (b2 - b1)
    
    return Color(.sRGBLinear, red: r, green: g, blue: b, opacity: a)
}
