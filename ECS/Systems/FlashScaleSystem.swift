import RealityKit
import simd

class FlashScaleSystem: System {
    private static let query = EntityQuery(where: .has(FlashScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var flash = entity.components[FlashScaleComponent.self] {
                flash.timer += dt
                if flash.timer >= flash.interval {
                    flash.timer = 0
                    flash.small.toggle()
                }
                let scale: Float = flash.small ? 0.5 : 1.0
                entity.scale = SIMD3<Float>(repeating: scale)
                entity.components.set(flash)
            }
        }
    }
}
