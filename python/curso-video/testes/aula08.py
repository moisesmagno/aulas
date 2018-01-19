# from math import sqrt, floor
import math

num = int(input('Número: '))

raiz = math.sqrt(num)

print('A raiz quadrada de {0} é o número {1}'.format(num, raiz))

#Arredondando o resultado para cima.f
print('A raiz quadrada de {0} é o número {1}'.format(num, math.ceil(raiz)))

#Arredondadno o resultado para baixo.
print('A raiz quadrada de {0} é o número {1}'.format(num, math.floor(raiz)))

#Mostrando apenas 3 casas decimais.
print('A raiz quadrada de {} é o número {:.2f}'.format(num, raiz))