



sudo docker run --rm \
  -v $(pwd):/data \
  systemsgenetics/actg-wgaa-jellyfish:2.3.1 \
  jellyfish count --help

  
sudo docker run --rm \
  -v $(pwd):/data \
  systemsgenetics/actg-wgaa-jellyfish:2.3.1 bash -c \
  'zcat /data/test_data/*fastq.gz | jellyfish count -m 21 -s 100M -t 10 -C -o /data/test_data/C6368_1.jf' 

sudo docker run --rm \
  -v $(pwd):/data \
  systemsgenetics/actg-wgaa-jellyfish:2.3.1 \
  jellyfish dump -c /data/test_data/C6368_1.jf -o /data/test_data/C6368_1.txt


sudo docker run --rm \
  -v $(pwd):/data \
  systemsgenetics/actg-wgaa-jellyfish:2.3.1 \
  jellyfish count -m 21 -s 3G --bf-size 100G -t 8 -C /data/test_data/C6368_1.filt_cut1e6.fastq -o /data/test_data/C6368_1b.jf


  sudo /usr/local/bin/nextflow run main.nf -c config/test.config 