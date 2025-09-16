

workflow {
    ch_rawfastq = Channel.fromFilePairs(params.raw_fastq)
     .view{"FilePairs input: $it"}

    if(params.do_jellyfish) {
        ch_jellyfish = jellyfish_count(ch_rawfastq)
    }

}