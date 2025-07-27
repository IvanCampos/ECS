import RealityKit
import simd

class SpinScaleSystem: System {
    private static let query = EntityQuery(where: .has(SpinScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[SpinScaleComponent.self] {
                let q = simd_quatf(angle: comp.spinSpeed * dt, axis: normalize(comp.axis))
                entity.orientation = simd_normalize(q * entity.orientation)
                entity.scale *= SIMD3<Float>(repeating: 1 + comp.scaleRate * dt)
            }
        }
    }
}
