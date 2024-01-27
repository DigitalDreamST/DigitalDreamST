#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="train"
valid_set="dev"
test_sets="valid"
asr_config="conf/train_asr_e_branchformer.yaml"
lm_config="conf/train_lm_transformer.yaml"
inference_config="conf/decode_asr.yaml"
token_type=char

./asr.sh \
    --lang kr \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --max_wav_duration 30 \
    --asr_config "${asr_config}" \
    --inference_config "${inference_config}" \
    --token_type "${token_type}" \
    --use_ngram "false" \
    --use_lm "true" \
    "$@"
