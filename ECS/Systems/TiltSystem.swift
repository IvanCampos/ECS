import RealityKit
import simd

class TiltSystem: System {
    private static let query = EntityQuery(where: .has(TiltComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var tilt = entity.components[TiltComponent.self] {
                tilt.phase += tilt.speed * dt
                let angle = sin(tilt.phase) * tilt.amplitude
                entity.orientation = simd_quatf(angle: angle, axis: tilt.axis)
                entity.components.set(tilt)
            }
        }
    }
}
