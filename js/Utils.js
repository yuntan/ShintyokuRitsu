function taskModel(r, parent) {
    // create ListModel component
    var listModel = Qt.createQmlObject("import QtQuick 2.2; ListModel { }", parent)

    // add datas to listModel
    for(var i = 0; i < r.rows.length; i++) {
        listModel.append({   "taskId": r.rows.item(i)['id'],
                             "name": r.rows.item(i)['name'],
                             "isProject": r.rows.item(i)['isProject'],
                             "importance": r.rows.item(i)['importance'],
                             "deadline": r.rows.item(i)['deadline'],
                             "detail": r.rows.item(i)['detail'],
                             "targetTime": r.rows.item(i)['targetTime'],
                             "percent": r.rows.item(i)['percent'],
                             "folder": r.rows.item(i)['folder'],
                             "projectId": r.rows.item(i)['projectId']})
    }
    return listModel
}
