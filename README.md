# OSCODE

Solve oscillation equation numerically. Here x is a complex number.

$\frac{{\rm d}x}{{\rm d }t}=\imath \omega x $

The analyric solution of this equation is as follows.  
$x = \cos(\omega t )+ \imath \sin (\omega t )$

## How to run

    git clone https://github.com/takiwaki/OSCODE.git
    cd OSCODE
    make
    ./ode.x
    gnuplot t-x.plt



## Results

![figure 1](/img/t-x.png)

The Euler method diverge and backward Euler method diminishes.

![figure 2](/img/t-x_zoom.png)

The RK4 and Crank Nicolson method is consistent with the analytic one.

![figure 3](/img/t-xerr_fin.png)

The error of Crank Nicolson method is smaller than that of RK4 in this time range.
Note that the error of RK4 can be smaller than Crank Nicolson at later time.

## References

http://cms.phys.s.u-tokyo.ac.jp/~naoki/CIPINTRO/CIP/wave.html

http://www-solid.eps.s.u-tokyo.ac.jp/~ataru/edu/ensyu1.pdf
