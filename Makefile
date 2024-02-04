
EXE   = ode.x

FC    = gfortran
OPTS  = -g -fbacktrace -O2

.SUFFIXES: .f90 .o
.f90.o: 
	${FC} ${OPTS} -c $<

${EXE}: ode.o
	${FC} ${OPTS} $< -o $@

clean:
	rm -fr *.o *.mod ${EXE}

cleandata:
	rm -fr *.dat

