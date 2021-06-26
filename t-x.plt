

set style line 1 linetype 1 linewidth 4 lc rgb "#ff2800" # universal design red
set style line 2 linetype 1 linewidth 4 lc rgb "#35a16B" # universal design green
set style line 3 linetype 1 linewidth 4 lc rgb "#0000ff" # universal design blue
set style line 4 linetype 1 linewidth 4 lc rgb "#ff8c00" # universal design dark-orange
set style line 5 linetype 1 linewidth 4 lc rgb "#ff00ff" # universal design magenta
set style line 6 linetype 1 linewidth 4 lc rgb "#a52a2a" # universal design brown
set style line 7 linetype 1 linewidth 4 lc rgb "#1a1a1a" # universal design grey10

pngflag=1

inputana="ana_t-xy.dat"
inputfEu="fEu_t-xy.dat"
inputbEu="bEu_t-xy.dat"
inputCNi="CNi_t-xy.dat"
inputRK4="RK4_t-xy.dat" 

set key left top
set xlabel "t"
set xrange [0:100]

set ylabel "x"

if(pngflag==1) set terminal push
if(pngflag==1) set terminal pngcairo
if(pngflag==1) set output "t-x.png"

plot NaN notitle \
, inputana u 1:2 w l ls 7 title "analytic" \
, inputfEu u 1:2 w l ls 2 title "Euler"  \
, inputbEu u 1:2 w l ls 5 title "backward Euler"  \
#, inputCNi u 1:2 w l ls 1 title "Crank Nicolson"  \
#, inputRK4 u 1:2 w l ls 3 title "RK4" \

if(pngflag==1) set output "t-x_zoom.png"
set xrange [490:*]

plot NaN notitle \
, inputana u 1:2 w l ls 7 title "analytic" \
, inputCNi u 1:2 w l ls 1 title "Crank Nicolson"  \
, inputRK4 u 1:2 w l ls 3 title "RK4" \


replot

if(pngflag==1) set output "t-xerr_ini.png"
set key left bottom
set ylabel "Error of x"
set log y
set xrange [*:10]
plot NaN notitle \
, inputfEu u 1:(abs($2-$4))   w l ls 2 title "Euler"  \
, inputbEu u 1:(abs($2-$4))   w l ls 5 title "backward Euler"  \
, inputCNi u 1:(abs($2-$4)*2) w l ls 1 title "Crank Nicolson(x2)"  \
, inputRK4 u 1:(abs($2-$4))   w l ls 3 title "RK4" \


if(pngflag==1) set output "t-xerr_fin.png"

unset log x
set xrange [490:*]

plot NaN notitle \
, inputCNi u 1:(abs($2-$4)) w l ls 1 title "Crank Nicolson"  \
, inputRK4 u 1:(abs($2-$4)) w l ls 3 title "RK4" \

replot

if(pngflag==1)set terminal pop
