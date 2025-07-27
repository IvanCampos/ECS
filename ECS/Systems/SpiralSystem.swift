import RealityKit
import simd

class SpiralSystem: System {
    private static let query = EntityQuery(where: .has(SpiralComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var spiral = entity.components[SpiralComponent.self] {
                spiral.angle += spiral.speed * dt
                entity.position.x = spiral.center.x + cos(spiral.angle) * spiral.radius
                entity.position.z = spiral.center.z + sin(spiral.angle) * spiral.radius
                entity.position.y += spiral.heightSpeed * dt
                entity.components.set(spiral)
            }
        }
    }
}
