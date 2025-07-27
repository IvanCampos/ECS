import RealityKit
import SwiftUI

class HitHighlightSystem: System {
    private static let query = EntityQuery(where: .has(HitHighlightComponent.self) && .has(ModelComponent.self) && .has(CollisionComponent.self))
    private var subscriptions: [EventSubscription] = []

    required init(scene: RealityKit.Scene) {
        let sub = scene.subscribe(to: CollisionEvents.Began.self) { event in
            if var comp = event.entityA.components[HitHighlightComponent.self] {
                comp.timer = comp.duration
                event.entityA.components.set(comp)
            }
            if var comp = event.entityB.components[HitHighlightComponent.self] {
                comp.timer = comp.duration
                event.entityB.components.set(comp)
            }
        }
        subscriptions.append(sub)
    }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[HitHighlightComponent.self], var model = entity.components[ModelComponent.self] {
                if comp.timer > 0 {
                    comp.timer -= dt
                    if comp.originalColor == nil, let mat = model.materials.first as? SimpleMaterial {
                        comp.originalColor = Color(mat.color.tint)
                    }
                    if let mat = model.materials.first as? SimpleMaterial {
                        var material = mat
                        material.color = .init(tint: UIColor(comp.color), texture: mat.color.texture)
                        model.materials = [material]
                        entity.components.set(model)
                    }
                } else if let orig = comp.originalColor, let mat = model.materials.first as? SimpleMaterial {
                    var material = mat
                    material.color = .init(tint: UIColor(orig), texture: mat.color.texture)
                    model.materials = [material]
                    comp.originalColor = nil
                    entity.components.set(model)
                }
                entity.components.set(comp)
            }
        }
    }
}
