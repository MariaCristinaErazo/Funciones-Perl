use strict;
use warnings;

my @test_arr=([8,4,1],[3,1,9],[8,15,1]);
print "Arreglo original\n";
#Se imprime el arreglo original
map {map{print $_, "\t"}@{$_}; print"\n"}@test_arr;

my @resultado_arr = f_sort(\@test_arr,1,'quicksort');
print "\nArreglo ordenado\n";
#Se imprime el arreglo ordenado
map {map{print $_, "\t"}@{$_}; print"\n"}@resultado_arr;
#map {print $_,"\t"}@resultado_arr;

sub f_sort{
    if (!@_) { # comprobamos que existan elementos dentro de la llamada de la función
        print "TypeError: f_sort() missing required argument 'shape' (pos 1)\n";
    }else{
        my $num_elem = @_; # Extraemos el número de parametros que se estan enviando a la función
        
        #Caso cuando existe solo un elemento
        if ($num_elem == 1) {
            #Se obtiene el arreglo y se desreferencia
            my ($bidim_arr_ref) = @_;
            my @bidim_arr = @{$bidim_arr_ref};
            #Existe un tipo de ordenamiento que se usará varias veces VER FUNCIÓN (DEFAULT_SORT)
            my @resultado_arr = defaults_sort(\@bidim_arr);
            return @resultado_arr;
        }elsif ($num_elem == 2) {
            #Se extrae el segundo parametro y se lo almacena
            my $axisOrMethod =pop @_;
            #Se conserva unicamente el primer parametro (el arrglo)
            my ($bidim_arr_ref) = @_;
            my @bidim_arr = @{$bidim_arr_ref};
            
            #Se comprueba si el segundo parametro corresponde:
            
            #Si el 2do parametro corresponde -> un eje nulo "Axis = None"
            if ($axisOrMethod eq "None") {
                #Se crea una variable auxiliar que contendra todos los elementos del arreglo
                #Este nuevo arrelgo sera unidimencional
                my @aux2_arr=();
                #Se recorre el arreglo
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento al arreglo @aux2_arr
                        push(@aux2_arr,$bidim_arr[$i][$j]);
                    }
                }
                #Se ordena por defecto con quicksort
                qsort(\@aux2_arr);
                return @aux2_arr;
                
                
            #Si el 2do parametro corresponde -> un metodo de ordenamiento quicksort
            } elsif ($axisOrMethod eq "quicksort"){
                defaults_sort(\@bidim_arr);
                
            #Si el 2do parametro corresponde -> un metodo de ordenamiento heapsort
            } elsif ($axisOrMethod eq "heapsort"){
                #Se recorre el arreglo 
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    #Se crea una variable auxiliar que contendra temporalmente
                    #las filas de las que esta compuesta el arreglo
                    my @aux2_arr=();
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento de las filas al arreglo @aux2_arr
                        push(@aux2_arr,$bidim_arr[$i][$j]);
                    }
                    #Se ordena por defecto con quicksort
                    max_heap(@aux2_arr);
                    for (my $k=0 ; $k< @{$bidim_arr[$i]} ; $k++){
                        #Se introducen las filas ordenadas al arreglo original
                        $bidim_arr[$i][$k]=$aux2_arr[$k];
                    }
                }
                return @bidim_arr;
                
            #Si el 2do parametro corresponde -> un metodo de ordenamiento mergesort
            } elsif ($axisOrMethod eq "mergesort"){
                #Se recorre el arreglo 
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    #Se crea una variable auxiliar que contendra temporalmente
                    #las filas de las que esta compuesta el arreglo
                    my @aux2_arr=();
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento de las filas al arreglo @aux2_arr
                        push(@aux2_arr,$bidim_arr[$i][$j]);
                    }
                    #Se ordena por defecto con quicksort
                    merge_sort(\@aux2_arr);
                    for (my $k=0 ; $k< @{$bidim_arr[$i]} ; $k++){
                        #Se introducen las filas ordenadas al arreglo original
                        $bidim_arr[$i][$k]=$aux2_arr[$k];
                    }
                }
                return @bidim_arr;
                
                
            #Si el 2do parametro corresponde -> el eje X
            } elsif ($axisOrMethod == 0){
                #Se recorre el arreglo
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    #Se extrae cada una de las columnas usando la función map
                    #y se las almacena en un arrelo @aux2_arr
                    my @aux2_arr=map $_->[$i],@bidim_arr;
                    #Se ordena al arreglo que contiene los elementos de las columnas
                    qsort(\@aux2_arr);
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento al arreglo @aux2_arr al arreglo original
                        $bidim_arr[$j][$i]=$aux2_arr[$j];
                        #Para que el orden se mantenga se invirtieron los indices J % I
                    }
                }
                return  @bidim_arr;
                
            #Si el 2do parametro corresponde -> el eje Y  
            } elsif ($axisOrMethod == 1){
                defaults_sort(\@bidim_arr);
                
            #Si el 2do parametro no corresponde 
            } else  {
                print "TypeError: f_sort() munknown argument (pos 2)\n";
            }
            
        } elsif ($num_elem == 3) {
            #Se extrae el tercer parametro y se lo almacena
            my $method =pop @_;
            #Se extrae el segundo parametro y se lo almacena
            my $axis =pop @_;
            #Se conserva unicamente el primer parametro (el arrglo)
            my ($bidim_arr_ref) = @_;
            my @bidim_arr = @{$bidim_arr_ref};
            #Se comprueba que metodo de ordenación se quiere usar
            
            #Si el 2do parametro corresponde -> un metodo de ordenamiento quicksort
            if ($method eq "quicksort") {

                if ($axis eq "None") {
                #Se crea una variable auxiliar que contendra todos los elementos del arreglo
                #Este nuevo arrelgo sera unidimencional
                my @aux2_arr=();
                #Se recorre el arreglo
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento al arreglo @aux2_arr
                        push(@aux2_arr,$bidim_arr[$i][$j]);
                    }
                }
                #Se ordena por defecto con quicksort
                qsort(\@aux2_arr);
                return @aux2_arr;
                
                
                #Si el 2do parametro corresponde -> el eje X
                } elsif ($axis == 0){
                    #Se recorre el arreglo
                    for (my $i=0 ; $i<@bidim_arr ; $i++){
                        #Se extrae cada una de las columnas usando la función map
                        #y se las almacena en un arrelo @aux2_arr
                        my @aux2_arr=map $_->[$i],@bidim_arr;
                        #Se ordena al arreglo que contiene los elementos de las columnas
                        qsort(\@aux2_arr);
                        for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                            #Se envian los elemento al arreglo @aux2_arr al arreglo original
                            $bidim_arr[$j][$i]=$aux2_arr[$j];
                            #Para que el orden se mantenga se invirtieron los indices J % I
                        }
                    }
                    return  @bidim_arr;
                    
                #Si el 2do parametro corresponde -> el eje Y  
                } elsif ($axis == 1){
                    defaults_sort(\@bidim_arr);
                    
                #Si el 2do parametro no corresponde 
                }else  {
                    print "TypeError: f_sort() munknown argument (pos 2)\n";
                }

            #Si el 2do parametro corresponde -> un metodo de ordenamiento mergesort
            }elsif ($method eq "mergesort"){
                
                if ($axis eq "None") {
                #Se crea una variable auxiliar que contendra todos los elementos del arreglo
                #Este nuevo arrelgo sera unidimencional
                my @aux2_arr=();
                #Se recorre el arreglo
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento al arreglo @aux2_arr
                        push(@aux2_arr,$bidim_arr[$i][$j]);
                    }
                }
                #Se ordena por defecto con quicksort
                merge_sort(\@aux2_arr);
                return @aux2_arr;
                
                
                #Si el 2do parametro corresponde -> el eje X
                } elsif ($axis == 0){
                    #Se recorre el arreglo
                    for (my $i=0 ; $i<@bidim_arr ; $i++){
                        #Se extrae cada una de las columnas usando la función map
                        #y se las almacena en un arrelo @aux2_arr
                        my @aux2_arr=map $_->[$i],@bidim_arr;
                        #Se ordena al arreglo que contiene los elementos de las columnas
                        merge_sort(\@aux2_arr);
                        for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                            #Se envian los elemento al arreglo @aux2_arr al arreglo original
                            $bidim_arr[$j][$i]=$aux2_arr[$j];
                            #Para que el orden se mantenga se invirtieron los indices J % I
                        }
                    }
                    return  @bidim_arr;
                    
                #Si el 2do parametro corresponde -> el eje Y  
                } elsif ($axis == 1){
                    for (my $i=0 ; $i<@bidim_arr ; $i++){
                        #Se crea una variable auxiliar que contendra temporalmente
                        #las filas de las que esta compuesta el arreglo
                        my @aux2_arr=();
                        for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                            #Se envian los elemento de las filas al arreglo @aux2_arr
                            push(@aux2_arr,$bidim_arr[$i][$j]);
                        }
                        #Se ordena por defecto con quicksort
                        merge_sort(\@aux2_arr);
                        for (my $k=0 ; $k< @{$bidim_arr[$i]} ; $k++){
                            #Se introducen las filas ordenadas al arreglo original
                            $bidim_arr[$i][$k]=$aux2_arr[$k];
                        }
                    }
                    return @bidim_arr;
                    
                #Si el 2do parametro no corresponde 
                }else  {
                    print "TypeError: f_sort() munknown argument (pos 2)\n";
                }
                
            #Si el 2do parametro corresponde -> un metodo de ordenamiento heapsort
            }elsif ($method eq "heapsort"){
                
                if ($axis eq "None") {
                #Se crea una variable auxiliar que contendra todos los elementos del arreglo
                #Este nuevo arrelgo sera unidimencional
                my @aux2_arr=();
                #Se recorre el arreglo
                for (my $i=0 ; $i<@bidim_arr ; $i++){
                    for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                        #Se envian los elemento al arreglo @aux2_arr
                        push(@aux2_arr,$bidim_arr[$i][$j]);
                    }
                }
                #Se ordena por defecto con quicksort
                max_heap(@aux2_arr);
                return @aux2_arr;
                
                
                #Si el 2do parametro corresponde -> el eje X
                } elsif ($axis == 0){
                    #Se recorre el arreglo
                    for (my $i=0 ; $i<@bidim_arr ; $i++){
                        #Se extrae cada una de las columnas usando la función map
                        #y se las almacena en un arrelo @aux2_arr
                        my @aux2_arr=map $_->[$i],@bidim_arr;
                        #Se ordena al arreglo que contiene los elementos de las columnas
                        max_heap(@aux2_arr);
                        for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                            #Se envian los elemento al arreglo @aux2_arr al arreglo original
                            $bidim_arr[$j][$i]=$aux2_arr[$j];
                            #Para que el orden se mantenga se invirtieron los indices J % I
                        }
                    }
                    return  @bidim_arr;
                    
                #Si el 2do parametro corresponde -> el eje Y  
                } elsif ($axis == 1){
                    for (my $i=0 ; $i<@bidim_arr ; $i++){
                        #Se crea una variable auxiliar que contendra temporalmente
                        #las filas de las que esta compuesta el arreglo
                        my @aux2_arr=();
                        for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
                            #Se envian los elemento de las filas al arreglo @aux2_arr
                            push(@aux2_arr,$bidim_arr[$i][$j]);
                        }
                        #Se ordena por defecto con quicksort
                        max_heap(@aux2_arr);
                        for (my $k=0 ; $k< @{$bidim_arr[$i]} ; $k++){
                            #Se introducen las filas ordenadas al arreglo original
                            $bidim_arr[$i][$k]=$aux2_arr[$k];
                        }
                    }
                    return @bidim_arr;
                    
                #Si el 2do parametro no corresponde 
                }else  {
                    print "TypeError: f_sort() munknown argument (pos 2)\n";
                }
                
            }else{
                print "TypeError: f_sort() munknown argument (pos 3)\n";
            }

        
        } elsif ($num_elem > 3) {
            print "TypeError: f_sort() munknown argument (pos 4)\n";
        }
    }
}

sub defaults_sort {
    my ($bidim_arr_ref) = @_;
    my @bidim_arr = @{$bidim_arr_ref};
    #Se recorre el arreglo 
    for (my $i=0 ; $i<@bidim_arr ; $i++){
        #Se crea una variable auxiliar que contendra temporalmente
        #las filas de las que esta compuesta el arreglo
        my @aux2_arr=();
        for (my $j=0 ; $j< @{$bidim_arr[$i]} ; $j++){
            #Se envian los elemento de las filas al arreglo @aux2_arr
            push(@aux2_arr,$bidim_arr[$i][$j]);
        }
        #Se ordena por defecto con quicksort
        qsort(\@aux2_arr);
        for (my $k=0 ; $k< @{$bidim_arr[$i]} ; $k++){
            #Se introducen las filas ordenadas al arreglo original
            $bidim_arr[$i][$k]=$aux2_arr[$k];
        }
    }
    return @bidim_arr;
}

sub qsort (\@) {_qsort($_[0], 0, $#{$_[0]})}

sub _qsort {
    my ($array, $low, $high) = @_;
    if ($low < $high) {
        my $mid = partition($array, $low, $high);
        _qsort($array, $low,     $mid - 1);
        _qsort($array, $mid + 1, $high   );
    }
}

sub partition {
    my ($array, $low, $high) = @_;
    my $x = $$array[$high];
    my $i = $low - 1;
    for my $j ($low .. $high - 1) {
        if ($$array[$j] <= $x) {
            $i++;
            @$array[$i, $j] = @$array[$j, $i];
        }
    }
    $i++;
    @$array[$i, $high] = @$array[$high, $i];
    return $i;
}

sub merge_sort {

    my ($arr) = @_;

    return if @$arr == 1;

    my $bound = int( @$arr / 2 );
    my @left  = @$arr[ 0 .. $bound-1 ];
    my @right = @$arr[ $bound .. $#$arr ];

    merge_sort( \@left );
    merge_sort( \@right );

    merge( \@left, \@right, $arr );
}

sub merge {

    my ($a_ref, $b_ref, $arr) = @_;

    my ($i, $j, $r) = (0, 0, 0);

    while ( $i < @$a_ref and $j < @$b_ref ) {

        if ( $a_ref->[$i] < $b_ref->[$j] ) {
            $arr->[$r++] = $a_ref->[$i++];
        }
        else {
            $arr->[$r++] = $b_ref->[$j++];
        }
    }

    $arr->[$r++] = $a_ref->[$i++] while $i < @$a_ref;
    $arr->[$r++] = $b_ref->[$j++] while $j < @$b_ref;
}
sub build_heap{
     my $length = $#_;
     for(my $i = $length>>1; $i >= 0; $i--){
          heapnify(\@_, $length, $i);
     }
}

sub heapnify{
     #~ $x++; #use it to trace how much times the procedure was run
     my ($array, $length, $index) = @_;
    
     my $max = $array->[$index];
     my $tmp = $index;
     my $left = left($index);
     my $right = right($index);
    
     if($left <= $length && $array->[$left] > $max){
          $max = $array->[$left];
          $tmp = $left;
     }
     if($right <= $length && $array->[$right] > $max){
          $max = $array->[$right];
          $tmp = $right;
     }
    
     if($tmp != $index){
          ($array->[$index], $array->[$tmp]) = ($array->[$tmp], $array->[$index]);
          heapnify($array, $length, $tmp) if $tmp <= $length>>1;
     }
}

sub left      { ($_[0]<<1) + 1 }
sub right     { left(@_) + 1 }

sub max_heap{
     build_heap(@_);
     @_[0,-1] = @_[-1,0];
     for(my $i=$#_-1;$i>0;$i--){
          heapnify(\@_,$i,0);
          @_[0,$i] = @_[$i,0];
     }
}