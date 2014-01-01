.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

function Storage() {
	console.debug("Creating database...")
	this.db = Sql.LocalStorage.openDatabaseSync(
			"ShintyokuRitsu", "0.1", "Task database", 4*1024*1024)
	console.debug("Initializing database...")
	this.db.transaction(function(tx) {tx.executeSql(
			'CREATE TABLE IF NOT EXISTS Tasks(' +
			'id INTEGER PRIMARY KEY, ' +
			'name TEXT, ' +
			'isProject TEXT, ' +
			'importance INTEGER, ' +
			'deadline NONE, ' +
			'detail TEXT, ' +
			'targetTime INTEGER, ' +
			'percent INTEGER, ' +
			'tag TEXT, ' +
			'projectId INTEGER)')})
	console.debug("Database created")
}

Storage.prototype = {

	readTasks : function(projectId) {
		console.debug("Reading tasks... (projectId: " + projectId + ")")
		var r
		this.db.transaction(function(tx) {
			if(projectId === "" || projectId === undefined) {
				r = tx.executeSql('SELECT * FROM Tasks WHERE projectId = -1')
			}
			else {
				r = tx.executeSql('SELECT * FROM Tasks WHERE projectId = ?', projectId)
			}
		})
		return r
	},

	readTask : function(id) {
		console.debug("Reading task... (id: " + id + ")")
		var r
		this.db.transaction(function(tx) {
			if(id === undefined) {
				return
			}
			else {
				r = tx.executeSql('SELECT * FROM Tasks WHERE id = ?', id)
			}
		})
		return r
	},

	addTask : function(name, isProject, importance, deadline, detail, percent, tag, projectId) {
		console.debug("Adding Task...")
		this.db.transaction(function(tx) {
			var r = tx.executeSql(
					'INSERT OR REPLACE INTO Tasks(name, isProject, importance, ' +
					'deadline, detail, targetTime, percent, tag, projectId) ' +
					'VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
					[name, isProject, importance, deadline, detail, percent, tag, projectId])
			console.log("Task Saved: " + r)
		})
	}
}

