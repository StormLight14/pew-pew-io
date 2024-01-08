## What is this?
A 2D counter-strike clone.

## How do I join a server?
If you are connecting to a server not being hosted on the same device, replace the default `127.0.0.1` with the IP of the server you want to connect to, and change the port (default `9595`) if the server you are connecting to uses a different one.

## How do I host a server for others to join?
Either use the GUI and press host game, or run the binary from the command line with the headless flag if you don't want to display anything. (ex: `./pew-pew-io.x86_64 -- --headless`)

If you want people outside your network to join, you will need to go into your router settings and port forward the port you are hosting (default `9595`)

## Autostart
If 10 players connect the game will automatically start; there is currently no way to change this number besides from the code. (TODO: allow changing this number from the GUI or with a command line argument)

## Why is it lagging so much, this is terrible
Idk I'll optimize later


