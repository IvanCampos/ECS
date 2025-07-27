import RealityKit
import simd

class NudgeSystem: System {
    private static let query = EntityQuery(where: .has(NudgeComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[NudgeComponent.self] {
                let offset = SIMD3<Float>(
                    Float.random(in: -comp.amplitude...comp.amplitude) * dt,
                    Float.random(in: -comp.amplitude...comp.amplitude) * dt,
                    Float.random(in: -comp.amplitude...comp.amplitude) * dt
                )
                entity.position += offset
            }
        }
    }
}
