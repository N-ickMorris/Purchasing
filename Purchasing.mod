set P;	#products
set O;	#operations
set M;	#machines
set H;	#handling

param d{P};		#demand
param a;		#availability of all M and H equipment
param Fm{M};	#fixed cost of all M
param Fh{H};	#fixed cost of all H
param b;		#budget
param c{O,M};	#cost of doing O on M
param g{P,H};	#cost of moving P with H
param t{O,M};	#time it takes to do O on M
param s{P,H};	#time it takes to move P with H
param r{O};		#required number of O to do
param e;		#total time each M and H is available

var v{M} integer >= 0;			#num of M bought
var w{H} integer >= 0;			#num of H bought
var y{O,M} integer >= 0;		#num of O on M					#Assumption: The total number of O done on M determines how much of the requirement r{O} is satisfied
var z{P,H} integer >= 0;		#num of P that is moved with H	#Assumption: The total number of P moved with H determines how much of the demand is satisfied

minimize Cost: sum{o in O, m in M}(c[o,m]*y[o,m]) + sum{p in P, h in H}(s[p,h]*z[p,h]) + sum{m in M}(Fm[m]*v[m]) + sum{h in H}(Fh[h]*w[h]);
s.t. Operations{o in O}: sum{m in M}(y[o,m]) >= r[o];
s.t. Demand{p in P}: sum{h in H}(z[p,h]) >= d[p];
s.t. MTime{m in M}: sum{o in O}(t[o,m]*y[o,m]) <= a*e*v[m];
s.t. HTime{h in H}: sum{p in P}(s[p,h]*z[p,h]) <= a*e*w[h];
s.t. Budget: sum{m in M}(Fm[m]*v[m]) + sum{h in H}(Fh[h]*w[h]) <= b;