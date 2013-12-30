import QtQuick 2.2
import QtQuick.LocalStorage 2.0

ListModel {
	id: listModel

	property string projectName: ""
	property var db

	Component.onCompleted: {
		console.debug("Creating database...")
		db = LocalStorage.openDatabaseSync(
				"ShintyokuRitsu", "0.1", "Task database", 4*1024*1024)
		console.debug("Initializing database...")
		db.transaction(function(tx) {tx.executeSql(
				'CREATE TABLE IF NOT EXISTS Tasks(' +
				'id INTEGER PRIMARY KEY, ' +
				'name TEXT, ' +
				'isProject TEXT, ' +
				'importance INTEGER, ' +
				'deadline DATA, ' +
				'detail TEXT, ' +
				'percent INTEGER, ' +
				'tag TEXT, ' +
				'project TEXT')})
		console.debug("end onCompleted")
	}

	function readTasks(project) {
		console.debug("Reading tasks...")
		var r
		db.transaction(function(tx) {
			if(project === "") {
				r = tx.executeSql('SELECT * FROM Tasks')
			}
			else {
				r = tx.executeSql('SELECT * WHERE project = ? FROM Tasks', project)
			}
		})
		console.debug("tasks: " + r)

		var ret = new array[r.rows.length]
		for(var i = 0; i < r.rows.length; i++) {
			ret[i] = r.rows.item(i)
		}
		return ret
	}

	function addTask(name, isProject, importance, deadline, detail, percent, tag, project) {
		console.debug("Adding Task...")
		db.transaction(function(tx) {
			var r = tx.executeSql(
					'INSERT OR REPLACE INTO Tasks(name, isProject, importance, ' +
					'deadline, detail, percent, tag, project) ' +
					'VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
					[name, isProject, importance, deadline, detail, percent, tag, project])
			console.log("Task Saved: " + r)
		})
	}

	Repeater {
		model: readTasks("")

		ListElement {
			_name: name
			_detail: detail
			_percent: percent
		}
	}

	ListElement {
		_name: "進捗1"
		_detail: "hogehoge"
		_percent: "80"
	}
	ListElement {
		_name: "進捗2"
		_detail: "fugafuga"
		_percent: "60"
	}
	ListElement {
		_name: "進捗3"
		_detail: "hogefuga"
		_percent: "40"
	}
	ListElement {
		_name: "進捗4"
		_detail: "piyopiyo"
		_percent: "20"
	}
	ListElement {
		_name: "進捗5"
		_detail: "poyopoyo"
		_percent: "0"
	}
}
