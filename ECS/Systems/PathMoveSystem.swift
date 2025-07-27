import RealityKit
import simd

class PathMoveSystem: System {
    private static let query = EntityQuery(where: .has(PathMoveComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var path = entity.components[PathMoveComponent.self] {
                let dir: Float = path.forward ? 1 : -1
                path.progress += path.speed * dt * dir
                if path.progress >= 1 {
                    path.progress = 1
                    path.forward = false
                } else if path.progress <= 0 {
                    path.progress = 0
                    path.forward = true
                }
                entity.position = simd_mix(path.start, path.end, SIMD3<Float>(repeating: path.progress))
                entity.components.set(path)
            }
        }
    }
}
