# FiveM-Plane-AutoPilot
This script allows players to activate an auto-pilot for their plane in FiveM. The auto-pilot will hold the plane's current speed and height. The auto-pilot status will be synchronized between all players in the same plane.

# Installation
1. Create a new directory in your resources folder and name it autopilot
2. Copy the client.lua and server.lua files into the autopilot directory
3. Add the following line to your server.cfg file to start the script on your server: ```start/ensure autopilot```

# Usage
- Get into a plane as a driver or passenger
- Chat /ap to activate the auto-pilot
- The auto-pilot will hold the plane's current speed and height
- Do /ap again to deactivate the auto-pilot


# Notes
- The script assumes that all players have a valid FiveM client and are running the same version of the script.
- The script uses the /ap activation command. You can change the command in the client.lua file if desired.
- The script uses the current speed and height of the plane when the auto-pilot is activated. If the plane's speed or height changes after the auto-pilot is activated, the auto-pilot will continue to hold the original speed and height.
- The script does not provide any error handling or recovery mechanisms. Use at your own risk.
