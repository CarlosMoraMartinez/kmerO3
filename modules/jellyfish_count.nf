
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
  val index
  val options
  tuple(val(illumina_id), path(fastq))
  
  output:
  tuple(val(illumina_id), path('*.bam'), path('*.err'))
  
  shell:
  '''
  ## bowtie2 mapping against host sequence database, keep both aligned and unaligned reads (paired-end reads)
  outname=!{illumina_id}'.bam'
  logname=!{illumina_id}'.bowtie2.err'
  bowtie2 -x !{index} --threads !{params.resources.jellyfishCount.cpus} !{options} -1 !{fastq[0]} -2 !{fastq[1]} 2> $logname | \
    samtools view -bSh - -o $outname 
  '''
}