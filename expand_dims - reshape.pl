use strict;
use warnings;
use Clone qw(clone);#cpan Clone
use Data::Dump qw(dump);
sub expand_dims{    
    my ($input_arr_ref, ) = @_; 
    my @input_arr_shape = shape([@{$input_arr_ref}]);
    my @input_arr = @{$input_arr_ref};    
    shift @_;
    if (scalar(@_)>0) {
        while (@_) {
           expan2(\@input_arr_shape, $_[0]);
           shift @_;
        }        
    }else{
     expan2(\@input_arr_shape, $_[0]);
    }
    sub expan2{
     my ($input_arr_shape, $axis_ref1) = @_;
     my @input_arr_shape1 = @{$input_arr_shape};
     #p_array(@input_arr_shape1);
     if ($axis_ref1 <= scalar (@{$input_arr_shape})){# si axis es un escalar y es menor o igual que el numero de dimensiones
       if ($axis_ref1 == 0){#Aumenta una dimension en la primera posision 
           unshift (@input_arr_shape1, 1);
       } elsif ($axis_ref1 == scalar(@input_arr_shape1)){#Aumenta una dimension en la útltima posicion 
           push(@input_arr_shape1, 1);
       }else {#Aumenta una dimension intermedia
          unshift (@input_arr_shape1, 1);#Añado un elemento al arreglo
          for(my $i =0; $i < @input_arr_shape1; $i++){
            $input_arr_shape1[$i] = $i < $axis_ref1 ? $input_arr_shape1[$i+1]: $i == $axis_ref1 ? 1 : $input_arr_shape1[$i] ;
            #$input_arr_shape1[$axis_ref1] = 1;
          }
       }
       @{$input_arr_shape} = @input_arr_shape1;
       p_array(@{$input_arr_shape});
     }
    }
    reshape(\@input_arr, 2,3);
 }

sub reshape{
my $num_elem = @_;
my $shapei_str =pop @_;
my $shapej_str =pop @_;
my ($bidim_arr_ref) = @_;
my @bidim_arr = @{$bidim_arr_ref};
if ($num_elem == 0) {
print "\nTypeError: reshape() missing required argument 'shape' (pos 1)\n";
}elsif ($num_elem == 1){
print "\nTypeError: reshape() missing required argument 'shape' (pos 2)\n";
}elsif($num_elem == 3 && $shapei_str*$shapej_str==@bidim_arr){
my @res = ();
my $cont = 0;
for (my $i=0 ; $i<$shapej_str ; $i++){
for (my $j=0 ; $j<$shapei_str ; $j++){
$res[$i][$j]=$bidim_arr[$cont];
$cont = $cont+1;
}
}
print "\nRESULTADO\n";
map {map{print $_, "\t"}@{$_}; print"\n"}@res;
}else{
print "\nTypeError: reshape() unspected error\n";
}
}

my @arr3 = (0,1,2,3,4,5);
my @shap = expand_dims(\@arr3, (0,1));
