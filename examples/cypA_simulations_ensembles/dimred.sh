. ../set_environment.sh
ln -s ../$ENCORE_BUILD .
ln -s ../$MDANALYSIS_BUILD .

# Trajectories containing the ensembles to be compared
trajs=(traj_c22-star.xtc  traj_c36.xtc  traj_ff99sb-ildn-star.xtc)

# number of ensembles
nensembles=3

# command line
cmdline="./similarity.py --mode=dimred --superimpose --np=6 --load-matrix=minusrmsd_pw.npz --change-matrix-sign --nensembles $nensembles --topology topology.pdb --use-density=resample --dim=2 --samples=10000 --nsteps=1000000 --ncycle=100 --neighborhood-cutoff=1.5 --spe-mode=vanilla -v"

# add the --ensemble*-trajectory options (--ensemble1-trajectory traj_c22-star.xtc --ensemble2-trajectory traj_c36.xtc etc.)
for i in $(seq 0 2); do
	cmdline=$cmdline" --ensemble$((i+1))-trajectory ${trajs[$i]}"
done

# Run ENCORE
echo "Now running: $cmdline"
echo "Results will be written in file: clustering.log"
echo  $ENCORE_BUILD/similarity.py
$PYTHON encore/similarity.py $cmdline 

