OUTDIR=project
mkdir -p $OUTDIR
ghc -threaded src/HelloWorld.hs -o $OUTDIR/helloworld -odir $OUTDIR -hidir $OUTDIR