<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 사용자를 내가 만든 컨트롤러의 로그인 주소로 리다이렉트 시킵니다.
    // request.getContextPath()는 "/프로젝트명"을 의미합니다.
    response.sendRedirect(request.getContextPath() + "/member/");
%>