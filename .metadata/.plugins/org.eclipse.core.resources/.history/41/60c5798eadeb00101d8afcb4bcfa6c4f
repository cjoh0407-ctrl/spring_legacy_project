<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* 헤더 전체 컨테이너: 로고가 없으므로 메뉴를 오른쪽으로 밀기 위해 flex-end 사용 */
    .top-navbar {
        background-color: #fff;
        border-bottom: 1px solid #dee2e6;
        padding: 0 40px;
        height: 50px; /* 로고가 없으니 높이를 조금 더 슬림하게 조절 */
        display: flex;
        justify-content: flex-end; /* 모든 요소를 오른쪽 끝으로 정렬 */
        align-items: center;
        box-shadow: 0 2px 4px rgba(0,0,0,0.03);
        margin-bottom: 25px;
    }

    /* 메뉴 영역 */
    .nav-menu {
        display: flex;
        align-items: center;
        gap: 15px; /* 메뉴 간 간격 */
        font-size: 13px; /* 조금 더 세련되게 작은 폰트 */
    }

    .user-name {
        color: #888;
        margin-right: 5px;
    }

    .user-name b {
        color: #333;
        font-weight: 600;
    }

    /* 링크 스타일 */
    .nav-link {
        color: #666;
        text-decoration: none;
        padding: 4px 8px;
        border-radius: 4px;
        transition: all 0.2s ease;
    }

    .nav-link:hover {
        background-color: #f1f3f5;
        color: #000;
    }

    /* 로그아웃 강조 */
    .btn-logout {
        color: #aeafb0;
    }

    .btn-logout:hover {
        color: #dc3545;
        background-color: #fff5f5;
    }
</style>

<div class="top-navbar">
    <div class="nav-menu">
        <c:choose>
            <c:when test="${empty sessionScope.member}">
                <a href="/" class="nav-link">로그인</a>
                <a href="/member/join" class="nav-link">회원가입</a>
            </c:when>
            <c:otherwise>
                <div class="user-name">
                    <b>${sessionScope.member.name}</b>님
                </div>
                <a href="/member/update" class="nav-link">내 정보 수정</a>
                <a href="/member/logout" class="nav-link btn-logout">로그아웃</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>