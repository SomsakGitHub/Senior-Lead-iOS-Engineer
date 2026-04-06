import SwiftUI
/// ViewModifier ที่ใช้ GeometryReader เพื่อกำหนดขนาด View เป็นเปอร์เซ็นต์ของ Parent Container
struct PercentFrameLayout: Layout {
    let widthPercent: CGFloat?
    let heightPercent: CGFloat?
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        
        guard let subview = subviews.first else { return .zero }
        
        // ขนาดของ parent ที่ถูกเสนอโดย container
        let parentWidth = proposal.width ?? 0
        let parentHeight = proposal.height ?? 0
        
        // คำนวณตามเปอร์เซ็นต์
        let width = widthPercent.map { parentWidth * ($0 / 100) }
        let height = heightPercent.map { parentHeight * ($0 / 100) }
        
        // ให้ subview คำนวณขนาดตัวเองใน frame ใหญ่ที่เรากำหนด
        return CGSize(
            width: width ?? subview.sizeThatFits(proposal).width,
            height: height ?? subview.sizeThatFits(proposal).height
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard let subview = subviews.first else { return }

        // จัดตรงกลาง
        subview.place(
            at: CGPoint(x: bounds.midX, y: bounds.midY),
            anchor: .center,
            proposal: proposal
        )
    }
}


/// ส่วนขยาย (Extension) สำหรับ View เพื่อให้เรียกใช้งานได้ง่ายขึ้น
extension View {
    func percentFrame(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        PercentFrameLayout(widthPercent: width, heightPercent: height) {
            self
        }
    }
}
