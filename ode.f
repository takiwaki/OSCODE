
      module fields
      implicit none
      integer:: nstp,nmax
      real(8):: t,dt
      real(8):: x,y

      end module fields

      module param
      implicit none
      real(8):: omega
      end module param

      program ode
      use param
      use fields
      implicit none
      nmax =10000
      omega=1.0d0
      dt = 0.01d0

      t = 0.0d0
      x = 1.0d0
      y = 0.0d0
      do nstp =0, nmax
      call analytic
      call output("ana")
      t=t+dt
      enddo
      write(6,*) "ana: r=",sqrt(x**2+y**2)

      t = 0.0d0
      x = 1.0d0
      y = 0.0d0
      do nstp =0, nmax
      call Euler
      call output("fEu")
      t=t+dt
      enddo
      write(6,*) "fEu: r=",sqrt(x**2+y**2)

      t = 0.0d0
      x = 1.0d0
      y = 0.0d0
      do nstp =0, nmax
      call backEulerSI
      call output("bEu") 
      t=t+dt
      enddo
      write(6,*) "bEu: r=",sqrt(x**2+y**2)

      t = 0.0d0
      x = 1.0d0
      y = 0.0d0
      do nstp =0, nmax
      call CrankNicolsonSI
      call output("CrN") 
      t=t+dt
      enddo
      write(6,*) "CrN: r=",sqrt(x**2+y**2)

      t = 0.0d0
      x = 1.0d0
      y = 0.0d0
      do nstp =0, nmax
      call RK4
      call output("RK4")
      t=t+dt
      enddo
      write(6,*) "RK4: r=",sqrt(x**2+y**2)

      stop
      end program

!==========================================
      subroutine rhs(x,y,dx,dy)
      use param
      implicit none
      real(8),intent(in)::x,y
      real(8),intent(out)::dx,dy
      dx = - y * omega
      dy =   x * omega
      return
      end subroutine rhs
      subroutine jacobian(x,y,df1dx,df1dy,df2dx,df2dy)
      use param
      implicit none
      real(8),intent(in)::x,y
      real(8),intent(out)::df1dx,df1dy,df2dx,df2dy
      df1dx =  0.0d0
      df1dy = -omega 
      df2dx =  omega
      df2dy =  0.0d0
      return
      end subroutine jacobian
      subroutine invmtrix(a,b,c,d,ia,ib,ic,id)
      implicit none
      real(8),intent(in)::a,b,c,d
      real(8),intent(out)::ia,ib,ic,id
      real(8)::det
      det = a*d-b*c
      ia= d/det
      ib=-b/det
      ic=-c/det
      id= a/det

      return
      end subroutine invmtrix

!==========================================
      subroutine output(label)
      use fields
      implicit none
      integer,parameter::unitout=112
      character(3),intent(in)::label
      character(13)::filename
      if(nstp==0)then
      filename=label//"_t-xy.dat"
      open(unitout,file=filename,status='replace',form='formatted') 
      endif

      if(mod(nstp,10)==0)then
      write(unitout,'(3(1x,E15.6e3))') t,x,y
      endif
      if(nstp==nmax)then
      close(unitout) 
      endif
      return
      end subroutine output

!==========================================
      subroutine analytic()
      use param
      use fields
      implicit none
      x=cos(omega*t)
      y=sin(omega*t)

      return
      end subroutine analytic
!==========================================
      subroutine Euler
      use fields
      implicit none
      real(8)::dx,dy
      call rhs(x,y,dx,dy)
      x = x + dx*dt
      y = y + dy*dt
      return
      end subroutine Euler
!==========================================
      subroutine RK4
      use fields
      implicit none
      real(8)::dx1,dy1
      real(8)::dx2,dy2
      real(8)::dx3,dy3
      real(8)::dx4,dy4
      real(8):: x1, y1
      real(8):: x2, y2
      real(8):: x3, y3

      call rhs(x ,y ,dx1,dy1)
      x1 = x + dx1*dt*0.5d0
      y1 = y + dy1*dt*0.5d0
      call rhs(x1,y1,dx2,dy2)
      x2 = x + dx2*dt*0.5d0
      y2 = y + dy2*dt*0.5d0
      call rhs(x2,y2,dx3,dy3)
      x3 = x + dx3*dt
      y3 = y + dy3*dt
      call rhs(x3,y3,dx4,dy4)

      x = x + (dx1+2.0d0*dx2+2.0d0*dx3+dx4)*dt/6.0d0
      y = y + (dy1+2.0d0*dy2+2.0d0*dy3+dy4)*dt/6.0d0

      return
      end subroutine RK4
!==========================================
      subroutine backEulerSI
      use fields
      implicit none
      real(8)::f1,f2
      real(8)::df1dx,df1dy,df2dx,df2dy
      real(8)::dxodf1,   dyodf1,dxodf2,    dyodf2
      call rhs(x,y,f1,f2)
      call jacobian(x,y,df1dx,df1dy,df2dx,df2dy)
      call invmtrix(1.0d0-dt*df1dx,-dt*df1dy,-dt*df2dx,1.0d0-dt*df2dy
     &                   ,dxodf1,   dxodf2,   dyodf1,    dyodf2)
      x = x + f1*dt*dxodf1+ f2*dt*dxodf2
      y = y + f1*dt*dyodf1+ f2*dt*dyodf2
      return
      end subroutine backEulerSI
!==========================================
      subroutine CrankNicolsonSI
      use fields
      implicit none
      real(8)::f1,f2
      real(8)::df1dx,df1dy,df2dx,df2dy
      real(8)::dxodf1,   dyodf1,dxodf2,    dyodf2
      call rhs(x,y,f1,f2)
      call jacobian(x,y,df1dx,df1dy,df2dx,df2dy)
      call invmtrix(1.0d0-dt*df1dx,-dt*df1dy,-dt*df2dx,1.0d0-dt*df2dy
     &                   ,dxodf1,   dxodf2,   dyodf1,    dyodf2)
      x = x + (f1*dt*dxodf1+ f2*dt*dxodf2+f1*dt)/2.0d0
      y = y + (f1*dt*dyodf1+ f2*dt*dyodf2+f2*dt)/2.0d0
      return
      end subroutine CrankNicolsonSI
!==========================================
