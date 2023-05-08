##| some notes on Euclidian Rhythmms, well explained in this video
##| https://www.youtube.com/watch?v=8G8qko7NZdE
## code below is modeled like in the video
## set the amps below above 0 one by one, feel the rhythm grow...

beatamp  = 1
kalamp = 0 ## 0.5 works well
clapamp = 0  ## 0.8
tablamp = 0 ## 0.5
bellamp = 0 ## 0.7


use_bpm 100
beat = (spread 4,32)
kal = (spread 12,32)
clap = (spread 13,32)
tabla = (spread 10,32)
bell = (spread 11,32)


live_loop :beat do
  if beat.tick then
    sample :bd_zum, amp: beatamp
  end
  sleep 0.25
end


live_loop :string do
  if kal.tick then
    use_synth :kalimba
    play (ring :c4, :e4, :a4, :f4, :c3).tick, amp: kalamp
  end
  sleep 0.25
end


live_loop :clap do
  if clap.tick then
    sample :perc_snap, amp: clapamp, hpf: 110
  end
  sleep 0.25
end



live_loop :tabla do
  if tabla.tick then
    sample :tabla_ghe7, amp: tablamp
  end
  sleep 0.25
end


live_loop :bell do
  if bell.tick then
    sample :elec_bell, amp: bellamp, cutoff: 60
  end
  sleep 0.25
end
