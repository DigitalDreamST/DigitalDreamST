from flask import Flask, request

app = Flask(__name__)

@app.route('/process', methods=['POST'])
def process_request():
    data = request.data.decode('utf-8')
    
    # 클라이언트로부터 전송된 데이터를 확인하고 처리합니다.
    if data == '1':
        response = '2'
    else:
        response = '유효하지 않은 입력입니다.'

    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
