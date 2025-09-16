
process jellyfishCount{
  label 'mg01_jellyfishcount'
  conda params.jellyfishCount.conda
  cpus params.resources.jellyfishCount.cpus
  memory params.resources.jellyfishCount.mem
  queue params.resources.jellyfishCount.queue 
  //array params.resources.array_size
  clusterOptions params.resources.jellyfishCount.clusterOptions
  errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
  maxRetries 10
  publishDir "$results_dir/mg01_jellyfishcount", mode: 'symlink'
  input:
  val k
  tuple(val(illumina_id), path(fastq))
  
  output:
  tuple(val(illumina_id), path('*.jf'), path('*.txt.gz'))
  
  shell:
  '''
  jellyfish count -m !{k} !{params.jellyfishCount.args} \
    -o !{illumina_id}.jf -t !{task.cpus} \
    -F 2 <(zcat !{fastq[0]}) <(zcat !{fastq[1]})

  jellyfish dump -c !{illumina_id}.jf -o !{illumina_id}.txt
  gzip !{illumina_id}.txt

  '''
}