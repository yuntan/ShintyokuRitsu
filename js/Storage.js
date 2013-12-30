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
			'deadline DATA, ' +
			'detail TEXT, ' +
			'percent INTEGER, ' +
			'tag TEXT, ' +
			'project TEXT)')})
	console.debug("Database created")
}

Storage.prototype = {

	readTasks : function(project) {
		console.debug("Reading tasks...")
		var r
		this.db.transaction(function(tx) {
			if(project === "" || project === undefined) {
				r = tx.executeSql('SELECT * FROM Tasks')
			}
			else {
				r = tx.executeSql('SELECT * FROM Tasks WHERE project = ?', project)
			}
		})
		return r
	},

	addTask : function(name, isProject, importance, deadline, detail, percent, tag, project) {
		console.debug("Adding Task...")
		this.db.transaction(function(tx) {
			var r = tx.executeSql(
					'INSERT OR REPLACE INTO Tasks(name, isProject, importance, ' +
					'deadline, detail, percent, tag, project) ' +
					'VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
					[name, isProject, importance, deadline, detail, percent, tag, project])
			console.log("Task Saved: " + r)
		})
	}
}

