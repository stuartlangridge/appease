import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0

MainView {
    id: root
    objectName: "mainView"
    applicationName: "appease.sil"
    width: units.gu(100)
    height: units.gu(75)

    property var db: null

    Page {
        id: pg
        title: "Appease"

        Label {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: units.gu(1)
            anchors.rightMargin: units.gu(1)
            text: 'this is an <a href="http://www.kryogenix.org">sil</a> thing'
            onLinkActivated: Qt.openUrlExternally("http://www.kryogenix.org")
            fontSize: "small"
            linkColor: "#c1c101"
        }
    }

    Component.onCompleted: {
        root.db = LocalStorage.openDatabaseSync("appease.db", "1.0", "Appease app db", 100000);
        try {
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS apps (appid TEXT UNIQUE, version TEXT, icon TEXT)');
            });
        } catch (err) {
            console.log("Error creating table in database: " + err);
        };
    }
}