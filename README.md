Slice 3d .stl models with latest CuraEngine inside a Docker container!

Use Dockerfile to build the image (note that port 8080 will be used by server)

Exec to your running container and run server.js using node. Now server must be running on port 8080.

Now send a stl file with multipart form-data to localhost:<port>/slice and result gcode will be recieved.
