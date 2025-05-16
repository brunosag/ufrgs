onerror {exit -code 1}
vlib work
vlog -work work display.vo
vlog -work work waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.display_vlg_vec_tst -voptargs="+acc"
vcd file -direction display.msim.vcd
vcd add -internal display_vlg_vec_tst/*
vcd add -internal display_vlg_vec_tst/i1/*
run -all
quit -f
