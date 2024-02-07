import re
import matplotlib.pyplot as plt

# 로그 파일에서 'cer' 값을 추출하는 함수
def extract_cer_from_log(log_file):
    with open(log_file, 'r') as f:
        log_content = f.read()
    
    # 정규 표현식을 사용하여 'cer' 값을 추출
    cer_values = re.findall(r'cer=([\d.]+)', log_content)
    
    return [float(cer) for cer in cer_values]

# 로그 파일 경로
log1_file = 'ksponspeech.log'
log2_file = 'ksponspeech_w_lm.log'
log3_file = 'ksponspeech_new_model.log'

# 'cer' 값을 추출
cer_values1 = extract_cer_from_log(log1_file)
# cer_values2 = extract_cer_from_log(log2_file)
cer_values3 = extract_cer_from_log(log3_file)

# 각 epoch에 대한 인덱스 생성
epochs1 = list(range(1, len(cer_values1) + 1))
# epochs2 = list(range(1, len(cer_values2) + 1))
epochs3 = list(range(1, len(cer_values3) + 1))

# 그래프 그리기
plt.plot(epochs1, cer_values1, marker='o', label='Common Line')
# plt.plot(epochs2, cer_values2, marker='x', label='Team Line1')
plt.plot(epochs3, cer_values3, marker='^', label='Team Line2')
plt.title('CER per Epoch')
plt.xlabel('Epoch')
plt.ylabel('CER')
# plt.xlim(3,13)
# plt.ylim(0,0.2)
plt.legend()
plt.grid(True)
plt.show()