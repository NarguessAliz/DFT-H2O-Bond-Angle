#!/bin/bash



for y in `seq 0.0584 0.1 0.8584`
do
x in 0.9566190464338457 0.9452195512154835 0.9229084461635402 0.8888644441083241 0.8416650165000326 0.7789223324568375 0.6964481315934447 0.5859692824713596 0.42623936936890294

cat << EOF > $y.in


&CONTROL
  calculation  = "scf",
  prefix       = "H2O",
  pseudo_dir   = "/Users/narguess/dft/if/h2o",
  outdir       = "tmp",
  forc_conv_thr= 1.0D-6,
/
&SYSTEM
  ibrav     = 1,
  a         = 10,
  nat       = 3,
  ntyp      = 2,
  ecutwfc   = 25,
/
&ELECTRONS
  conv_thr    = 1.D-7,
/
ATOMIC_SPECIES
O  16.00 O.pbe-n-kjpaw_psl.1.0.0.UPF  
H  1.00  H.pbe-kjpaw_psl.1.0.0.UPF  
ATOMIC_POSITIONS {angstrom}
O   0.00   0.00   0.00  
H   $x     $y     0.00  
H  -$x     $y     0.00  
K_POINTS{automatic}   
10 10 10 0 0 0 


EOF

pw.x <$y.in> $y.out

echo ${y} "," `cat $y.out|grep !| cut -d = -f 2 | cut -d R -f 1` >> h2o.data 

done
