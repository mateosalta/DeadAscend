import QtQuick 2.0
// qmlimportscanner bug on iOS
import QtQuick.Controls 2.0

import Qak 1.0
import QtFirebase 1.0

import "qml"

ApplicationWindow {
    id: application
    title: qsTr('Dead Ascend (%1x%2)').arg(width).arg(height)

    visible: false
    visibility: "FullScreen"
    width: 1100/1.2
    height: 660/1.2

    color: "black"

    Store {
        id: store
        name: "window"
        property alias px: application.x
        property alias py: application.y
        property alias w: application.width
        property alias h: application.height
      //  property alias screenMode: application.screenMode
    }

    Component.onDestruction: store.save()

    Component.onCompleted: {
        store.load()
       // application.screenMode = 'full'

        if(App.dbg) {
            application.visible = true
            launcher.visible = true
            back.opacity = 0
        } else {
            if(Qak.platform.isDesktop) {
                application.visible = true
                back.opacity = 1
            } else
                startTimer.start()
        }
    }

    Loader {
        id: launcher
        visible: false
        anchors { fill: parent }
        sourceComponent: coreComponent
        focus: true
    }

    Component {
        id: coreComponent
        Core {
            anchors { fill: parent }
        }
    }

    View {
        id: view
        visible: back.opacity > 0

        anchors { fill: parent }

        mattes: true
        mattesColor: "black"

        viewport.fillMode: Image.PreserveAspectFit
        viewport.width: 1100
        viewport.height: 660

        Item {
            id: back
            anchors { fill: parent }
            //color: "white"

            opacity: 0.99

            Behavior on opacity {
                NumberAnimation { duration: 1500 }
            }

            Image {
                id: publisherImage
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                source: back.opacity > 0 ? App.getAsset('publisher.png') : ''

                Behavior on opacity {
                    NumberAnimation { duration: 500 }
                }
            }

            Image {
                id: studioImage
                opacity: 0
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                source: back.opacity > 0 ? App.getAsset('studio.png') : ''

                Behavior on opacity {
                    NumberAnimation { duration: 1000 }
                }
            }

            Timer {
                id: crossFadeTimer
                running: back.opacity == 1
                interval: 1000
                onTriggered: {
                    publisherImage.opacity = 0
                    studioImage.opacity = 1
                }
            }

        }

    }

    Timer {
        id: launchTimer
        running: false
        interval: 2000
        repeat: true
        onTriggered: {

            if(launcher.status === Loader.Ready) {
                launcher.visible = true
                back.opacity = 0
                running = false
            }
        }
    }

    Timer {
        id: blackGrainTimer
        running: back.opacity == 1
        interval: 3500
        onTriggered: {
            studioImage.opacity = 0
            launchTimer.start()
        }
    }

    Timer {
        id: startTimer
        interval: 2000
        onTriggered: {
            application.visible = true
            back.opacity = 1
        }
    }

    Timer {
        id: bannerRetryTimer
        interval: 45000
        property int reloads: 0
        onTriggered: {
            if(reloads < 50) {
                banner.load()
                reloads++
            } else
                App.info('Giving up banner ad reload')
        }
    }

    Timer {
        id: interstitialRetryTimer
        interval: 45000
        property int reloads: 0
        onTriggered: {
            if(reloads < 50) {
                interstitial.load()
                reloads++
            } else
                App.info('Giving up interstitial reload')
        }
    }

    // QtFirebase
    property alias analytics: analytics
    property alias banner: banner
    property alias interstitial: interstitial

    AdMob {
        appId: Qt.platform.os == "android" ? "ca-app-pub-6606648560678905~8027290070" : "ca-app-pub-6606648560678905~9364422479"

        testDevices: [
            "01987FA9D5F5CEC3542F54FB2DDC89F6",
            "d206f9511ffc1bc2c7b6d6e0d0e448cc"
        ]
    }

    AdMobBanner {
        id: banner

        adUnitId: Qt.platform.os == "android" ? "ca-app-pub-6606648560678905/9504023277" : "ca-app-pub-6606648560678905/1841155673"

        visible: loaded
        onVisibleChanged: {
            if(Qt.platform.os === "android")
                moveTo(AdMobBanner.PositionTopCenter)
        }

        width: Qt.platform.os === "android" ? 320 : application.width //parent.width
        height: 50

        request: AdMobRequest {}

        onReadyChanged: if(ready) load()

        onError: {
            //console.error('AdMobBanner error',code,message,width,height)
            bannerRetryTimer.restart()
        }

    }

    AdMobInterstitial {
        id: interstitial
        adUnitId: Qt.platform.os == "android" ? "ca-app-pub-6606648560678905/1980756471" : "ca-app-pub-6606648560678905/1701554870"

        request: AdMobRequest {}

        onReadyChanged: if(ready) load()

        onClosed: load()

        onError: interstitialRetryTimer.restart()
    }

    Analytics {
        id: analytics

        enabled: true

        minimumSessionDuration: 5000

        sessionTimeout: 10000

        Component.onCompleted: {
            App.event.sub('game/object/clicked',function(e){
                analytics.logEvent('Object','Click',e.name)
                analytics.logEvent('Object','Click_'+e.name)
                analytics.logEvent('Object','Click_'+e.name+'_at_'+e.at)
                if(e.at === 'inventory')
                    analytics.logEvent('Object','Inventory_click',e.name)
                else
                    analytics.logEvent('Object','Other_click',e.name)
            })
        }
    }


}
