#        _
#   __ _| | __ _  ___  _ __ __ ___   _____
#  / _` | |/ _` |/ _ \| '__/ _` \ \ / / _ \
# | (_| | | (_| | (_) | | | (_| |\ V /  __/
#  \__,_|_|\__, |\___/|_|  \__,_| \_/ \___|
#          |___/
#                           _   _       _
#   ___  ___ ___  ___ _ __ | |_(_) __ _| |___
#  / _ \/ __/ __|/ _ \ '_ \| __| |/ _` | / __|
# |  __/\__ \__ \  __/ | | | |_| | (_| | \__ \
#  \___||___/___/\___|_| |_|\__|_|\__,_|_|___/
#
#  _                             ____       
# | | ___  ___ ___  ___  _ __   |___ \ __ _ 
# | |/ _ \/ __/ __|/ _ \| '_ \    __) / _` |
# | |  __/\__ \__ \ (_) | | | |  / __/ (_| |
# |_|\___||___/___/\___/|_| |_| |_____\__,_|
#                                          



# extra class, catching up


############
# drumpats #
############

pats = [
  [2],
  [1,1],
  [0.25,0.25,0.25,0.25],
  [0.5,0.5,0.5,0.5],
  [1,0.5,0.5],
  [0.5,1,0.5],
  [0.5,0.5,1],
  [0.5,1.5],
  [1.5,0.5]
]

live_loop :eakkick do
  sample :bd_fat
  sleep 2r
end

live_loop :brkbts do
  
  n = rand_i(pats.length)
  pats[n].length.times do
    pats[n].tick
    print pats[n].look/2.0
    sample  choose([:sn_dolf , :sn_dub]) ##, rate: choose([1.6,2]), amp:1
    play scale(:d4, :major).choose, release: pats[n].look
    sleep (pats[n].look)
  end
end

sn = ring(0, 1)

live_loop :beats do
  
  sample :drum_heavy_kick, amp: 1.3
  sleep 0.5
  sample :drum_cymbal_closed, amp: 1.3 if sn.tick == 1
  sleep 0.5
end

sample





#########
# synth #
#########


tbrel = 2


live_loop :synth do
  use_synth :tb303
  print chord(:E3, :minor7)
  play_pattern_timed chord((ring :E3, :A3, :E3, :C3).choose, choose([:minor7])), [0.5, 1], amp: 0.5
  sleep 1
end

live_loop :justine do
  use_synth :tb303
  play choose([:E4, :C4]) , release: tbrel, phase: 2, amp: 1.5
  sleep choose([ 1])
end





############
# patterns #
############

sample :drum_snare_hard, amp: 0.6 if one_in(4)
sleep 0.5
end

live_loop :hat do
  sample :drum_cymbal_open, amp: 0.6 if one_in(4)
  sleep 0.25
end


pat1 = (ring :c, :r, :r, :a, :f5, :r, :e, :r)
pat2 = (ring :d, :e5, :r, :a, :f5, :r, :a, :e5)
pat3 = chord(:E3, :M7)

pat = [pat1, pat2]


blade = (ring :a, :f, :g)


live_loop :riff do
  print (ring pat)
  for x in pat
    play x.tick, amp: 0.13
  end
  sleep 0.25
end


live_loop :lead do
  with_fx :reverb, room: 0.98, damp: 0.4 do
    with_fx :slicer, phase: 2 do
      synth :blade, note: blade.tick, release: 4, cutoff: 100, amp: 0.5
      synth :blade, note: blade.look - 12, release: 4, cutoff: 100, amp: 0.5
    end
    sleep 4
  end
end


live_audio :foo


live_loop :midi do
  midi pat1.tick
  sleep 0.25
end



