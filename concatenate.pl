use strict;
use warnings;

    my @a_arr=([8,4,1],[3,1,9],[8,15,1]);
    print ("\nArreglo A\n");
    #Se imprime el arreglo A
    map {map{print $_, "\t"}@{$_}; print"\n"}@a_arr;
    my @b_arr=([0,0,1],[1,1,0]);
    print ("\nArreglo B\n");
    #Se imprime el arreglo B
    map {map{print $_, "\t"}@{$_}; print"\n"}@b_arr;
    # inicializo $num_elem
    my $num_elem =0;
    # Obtengo el escalar de los dos arreglos 
    $num_elem = scalar(@a_arr) + scalar(@b_arr);
    #Inicializo el arreglo @con_arr
    my @con_arr =();
    #Copio todos los elementos de mi 1er arreglo en con_arr 
    for(my $i=0; $i<scalar(@a_arr); $i++){
        $con_arr[$i]=$a_arr[$i];
    }
    #Copio todos los elementos de mi 2do arreglo en con:arr
    for(my $i=scalar(@a_arr); $i<$num_elem; $i++){
        $con_arr[$i]=$b_arr[$i-scalar(@a_arr)];
    }
    #Se imprime todos los elemento ya concatenados en forma Horizontal
    print ("\nArreglo Concatenado 1\n\n");
    map {map{print $_, "\t"}@{$_};}@con_arr;
    #Se imprime todos los elemento ya concatenados en forma Vertical
    print ("\n\nArreglo Concatenado 2\n\n");
    map {map{print $_, "\t"}@{$_}; print"\n"}@con_arr;