sqr x = x*x
fact x = product [1 .. x]
coef n k = (product [1 .. n])/((product [1 .. (n-k)])*(product [1 .. k]))
coef2 n k= (fact n)/((fact (n-k))*fact k)

