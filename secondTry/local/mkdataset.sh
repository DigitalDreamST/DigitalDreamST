#!/bin/bash

. ./path.sh

datadir=$1
targetdir=$2

train_wavscp=$datadir/train.wav.scp
train_text=$datadir/train.text
valid_wavscp=$datadir/valid.wav.scp
valid_text=$datadir/valid.text

# 출력폴더 생성
mkdir -p ${targetdir}/train
mkdir -p ${targetdir}/dev
mkdir -p ${targetdir}/valid

# 평가데이터 개수 확인
numeval=$(cat $valid_wavscp | wc -l)

# dev set 구성
# AIHUB의 Training 데이터에서  dev/wav.scp 생성
shuf $train_wavscp | head -$numeval | sort > ${targetdir}/dev/wav.scp
filter_scp.pl -f 1 ${targetdir}/dev/wav.scp $train_text | sort > ${targetdir}/dev/text

# train set 구성
# AIHUB의 Training 데이터에서 학습용 dev/wav.scp 의 ID를 제외한 후 dev/wav.scp, dev/text 생성
filter_scp.pl --exclude -f 1 ${targetdir}/dev/wav.scp $train_wavscp | sort > ${targetdir}/train/wav.scp
filter_scp.pl --exclude -f 1 ${targetdir}/dev/wav.scp $train_text | sort > ${targetdir}/train/text

# valid  set 구성
# AIHUB의 Validation 데이터로 구성
sort $valid_wavscp > ${targetdir}/valid/wav.scp
sort $valid_text > ${targetdir}/valid/text

# 각 set 에 utt2spk, spk2utt 생성 (espnet 기본 형식 따르기 위한 용도)
for set in train dev valid; do
        paste -d" " <(cut -d" " -f 1 ${targetdir}/$set/wav.scp) <(cut -d" " -f 1 ${targetdir}/$set/wav.scp) > ${targetdir}/${set}/utt2spk
        cp ${targetdir}/${set}/utt2spk ${targetdir}/${set}/spk2utt
done
