## What is this?
A 2D counter-strike clone.

## How do I play?
Grab a release from the [releases page](https://github.com/StormLight14/pew-pew-io/releases). The game is still in the alpha stage, so don't expect a great experience.

## How do I join a server?
If you are connecting to a server not being hosted on the same device, replace the default `127.0.0.1` with the IP of the server you want to connect to, and change the port (default `9595`) if the server you are connecting to uses a different one.

## How do I host a server for others to join?
Either use the GUI and press host game, or run the binary from the command line with the headless flag if you don't want to display anything. (ex: `./pew-pew-io.x86_64 --headless`)

If you want people outside your network to join, you will need to go into your router settings and port forward the port you are hosting (default `9595`)

## Autostart
To configure autostart on your server, you need to use the --autostart-amount command line argument. 

Here's an example: `./pew-pew-io.x86_64 --headless -- --autostart-amount 2` to start at 2 players.
