#to use hydra with sonicpi and OSC
# start local hydra
# ~/livecode/algoraveEssentials/hydra$ yarn serve
# goto ~/livecode/algoraveEssentials/hydra-osc
# run node server.js

use_osc "localhost", 41234


live_loop :algoessentials do
  if one_in(4)
    osc "/hue", rrand(2,200)
    sample :drum_bass_hard
  else
    sample :drum_bass_soft
    midi :e3, release: 0.1 if (one_in 4)
    osc "/newimg", (ring 61, 12, 5, 12).tick
    
  end
  sleep 0.5
end






