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
#
#  _                             ____  
# | | ___  ___ ___  ___  _ __   |___ \ 
# | |/ _ \/ __/ __|/ _ \| '_ \    __) |
# | |  __/\__ \__ \ (_) | | | |  / __/ 
# |_|\___||___/___/\___/|_| |_| |_____|
#
#

#########
# beats #
#########

# beat once/ times / loop / spread

live_loop :kick do
  sample :drum_bass_hard, amp: 1
  sleep 1
end


live_loop :snare do
  r = rrand(0, 1)
  sample :drum_snare_soft if (r > 0.5)
  sleep 0.5
end


live_loop :kick do
  with_fx :reverb, room: 1 do
    sample :drum_heavy_kick, rate: 1
    sleep 0.5
  end
  
  sample :drum_snare_hard, amp: 0.6 if one_in(4)
  sleep 0.5
end

live_loop :hat do
  sample :drum_cymbal_open, amp: 0.6 if one_in(4)
  sleep 0.25
end

rthm1 = (spread 7,12)
rthm3 = (spread 5,8)
rthm2 = (spread 5,8)


live_loop :euc1 do
  with_fx :krush do
    if rthm1.tick then
      sample :drum_bass_hard
    end
  end
  sleep 0.5
end

live_loop :euc2 do
  rthm2.tick
  sample :drum_bass_soft if rthm2.look
  sample :ambi_choir if rthm2.look
  
  sleep 0.5
end


live_loop :euc3 do
  
  sample :drum_snare_hard if rthm3.tick
  
  sleep 0.5
end