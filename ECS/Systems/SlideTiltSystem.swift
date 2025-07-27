import RealityKit
import simd

class SlideTiltSystem: System {
    private static let query = EntityQuery(where: .has(SlideTiltComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[SlideTiltComponent.self] {
                let dir: Float = comp.forward ? 1 : -1
                comp.position += comp.speed * dt * dir
                if comp.position >= comp.length {
                    comp.position = comp.length
                    comp.forward = false
                } else if comp.position <= 0 {
                    comp.position = 0
                    comp.forward = true
                }
                entity.position += comp.axis * comp.speed * dt * dir
                let angle = (comp.position / comp.length) * comp.tiltAmplitude
                let q = simd_quatf(angle: angle, axis: [0, 0, 1])
                entity.orientation = simd_normalize(q)
                entity.components.set(comp)
            }
        }
    }
}
