import RealityKit
import SwiftUI

class FadeSystem: System {
    private static let query = EntityQuery(where: .has(FadeComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var fade = entity.components[FadeComponent.self], var model = entity.components[ModelComponent.self] {
                fade.alpha = max(0, fade.alpha - fade.rate * dt)
                let color = UIColor(white: 1, alpha: CGFloat(fade.alpha))
                let material = SimpleMaterial(color: color, isMetallic: false)
                model.materials = [material]
                entity.components.set(model)
                if fade.alpha <= 0 {
                    entity.removeFromParent()
                } else {
                    entity.components.set(fade)
                }
            }
        }
    }
}
