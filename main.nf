
include { jellyfishCount } from './modules/jellyfish_count.nf'

workflow {
    ch_rawfastq = Channel.fromFilePairs(params.raw_fastq)
     .view{"FilePairs input: $it"}

    if(params.jellyfishCount.do_jellyfish) {
        ch_jellyfish = jellyfishCount(params.jellyfishCount.k, ch_rawfastq)
        .view{"jellyfishCount output: $it"}
    }

}