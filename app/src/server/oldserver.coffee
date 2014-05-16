###
Module dependencies.
###

express  = require("express")

###
Main application entry file.
Please note that the order of loading is important.
###

# Load configurations
# Set the node enviroment variable if not set before
process.env.NODE_ENV = process.env.NODE_ENV || "development"

# Initializing system variables
config   = require("./config/common")
mongoose = require("mongoose")

console.log config.db
# Bootstrap db connection
db = mongoose.connect config.db

# Bootstrap models
require("./models/user")

# Bootstrap passport config
require("./config/passport")(passport, config)

# Create Express
app = express()
require("./config/express")(app, passport, db, config)
require("./config/routes")(app)
server = require("http").createServer(app)

# Hook Socket.io into Express
io     = require("socket.io").listen(server)

# Start the app by listening on <port>
port = process.env.PORT || config.port
server.listen port
console.log "Express app started on port " + port

# Socket.io Communication
socketRoutes = require("./config/sockets")
io.sockets.on("connection", socketRoutes)

# Initializing logger
logger.init app, passport, mongoose

# Expose app
exports = module.exports = server
