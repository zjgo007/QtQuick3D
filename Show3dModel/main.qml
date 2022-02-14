import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: node
            DirectionalLight {
                id: directionalLight
            }

            PerspectiveCamera {
                id: camera
                z: 15
            }

            Model {
                id: cubeModel
                source: "test.mesh"
                DefaultMaterial {
                    id: cubeMaterial
                    diffuseColor: "#4aee45"
                }
                materials: cubeMaterial
            }
        }
    }
}
