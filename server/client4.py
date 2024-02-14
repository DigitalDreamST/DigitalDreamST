import requests

# 서버 설정
SERVER_URL = 'http://127.0.0.1:8080/process'  # 서버의 내부 IP 주소와 포트

# 데이터 전송
data_to_send = '1'  # 클라이언트에서 서버로 전송할 데이터
response = requests.post(SERVER_URL, data=data_to_send)

# 서버로부터의 응답 출력
print('서버로부터의 응답:', response.text)
