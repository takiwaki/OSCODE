# OSCODE

Solve oscillation equation numerically. Here x is a complex number.

![\begin{align*}
\frac{{\rm d}x}{{\rm d }t}=\imath \omega x 
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0A%5Cfrac%7B%7B%5Crm+d%7Dx%7D%7B%7B%5Crm+d+%7Dt%7D%3D%5Cimath+%5Comega+x+%0A%5Cend%7Balign%2A%7D%0A)

The analyric solution of this equation is as follows.  

![\begin{align*}
x = \cos(\omega t )+ \imath \sin (\omega t )
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0Ax+%3D+%5Ccos%28%5Comega+t+%29%2B+%5Cimath+%5Csin+%28%5Comega+t+%29%0A%5Cend%7Balign%2A%7D%0A)

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
