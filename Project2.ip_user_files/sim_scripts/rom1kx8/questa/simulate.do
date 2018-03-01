onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib rom1kx8_opt

do {wave.do}

view wave
view structure
view signals

do {rom1kx8.udo}

run -all

quit -force
