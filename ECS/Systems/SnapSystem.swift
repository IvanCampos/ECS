import RealityKit
import simd

class SnapSystem: System {
    private static let query = EntityQuery(where: .has(SnapComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let snap = entity.components[SnapComponent.self] {
                let pos = entity.position / snap.gridSize
                entity.position = pos.rounded(.awayFromZero) * snap.gridSize
            }
        }
    }
}
