onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK_50 -radix binary /testbench/CLOCK_50
add wave -noupdate -label KEY -radix binary /testbench/KEY
add wave -noupdate -label SW -radix binary /testbench/SW
add wave -noupdate -label VGA_R -radix hexadecimal /testbench/VGA_R
add wave -noupdate -label VGA_G -radix hexadecimal /testbench/VGA_G
add wave -noupdate -label VGA_B -radix hexadecimal /testbench/VGA_B
add wave -noupdate -label VGA_HS -radix binary /testbench/VGA_HS
add wave -noupdate -label VGA_VS -radix binary /testbench/VGA_VS
add wave -noupdate -label VGA_BLANK_N -radix binary /testbench/VGA_BLANK_N
add wave -noupdate -label VGA_SYNC_N -radix binary /testbench/VGA_SYNC_N
add wave -noupdate -label VGA_CLK -radix binary /testbench/VGA_CLK
add wave -noupdate -divider vga_demo
add wave -noupdate -label x -radix hexadecimal /testbench/U1/X
add wave -noupdate -label y -radix hexadecimal /testbench/U1/Y
add wave -noupdate -label xC -radix hexadecimal /testbench/U1/XC
add wave -noupdate -label yC -radix hexadecimal /testbench/U1/YC
add wave -noupdate -label object_address -radix hexadecimal /testbench/U1/U6/address
add wave -noupdate -label object_color -radix hexadecimal /testbench/U1/U6/q
add wave -noupdate -divider vga_adapter
add wave -noupdate -label colour -radix hexadecimal /testbench/U1/VGA/colour
add wave -noupdate -label x -radix hexadecimal /testbench/U1/VGA/x
add wave -noupdate -label y -radix hexadecimal /testbench/U1/VGA/y
add wave -noupdate -label plot -radix hexadecimal /testbench/U1/VGA/plot
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 80
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {120 ns}
