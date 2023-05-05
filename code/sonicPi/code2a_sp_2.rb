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

## lets make some techno
## all loops are at amp: 0
## if you run the code you won't hear a thing
## up the amp: parameter on each loop to hear it
## for all loops it has been mapped to a "synthnameamp" variable
## change it between 0-1 (or louder)
## exception
## for the :lead_synth loop, change the 'leadamp' 
## variable in the beginning of the loop, lower = louder
## define sample locations here

#chh = "~/samples/tidal/ldmchh/chh-004.wav"
chh = :sn_dolf



use_bpm 150

live_loop :drums do
  drumsamp = 1
  sample :bd_haus, amp: drumsamp
  if tick%2 == 1
    sample chh , amp: drumsamp
  end
  sleep 0.5
  sample :drum_cymbal_open, sustain: 0.02, release: 0.1, amp: drumsamp
  sleep 0.5
end


live_loop :voc do
  with_fx :autotuner do |c|
    with_fx :slicer do |s|
      control c, note: (scale :e8, :minor_pentatonic, num_octaves: 1).choose
      control s, phase: 0.25, wave: 2
      sample "~/samples/tidal/turbo/", :turbo3, amp: 0, rate: 1
    end
  end
  sleep 16
end

live_loop :tssk do
  tsskamp = 0
  sample :elec_mid_snare, amp: tsskamp
  sleep 2
  sample :elec_lo_snare, amp: tsskamp if (one_in 2)
  sleep 2
end

nts = (ring :g2, :c3, :f2)

live_loop :octaves do
  use_synth :tb303
  use_synth_defaults amp: 0, sustain: 0.1, release: 0.05
  
  define :octave do |n|
    play n
    sleep 0.25
    play n+12
    sleep 0.25
    
  end
  
  8.times do
    octave :e2
  end
  nts.tick
  8.times do
    octave nts.look
  end
end


live_loop :lead_synth do
  leadamp = 100 ## needs to be > than zero (so non-zero!!) 1 is loud, o.5 is louder, 100 is off
  use_synth :dsaw
  use_synth_defaults release: 0.3, sustain: 0.2, amp:  (ring 0.6,0.5,0.4,0.3,0.2,0.3,0.4,0.5).tick/leadamp
  use_random_seed (ring 42, 44).tick
  
  notes = (scale :e2, :minor_pentatonic, num_octaves: 2)
  
  16.times do |a|
    play notes.choose
    sleep 0.5
  end
end
