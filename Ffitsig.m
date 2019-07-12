% fitting with exponential function  

function f = Ffitsig(x,xdata)

f=100./(1+exp( -(xdata -x(1)).*x(2)) ) ;