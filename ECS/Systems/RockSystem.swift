import RealityKit
import simd

class RockSystem: System {
    private static let query = EntityQuery(where: .has(RockComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var rock = entity.components[RockComponent.self] {
                rock.phase += rock.speed * dt
                let angle = sin(rock.phase) * rock.amplitude
                let q = simd_quatf(angle: angle, axis: [1, 0, 0])
                entity.orientation = simd_normalize(q * entity.orientation)
                entity.components.set(rock)
            }
        }
    }
}
