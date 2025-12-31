<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f7f6; margin: 0; padding: 50px 0; display: flex; justify-content: center; }
        .join-container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 450px; }
        h2 { text-align: center; color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        
        /* 관리자 코드 입력창 - 처음엔 숨김 */
        #adminCodeGroup { display: none; background-color: #fff9e6; padding: 10px; border-radius: 5px; border: 1px dashed #ffcc00; margin-top: 10px; }
        
        .btn-submit { width: 100%; padding: 12px; background-color: #4e73df; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 20px; }
        .btn-submit:hover { background-color: #2e59d9; }
        .link-login { display: block; text-align: center; margin-top: 15px; color: #888; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>

    <div class="join-container">
        <h2>회원가입</h2>
        <form action="${pageContext.request.contextPath}/member/join" method="post" onsubmit="return validateForm()">
            
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="id" required placeholder="아이디를 입력하세요">
            </div>

            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="password" required placeholder="비밀번호를 입력하세요">
            </div>

            <div class="form-group">
                <label>이름</label>
                <input type="text" name="name" required placeholder="이름을 입력하세요">
            </div>

            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="email" required placeholder="example@mail.com">
            </div>

            <div class="form-group">
                <label>전화번호</label>
                <input type="tel" name="phone" required placeholder="010-0000-0000">
            </div>

            <div class="form-group">
                <label>회원 등급</label>
                <select name="role" id="roleSelect" onchange="toggleAdminField()">
                    <option value="USER">일반회원</option>
                    <option value="ADMIN">관리자</option>
                </select>
            </div>

            <div id="adminCodeGroup" class="form-group">
                <label style="color: #d9534f;">관리자 인증 코드</label>
                <input type="password" id="adminCode" name="adminCode" placeholder="관리자 보안 코드를 입력하세요">
            </div>

            <button type="submit" class="btn-submit">가입하기</button>
            <a href="${pageContext.request.contextPath}/" class="link-login">이미 계정이 있나요? 로그인 페이지로</a>
        </form>
    </div>

    <script>
        // 1. 관리자 선택 여부에 따라 입력창 보여주기/숨기기
        function toggleAdminField() {
            const role = document.getElementById('roleSelect').value;
            const adminGroup = document.getElementById('adminCodeGroup');
            
            if (role === 'ADMIN') {
                adminGroup.style.display = 'block';
            } else {
                adminGroup.style.display = 'none';
                document.getElementById('adminCode').value = ''; // 입력값 초기화
            }
        }

        // 2. 가입 전 간단한 유효성 검사
        function validateForm() {
            const role = document.getElementById('roleSelect').value;
            const adminCode = document.getElementById('adminCode').value;

            if (role === 'ADMIN' && adminCode === '') {
                alert('관리자 가입을 위해서는 인증 코드가 필수입니다.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>