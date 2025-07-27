import RealityKit
import simd

class ShakeRotationSystem: System {
    private static let query = EntityQuery(where: .has(ShakeRotationComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[ShakeRotationComponent.self] {
                comp.phase += comp.speed * dt
                let angleX = sin(comp.phase) * comp.amplitude
                let angleY = cos(comp.phase) * comp.amplitude
                let rotX = simd_quatf(angle: angleX, axis: [1, 0, 0])
                let rotY = simd_quatf(angle: angleY, axis: [0, 1, 0])
                entity.orientation = simd_normalize(rotX * rotY)
                entity.components.set(comp)
            }
        }
    }
}
