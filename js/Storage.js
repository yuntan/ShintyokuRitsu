.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

/*********************************************************
  id (int): Task ID. Unique key.
  name (str): Task name
  isProject (int): If the task can contain sub tasks, 1.
    Else 0.
  importance (int): 0, 1, 2, or 3. Higher priority higher
    number.
  deadline (int): Task deadline in Unix time format.
    (no deadline -> 0)
  detail (str): Task detail
  targetTime (int): Estimated time the task requires in min
  timeLapse (int): The total sum of time recorded.
  percent (int): Current task rate
  folder (str): folder the task belong to
  projectId (int): If the task belongs to another project,
    this value should be id of the project. Else -1.
**********************************************************/

// Storage class
function Storage() {
	console.debug("Creating database...")
	this.db = Sql.LocalStorage.openDatabaseSync(
			"ShintyokuRitsu", "0.1", "Task database", 4*1024*1024)
	console.debug("Initializing database...")
	this.db.transaction(function(tx) {tx.executeSql(
			'CREATE TABLE IF NOT EXISTS Tasks(' +
            'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
			'name TEXT, ' +
            'isProject INTEGER, ' +
            'importance INTEGER, ' +
            'deadline INTEGER, ' +
			'detail TEXT, ' +
			'targetTime INTEGER, ' +
            'timeLapse INTEGER, ' +
			'percent INTEGER, ' +
            'folder TEXT, ' +
			'projectId INTEGER)')})
	console.debug("Database created")
}

Storage.prototype = {

    // Read all tasks its projectId matches with argument.
	readTasks : function(projectId) {
		console.debug("Reading tasks... (projectId: " + projectId + ")")
		var r
		this.db.transaction(function(tx) {
			if(projectId === "" || projectId === undefined) {
                r = tx.executeSql("SELECT * FROM Tasks WHERE projectId = -1")
			}
			else {
                r = tx.executeSql("SELECT * FROM Tasks WHERE projectId = ?", projectId)
			}
		})
        return r
	},

    // Returns a task its id is matches with argument.
    readTaskById : function(id) {
		console.debug("Reading task... (id: " + id + ")")
		var r
		this.db.transaction(function(tx) {
			if(id === undefined) {
				return
			}
			else {
                r = tx.executeSql("SELECT * FROM Tasks WHERE id = ?", id)
			}
		})
        return r.rows.item(0)
    },

    // Returns tasks its belonging folder is match with argument.
    readTasksByFolder: function(folder) {
        console.debug("Reading task... (folder: " + folder + ")")
        var r
        this.db.transaction(function(tx) {
            if(id === undefined) {
                return
            }
            else {
                r = tx.executeSql("SELECT * FROM Tasks WHERE folder = '?'", folder)
            }
        })
        return r
    },

    // Returns tasks its deadline is posterior to argument
    readTasksByDeadline: function(unixtime) {
        console.debug("Reading task... (folder: " + folder + ")")
        var r
        this.db.transaction(function(tx) {
            if(unixtime === undefined) {
                return
            }
            else {
                r = tx.executeSql("SELECT * FROM Tasks WHERE deadline > ?", unixtime)
            }
        })
        return r
    },

    // Create a new task in database
    addTask : function(name, isProject, importance, deadline, detail, targetTime, percent, folder, projectId) {
		console.debug("Adding Task...")
		this.db.transaction(function(tx) {
			var r = tx.executeSql(
                    "INSERT OR REPLACE INTO Tasks(name, isProject, importance, " +
                    "deadline, detail, targetTime, timeLapse, percent, folder, projectId) " +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    [name, isProject, importance, deadline, detail, targetTime, 0, percent, folder, projectId])
			console.log("Task Saved: " + r)
		})
	}
}
