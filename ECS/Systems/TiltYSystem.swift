import RealityKit
import simd

class TiltYSystem: System {
    private static let query = EntityQuery(where: .has(TiltYComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var tilt = entity.components[TiltYComponent.self] {
                tilt.phase += tilt.speed * dt
                let angle = sin(tilt.phase) * tilt.amplitude
                entity.orientation = simd_quatf(angle: angle, axis: [0, 1, 0])
                entity.components.set(tilt)
            }
        }
    }
}
