import socket

# 서버 설정
SERVER_HOST = '117.17.185.208'
SERVER_PORT = 12355

# 서버에 연결
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect((SERVER_HOST, SERVER_PORT))

# 사용자로부터 숫자 입력 받기
number = input("1, 2, 3, 4 중 하나의 숫자를 입력하세요: ")

# 입력된 문자열이 숫자인지 확인
if number.isdigit():
    # 서버로 숫자 전송
    client_socket.sendall(number.encode('utf-8'))

    # 서버로부터 응답 수신 및 출력
    response = client_socket.recv(1024).decode('utf-8')
    print('서버로부터의 응답:', response)
else:
    print("유효하지 않은 입력입니다. 숫자를 입력하세요.")

# 연결 종료
client_socket.close()
