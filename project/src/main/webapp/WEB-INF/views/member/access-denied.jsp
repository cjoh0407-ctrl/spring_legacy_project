<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접근 제한</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f7f6; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .error-container { text-align: center; background: white; padding: 50px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
    .error-code { font-size: 80px; font-weight: bold; color: #e74c3c; margin: 0; }
    .error-msg { font-size: 20px; color: #2c3e50; margin: 20px 0; }
    .btn-home { display: inline-block; padding: 12px 25px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; transition: 0.3s; }
    .btn-home:hover { background: #2980b9; }
</style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">403</div>
        <div class="error-msg">죄송합니다. 이 페이지에 접근할 권한이 없습니다.</div>
        <p style="color: #7f8c8d; margin-bottom: 30px;">관리자 계정으로 로그인 후 다시 시도해 주세요.</p>
        <a href="/" class="btn-home">메인으로 돌아가기</a>
    </div>
</body>
</html>