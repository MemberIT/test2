# Added 'before' and 'after' stage
stage { 'after': }
Stage['main'] -> Stage['after']
