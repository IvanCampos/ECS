import RealityKit
import simd

class SpinColorSystem: System {
    private static let query = EntityQuery(where: .has(SpinColorComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[SpinColorComponent.self], var model = entity.components[ModelComponent.self] {
                comp.phase += comp.colorSpeed * dt
                let q = simd_quatf(angle: comp.spinSpeed * dt, axis: [0, 1, 0])
                entity.orientation = simd_normalize(q * entity.orientation)
                if let material = model.materials.first as? SimpleMaterial {
                    var mat = material
                    let t = (sin(comp.phase) + 1) / 2
                    mat.color = .init(tint: .init(red: CGFloat(t), green: 0, blue: CGFloat(1 - t), alpha: 1), texture: material.color.texture)
                    model.materials = [mat]
                }
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
