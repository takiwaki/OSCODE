
EXE       = ode.x

FC    = ifort -c -extend-source 
FCb   = ifort
OPTS  = -g -traceback -O2

.f.o: 
	${FC} ${OPTS} $<

${EXE}: ode.o
	${FCb} ${OPTS} $< -o $@

clean:
	rm -fr *.o *.mod ${EXE}

cleandata:
	rm -fr *.dat

