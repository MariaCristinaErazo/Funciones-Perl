#1. Paso de parametros
#2. Diferentes posibilidades de ´funciones
#3. Recursion

use strict;
use warnings;
use Data::Dump qw(dump);
#vamos a crear el prototipo de nuestra funcion de ordenamiento
sub a_sort{
    if (!@_) {
        #code
        print "TypeError: a_sort()";
    }
    #sort(a, axis=-1, kid=None, order=None)
    my($array_ref, $var1, $var2, $var3)=@_;#en este momento no sabemos si var 1 pertenece a axis, o var 2 al tipo
    #para ello vamos a establecer un valor por defecto
    my($axis, $kind, $order)=(-1,"quicksort", undef);
    #vamos a eliminar los espacios en blanco
    $var1=~ s/\s*//g;
    $var2=~ s/\s*//g;
    $var3=~ s/\s*//g;
    #todavia no sabemos si la variable axis esta en la posicion de var1 o var2
    $axis= $1 if (defined $var1 && $var1=~ /^(?:axis=)?(-?\d+|None)$/i);
    
    #segunda parte
#asignar las funciones de manera dinamica
#esta funcion puede ser quicksort, el heapsrt, cualquier otra
my $sort_f = sub {qsort($_[0])} if defined $kind && $kind =~ /quicksort/i;
   $sort_f = sub {merge_sort($_[0])} if defined $kind && $kind =~ /mergesort/i;
   $sort_f = sub {max_heap($_[0])} if defined $kind && $kind =~ /heapsort/i;
   #para funciones de comparacion
   #numerica <,>,<=,>=
   #para string la comparacion es diferente
   #cmp para comparar string, el cmp nos devuelve
   #x1 cmp x2 : nos devuelve - cuando es menor
   # o devuelve 0 cuando es igual
   # devuelve 1 cuando es mayor

   #recursion tercera parte
   
   
}
sub qsort{
    
}
sub merge_sort{
    
}

#probando la funcion
print dump(a_sort([1,4,3,2], 'kind=quicksort', 'axis=0')),"\n";





