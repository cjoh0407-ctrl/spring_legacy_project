<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 1. Spring Security 태그라이브러리 추가 --%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
    /* CSS 스타일은 동일하므로 생략 (기존 스타일 그대로 유지하세요) */
    .top-navbar { background-color: #fff; border-bottom: 1px solid #dee2e6; padding: 0 40px; height: 50px; display: flex; justify-content: flex-end; align-items: center; box-shadow: 0 2px 4px rgba(0,0,0,0.03); margin-bottom: 25px; }
    .nav-menu { display: flex; align-items: center; gap: 15px; font-size: 13px; }
    .user-name { color: #888; margin-right: 5px; }
    .user-name b { color: #333; font-weight: 600; }
    .nav-link { color: #666; text-decoration: none; padding: 4px 8px; border-radius: 4px; transition: all 0.2s ease; }
    .nav-link:hover { background-color: #f1f3f5; color: #000; }
    .btn-logout { color: #aeafb0; }
    .btn-logout:hover { color: #dc3545; background-color: #fff5f5; }
</style>

<div class="top-navbar">
    <div class="nav-menu">
        <%-- 2. 로그인하지 않은 경우 (Anonymous) --%>
        <sec:authorize access="isAnonymous()">
            <a href="${pageContext.request.contextPath}/member/" class="nav-link">로그인</a>
            <a href="${pageContext.request.contextPath}/member/join" class="nav-link">회원가입</a>
        </sec:authorize>

        <%-- 3. 로그인한 경우 (Authenticated) --%>
        <sec:authorize access="isAuthenticated()">
            <div class="user-name">
                <%-- principal.username은 ID를 가져옵니다. --%>
                <b><sec:authentication property="principal.username"/></b>님
            </div>
            <a href="${pageContext.request.contextPath}/member/update" class="nav-link">내 정보 수정</a>
            <%-- 로그아웃은 시큐리티가 처리하는 경로로 설정 --%>
            <a href="${pageContext.request.contextPath}/member/logout" class="nav-link btn-logout">로그아웃</a>
        </sec:authorize>
    </div>
</div>