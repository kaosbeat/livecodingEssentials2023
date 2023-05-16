# OSC connectivity

we can send OSC from hydra to sonic pi and vice versa

## hydra
start hydra
~/livecode/algoraveEssentials/hydra$ yarn serve

start hydra-osc
run node server.js

see [code3 hydra](code/hydra/code3_hydra.js)for code example


## sonic Pi
use the command  
`use_osc "localhost", 41234`
to start an osc server  
and a command like     
`osc "/hue", rrand(2,200)`  

to send out osc, see [code3 sonic pi](code/sonicPi/code3_sp.rb) for code example