setMode -bscan
setCable -p auto
addDevice -position 1 -file flashram.bit
ReadIdcode -p 1
program -p 1
quit
