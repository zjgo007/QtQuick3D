import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15

Window {
    width: 480
    height: 450
    visible: true
    title: qsTr("Hello Qt Quick 3D")
    color: "#00192e"

    Image{
        opacity: 0.3
        anchors.fill: parent
        source: "qrc:/bg1.png"
        fillMode: Image.PreserveAspectCrop
    }

    View3D {
        id: view3D
        anchors.fill: parent
        environment: SceneEnvironment {
            id: sceneEnvironment
            //需要设置3D视图背景透明
            backgroundMode: SceneEnvironment.Transparent
            clearColor: "transparent"
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }


        MouseArea{
            id:mouse
            anchors.fill: parent
            property int cx: 0
            property int cy: 0
            onWheel: {
                if(wheel.angleDelta.y>0)
                    cameraPerspective.z = cameraPerspective.z+5
                else
                    cameraPerspective.z = cameraPerspective.z-5
            }
            onPressed: {
                camerAnimation.pause()
                cx = mouse.x
                cy = mouse.y
            }
            onReleased: {
                camerAnimation.resume()
            }
            onPositionChanged: {
                var intervalX = mouse.x-cx
                var intervalY = mouse.y-cy
                cameraNode.eulerRotation.y = intervalX+cameraNode.eulerRotation.y
                cameraNode.eulerRotation.x = cameraNode.eulerRotation.x-intervalY
                cx = mouse.x
                cy = mouse.y

            }
        }

        Node {
            id: scene

            DirectionalLight {
                x: 56
                eulerRotation.y: 90

                ambientColor: "#1c1a17"
                brightness: 163
            }
            Node {
                id: rootNode
                scale:Qt.vector3d(0.1,0.1,0.1)
                Node {
                    x: 12.4775
                    y: 36.2141
                    z: 10.5153
                    eulerRotation.x: 180
                    eulerRotation.y: 32.0597
                    eulerRotation.z: -180

                    Model {
                        x: 121.16
                        y: -17.21
                        z: 86.29
                        eulerRotation.x: 180
                        eulerRotation.y: -32.0597
                        eulerRotation.z: -180
                        source: "meshes/Plane.mesh"

                        materials: PrincipledMaterial {
                            baseColor: "#a0a2a3"
                            roughness: 0.6
                            metalness: 0.5

                        }
                    }
                }


                PointLight {
                    x: 80.1709
                    y: 382.888
                    z: -150.021
                    eulerRotation.x: -69.997
                    eulerRotation.y: 59.9021
                    eulerRotation.z: -180
                    color: "#fffff5e1"
                }

                PointLight {
                    x: -305.432
                    y: 199.762
                    z: 163.037
                    eulerRotation.x: 173
                    eulerRotation.y: -59.9035
                    color: "#ffecf9ff"
                }

                PointLight {
                    x: 238.189
                    y: 380.379
                    z: 252.482
                    eulerRotation.x: 138.592
                    eulerRotation.y: 36.109
                    color: "#ff3b5966"
                }
            }

            Node{
                id:cameraNode
                eulerRotation.x: -20
                eulerRotation.y: 120
                PerspectiveCamera {
                    id: cameraPerspective
                    y: 5
                    clipNear: 0.1
                    fieldOfView: 50
                    z:90
                    clipFar: 800
                }
                NumberAnimation {
                    id:camerAnimation
                    target: cameraNode
                    property: "eulerRotation.y"
                    duration: 5000
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    running: true
                }
            }



        }

        Text {
            text: qsTr("鼠标左键：旋转；鼠标滚轮：缩放")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pointSize: 12
            font.bold: true
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            font.family: "微软雅黑"
            color:"ghostwhite"
        }
    }
}
