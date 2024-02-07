#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="train"
valid_set="dev"
test_sets="valid"
asr_config="conf/tuning/train_asr_conformer8_n_fft512_hop_length256.yaml"
lm_config="conf/train_lm_transformer.yaml"
inference_config="conf/decode_asr.yaml"
nbpe=2309
token_type=char

./asr.sh \
    --lang kr \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --max_wav_duration 30 \
    --use_lm "false" \
    --use_ngram "false" \
    --asr_config "${asr_config}" \
    --inference_config "${inference_config}" \
    --nbpe "${nbpe}" \
    --lm_train_text "data/${train_set}/text" \
    --bpe_train_text "data/${train_set}/text" \
    --token_type "${token_type}" \
    --bpe_nlsyms '[unk]' "$@"
