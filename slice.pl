use strict;
use warnings;
use Clone qw(clone);#cpan Clone
use Data::Dump qw(dump);

#Consideraciones iniciales para el desarrollo de la función slice()
my @z_arr = ([0,1,2,3,4]);
my @slice_arr = ();

@slice_arr = slice(@z_arr, "0:2");

# NOTA: PARA COMPROBAR EL CODIGO CON UN ARREGLO DIBIMENSIONAL SE DEBE USAR LA FUNCIÓN 

@z_arr = ([[ 0,  1,  2,  3], [10, 11, 12, 13], [20, 21, 22, 23], [30, 31, 32, 33], [40, 41, 42, 43]]);

@slice_arr = slice_bidim(@z_arr,"3:-1");

=pod

@slice_arr = slice(@z_arr, "0:2");#Returns ([0,1])

@slice_arr = slice(@z_arr, "2:4");#Returns ([2, 3])

@slice_arr = slice(@z_arr, "0:4:2");#Returns ([0, 2])

@slice_arr = slice(@z_arr, "1:4:2");#Returns ([1, 3])

@slice_arr = slice(@z_arr, "1:");#Returns ([1, 2, 3])

@slice_arr = slice(@z_arr, ":3");#Returns ([0, 1, 2])

@slice_arr = slice(@z_arr, "1:3");#Returns ([1, 2])

@slice_arr = slice(@z_arr, "1:3:");#Returns ([1, 2])

@slice_arr = slice(@z_arr, "::2");#Returns ([0, 2])

@slice_arr = slice(@z_arr, "::");#Returns ([0, 1, 2, 3])

@slice_arr = slice(@z_arr, ":");#Returns ([0, 1, 2, 3])

#Negative step argument can be used to reverse the sequence:
@slice_arr = slice(@z_arr, "-4");#Returns 0

@slice_arr = slice(@z_arr, ":-2");#Returns ([0, 1])

@slice_arr = slice(@z_arr, "::-1");#Returns ([3, 2, 1, 0])

#Slices can be used to replace multiple items
@slice_arr = slice(@z_arr, ":2", [11, 22]);#Returns ([11, 22,  2,  3])

# from start to position 3, exclusive, set every 2nd element to 1000

@slice_arr = slice(@z_arr, ":3:2", 1000);#Returns ([1000, 1, 1000, 3])

=cut

#Bidimensional case:

#@z_arr = ([[ 0,  1,  2,  3], [10, 11, 12, 13], [20, 21, 22, 23], [30, 31, 32, 33], [40, 41, 42, 43]]);

#@slice_arr = slice_bidim(@z_arr,"3:-1");

=pod
@slice_arr = slice(@z_arr, "2,3");#Returns 23

@slice_arr = slice(@z_arr, "3:");#Returns ([[30, 31, 32, 33],[40, 41, 42, 43]])
@slice_arr = slice(@z_arr, "3:5");#Equivalent to the previous example

@slice_arr = slice(@z_arr, "3:4");#Returns ([[30, 31, 32, 33]])
@slice_arr = slice(@z_arr, "3:-1");#Equivalent to the previous example because -1  > -5 and −1 mod 5 == 4

@slice_arr = slice(@z_arr, "2:3");#Returns ([[20, 21, 22, 23]])
@slice_arr = slice(@z_arr, "2:-2");#Equivalent to the previous example because -2  > -5 and −2 mod 5 == 3

@slice_arr = slice(@z_arr, ":1");#Returns ([[0, 1, 2, 3]])
@slice_arr = slice(@z_arr, ":-4");#Equivalent to the previous example because -4  > -5 and −4 mod 5 == 1

@slice_arr = slice(@z_arr, ":2");#Returns ([[ 0,  1,  2,  3], [10, 11, 12, 13]])
@slice_arr = slice(@z_arr, ":-3");#Equivalent to the previous example because -3  > -5 and −3 mod 5 == 2

@slice_arr = slice(@z_arr, ":-5");#Returns array([], shape=(5 4)) because <= -5 is out of range


#Multidimensional arrays can have one index per axis. These indices are given in a tuple separated by commas:
@slice_arr = slice(@z_arr, "0:5,1");#Returns ([ 1, 11, 21, 31, 41]) Each row in the second column of @z_arr
@slice_arr = slice(@z_arr, ":5,1");#Equivalent to the previous example. Zero is default to start.
@slice_arr = slice(@z_arr, ":,1");#Equivalent to the previous example. len(@arr) is default to stop.

@slice_arr = slice(@z_arr, "0:5,0");#Returns ([ 0, 10, 20, 30, 40]). 5 first numbers from column 0
@slice_arr = slice(@z_arr, "0:5,2");#Returns ([ 2, 12, 22, 32, 42]). 5 first numbers from column 2

@slice_arr = slice(@z_arr, "0:4,0");#Returns ([ 0, 10, 20, 30]). 4 first numbers from column 0
@slice_arr = slice(@z_arr, "0:4,2");#Returns ([ 2, 12, 22, 32]). 4 first numbers from column 2

#When fewer indices are provided than the number of axes, the missing indices are considered as complete slices:
@slice_arr = slice(@z_arr, "-1");#Returns ([40, 41, 42, 43]) which is the last row.
@slice_arr = slice(@z_arr, "-1,:");#Equivalent to the previous example because a number after the coma is missing.

#Each column in the second and third rows of @z_arr
@slice_arr = slice(@z_arr, "1:3:");#Returns ([[10, 11, 12, 13], [20, 21, 22, 23]])
@slice_arr = slice(@z_arr, "1:3,:");#Equivalent to the previous example because a number after the coma is missing.

@slice_arr = slice(@z_arr, "1");#Returns ([10, 11, 12, 13])
@slice_arr = slice(@z_arr, "1:");#Returns ([[10, 11, 12, 13],[20, 21, 22, 23],[30, 31, 32, 33],[40, 41, 42, 43]])
@slice_arr = slice(@z_arr, "1:,1");#Returns ([11, 21, 31, 41])

@slice_arr = slice(@z_arr, "1,::2");#Returns ([10, 12])
@slice_arr = slice(@z_arr, "2,::2");#Returns ([20, 22])
@slice_arr = slice(@z_arr, "2,:2:2");#Returns ([20])

@slice_arr = slice(@z_arr, "3::1");#Returns ([[30, 31, 32, 33],[40, 41, 42, 43]])
@slice_arr = slice(@z_arr, "3::2");#Returns ([[30, 31, 32, 33]])
@slice_arr = slice(@z_arr, "3::3");#Equivalent to the previous example because next step goes beyond

@slice_arr = slice(@z_arr, "3::1,0");#Returns ([30, 40])
@slice_arr = slice(@z_arr, "3::1,1");#Returns ([31, 41])
@slice_arr = slice(@z_arr, "3::1,2");#Returns ([32, 42])

#Elabore pruebas para más dimensiones.
@z_arr = ([[[0,1],[2,3],[4,5]], [[6,7],[8,9],[10,11]]]);
#...
=cut

sub slice{
  my @res = ();
  my ($input_arr_ref, $conditions, $replace_arr_ref) = @_;
  my @input_arr = [@{$input_arr_ref}];
  my @replace_arr = ();
  if (ref $replace_arr_ref eq "ARRAY"){
    @replace_arr = [@{$replace_arr_ref}];
  }elsif(defined $replace_arr_ref && $replace_arr_ref =~ /\d+/){#Scalar
    @replace_arr = [$replace_arr_ref];
  }
  print "conditions=$conditions\n";
  
  #Validating input parameters
  if (ref \@input_arr ne "ARRAY"){#defined reftype(\@input_arr) && 
    print STDERR "Input array must be specified.\n";
    return [];
  }elsif(!defined $conditions || $conditions =~ /^\s*$/){
    print STDERR "Slice conditions must be specified.\n";
    return [];
  }elsif ($conditions !~ /^\s*([^\n:]*)?\s*(:)?\s*([^\n:]*)?\s*(:)?\s*([^\n:]*)?\s*$/){
    print STDERR "Slice conditions \'$conditions\' do not match its pattern.\n";
    return [];
  }
  
  #Parsing input parameters
  my $len_input_arr = scalar(@{$input_arr[0]});
  my $start = defined $1 && $1 ne "" ? $1 : 0;
  my $stop_left_colon = defined $2 && $2 eq ":" ? ":" : undef;
  my $stop  = defined $3 && $3 ne "" ? $3 : $len_input_arr;
  my $step_left_colon = defined $4 && $4 eq ":" ? ":" : undef;
  my $step  = defined $4 && defined $5 && $5 ne "" ? $5 : 1;
  my $num_comas_start = () = ($start =~ /,/g);
  my $num_comas_stop = () = ($stop =~ /,/g);
  my $num_comas_step = () = ($step =~ /,/g);
  my $num_dims_parametrized = $num_comas_start + $num_comas_stop + $num_comas_step + 1;
  my @input_arr_shape = shape(@input_arr);
  my $num_dims_input_arr = scalar(@input_arr_shape);
  $start =~ s/\s*//g;#Removing unnecesary whitespaces from start
  $stop =~ s/\s*//g;#Removing unnecesary whitespaces from stop
  $step =~ s/\s*//g;#Removing unnecesary whitespaces from step
  
  #Validating conditions:
  if ($num_dims_parametrized > $num_dims_input_arr){
    print STDERR "IndexError: too many indices for array: array is $num_dims_input_arr-dimensional, but $num_dims_parametrized were indexed.\n";
    return [];
  }#... Complete with the remaining required validations.
  
  #Revising one axis parameters ranges.
  if($start =~ /^-\d+$/ && $start < 0 && $start < -1 * $len_input_arr){#Out of range
    p ("array([], shape=(", [@input_arr_shape], "))");
    return [];
  }elsif($start =~ /^-\d+$/ && $start < 0 && $start >= -1 * $len_input_arr){
    $start = $start % $len_input_arr;
  }

  if ($stop =~ /^\d+$/ && $stop > $len_input_arr){
    $stop = $len_input_arr;
  }elsif($stop =~ /^-\d+$/ && $stop < 0 && $stop <= -1 * $len_input_arr){#Out of range
    p ("array([], shape=(", [@input_arr_shape], "))");
    return [];
  }elsif($stop =~ /^-\d+$/ && $stop < 0 && $stop > -1 * $len_input_arr){
    $stop = $stop % $len_input_arr;
  }
  if ($step =~ /^-?\d+$/ && $step < 0){
    print "Negative step=$step\n";
    ($start, $stop) = ($stop-1, $start-1);#Swapping values to reverse order
  }
  
  if (!defined $stop_left_colon){
    $stop = $start + 1;
  }
    
  if ($num_dims_input_arr == 1){
    print "Your unidimensional array code goes here.\n";
    p("Array=", @input_arr);
    p("Shape=", @input_arr_shape);
    print "start=$start", "\t", "stop=$stop", "\t", "step=$step", "\n";
    
    my @output_arr = ();
    
    if (!@replace_arr){#ref \@replace_arr ne "ARRAY" || (scalar(@replace_arr) == 1 && ref \@replace_arr eq "ARRAY" && ref \@{$replace_arr[0]} ne "ARRAY"
      if ($step > 0){
        for (my $i=$start; $i < $stop; $i+=$step){
          push @output_arr, $input_arr[0][$i];
        }
      }elsif($step < 0){
        for (my $i=$start; $i > $stop; $i+=$step){
          push @output_arr, $input_arr[0][$i];
        }
      }
      #Encapsulate:
      if (defined $stop_left_colon){
        @output_arr = [@output_arr];
      }
      @res = p("output_arr=", @output_arr);
      #print "\nres res\n";
      #map{print $_, "\t"}@res;
    }else{#Replaces directly in the input array.
      my $len_replacement_arr = scalar(@{$replace_arr[0]});
      my $dimension = $stop - $start;
      if ($len_replacement_arr == $dimension){
        for (my ($i, $j)=($start, 0); $i < $stop; $i+=$step, $j+=$step){
          $input_arr[0][$i] = $replace_arr[0][$j];
          print "";
        }
        p("Modified input_arr=", @input_arr);
      }elsif($len_replacement_arr == 1){
        for (my $i=$start; $i < $stop; $i+=$step){
          $input_arr[0][$i] = $replace_arr[0][0];
          print "";
        }
        p("Modified input_arr=", @input_arr);
      }else{
        print STDERR "ValueError: cannot copy sequence with size $len_replacement_arr to array axis with dimension $dimension\n";
      }
    }
    print "\n";
  }
  
  #Revise multiple axis parameters ranges separated by coma
  #...
  
  if ($num_dims_input_arr > 1){
    print "Your multidimensional array code goes here.\n";
    p("Array=", @input_arr);
    p("Shape=", @input_arr_shape);
    print "start=$start", "\t", "stop=$stop", "\t", "step=$step", "\n\n";
     
    my @start_params_arr = split /,/, $start;
    my @stop_params_arr = split /,/, $stop;
    my @step_params_arr = split /,/, $step;
    print "";
  }
  print "";
  return @res;
}

sub shape{
  #Vamos a crear una función interna shape2 para recibir separadamente dos argumentos:
  #la referencia al arreglo de entrada y la referencia al arreglo output de la recursión.
  #Los tamaños de cada eje son almacenadas recursivamente en el arreglo output de la recursión.
  
  return shape2(\@_, []);#Dos argumentos: Referencia al arreglo de entrada y la referencia a un arreglo vacío.
  
  sub shape2{
    my ($input_arr_ref, $output_arr_ref) = @_;

    my $last_input_arr_ref = @{$input_arr_ref}[-1];#Del arreglo de entrada, se obtiene una referencia al último elemento que puede ser un arreglo interno o finalmente un escalar.
    my @aux_input_arr = ref $last_input_arr_ref eq "ARRAY" ? @{$last_input_arr_ref} : ();#Arreglo auxiliar desarma el arreglo externo [].
    if (@aux_input_arr || scalar(@{$input_arr_ref}) == 1 && ref \@{$input_arr_ref} eq "ARRAY" && ref @{$input_arr_ref}[0] eq "ARRAY"){
      push @{$output_arr_ref}, scalar(@aux_input_arr);
    }
    
    if (!@aux_input_arr){#Arreglo auxiliar vacío.
      return @{$output_arr_ref};
    }else{
      shape2(\@aux_input_arr, $output_arr_ref);
    }
  }
}

sub p{#prints scalars iteratively and arrays recursively.
  my $padding = 0;
  my @res = ();
  while (@_){#Handles the printing of the input parameters depending on their type: an array or a scalar.
    if (ref $_[0] eq "ARRAY"){#The first parameter $_[0] is an array
      @res = p2([$_[0]], $padding);
    }else{
      print $_[0];
      $padding = $_[0] =~ /\n$/ ? 0 : $padding + length($_[0]);#Padding restarts if line break is at the end of string $_[0]
    }
    shift @_;#Removes the first parameter $_[0] from the beginning of the array @_
  }
  
  sub p2{
    
    my @res=();
    my $cont = 0;
    
    my ($input_arr_ref, $padding) = @_;
    my @input_arr = @{$input_arr_ref};
    for (my $i=0; $i < @input_arr; $i++) {
      my $axis_ref = $input_arr[$i];#Gets rid of external [] and obtains a reference to the input array's current axis
      if (ref $axis_ref eq "ARRAY"){
        print "[";
        $padding++;
        @res = p2($axis_ref, $padding);#The internal axis are obtained recursively
        print "]";
        $padding--;
        print ",\n", " " x $padding unless $i == $#input_arr;
      }else{
        print $i == $#input_arr ? $axis_ref : ($axis_ref, ",\t");
        $res[$cont] = $axis_ref;
        $cont = $cont+1;
      }
    }
    #print "\nres p2\n";
    #map {print $_, "\t"}@res;
    return @res;
  }
  #print "\nres p\n";
  #map {print $_, "\t"}@res
  print "\n";
  return @res;
}

sub slice_bidim{
    #Se obtiene el numero de parametros de entrada
    my $num_elem = @_;
    
    #Si no tiene parametros se envia un mensaje de error
    if ($num_elem == 0) {
        print STDERR "\nTypeError: slice_bidim() missing required argument 'shape' (pos 1)\n";
        
    #Si tiene un solo elemento se envia un mensaje de error
    #necesita al menos de dos parametros
    }elsif ($num_elem == 1){
        print STDERR "\nTypeError: slice_bidim() missing required argument 'shape' (pos 2)\n";
    
    #Caso en el que se envian dos parametros
    } elsif($num_elem == 2){
        #Se obtiene el segundo paramtero que son las condiciones
        my $condiciones_str = pop @_;
        
        #Se obtiene la referencia del arrelo bidimencional y se lo desreferencia
        my ($bidim_arr_ref) = @_;
        my @bidim_arr = @{$bidim_arr_ref};
        
        print "ARREGLO ORIGINAL\n";
        map {map{print $_, "\t"}@{$_}; print"\n"}@bidim_arr;
        
        #Se crea un arreglo que almacenara los indices
        #print "\nindices\n";
        my @indices_arr = ();
        
        #Se llena ese arreglo con los indices de la dimencion en Y
        map{$indices_arr[$_]=$_, "\t"}0..$#bidim_arr;
        
        #print "\n";
        #map{print $_,"\t"}@indices_arr;
        
        #print "\n";
        
        print "\n\nLLAMADA A LA FUNCIÓN SLICE UNIDIMENCIONAL\n";
        #Se utliza el arreglo con los indices y se llama a la función slidce de una dimension
        #Adicionalmente se envian los parametros 
        my @resultado_slice = ();
        @resultado_slice = slice(\@indices_arr,$condiciones_str);
        
        
        #print "\nResultado slice\n";
        #map{print $_,"\t"}@resultado_slice;
        

        my @aux_res_arr = ();
        
        for (my $i=0 ; $i<@bidim_arr ; $i++){
            for (my $j=0 ; $j<@{$bidim_arr[$i]} ; $j++){
                for(my $k=0 ; $k<@resultado_slice; $k++){
                    if ($i==$resultado_slice[$k]) {
                        $aux_res_arr[$k][$j]=$bidim_arr[$i][$j];
                    }
                }
            }
        }
        
        print "\nresultado final\n";
        map {map{print $_, "\t"}@{$_}; print"\n"}@aux_res_arr;
       
    }
}


