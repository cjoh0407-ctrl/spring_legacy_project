<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* 헤더 영역 스타일 */
    .admin-header { 
        height: 60px; 
        background: white; 
        border-bottom: 1px solid #ddd; 
        display: flex; 
        align-items: center; 
        justify-content: flex-end; 
        padding: 0 30px; 
    }
    .admin-info { font-size: 14px; color: #333; }
    .admin-info b { color: #3498db; }
    
    .header-btn { 
        margin-left: 15px; 
        padding: 6px 12px; 
        font-size: 13px; 
        text-decoration: none; 
        border-radius: 4px; 
        border: 1px solid #ddd; 
        color: #666; 
        transition: 0.2s; 
    }
    .header-btn:hover { background: #f8f9fa; color: #333; }
    .logout-btn { color: #e74c3c; border-color: #fab1a0; }
    .logout-btn:hover { background: #fff5f5; }
</style>

<header class="admin-header">
    <div class="admin-info">
        관리자 <b>${sessionScope.member.name}</b>님 접속 중
    </div>
    <a href="/member/update" class="header-btn">회원정보 수정</a>
    <a href="/member/logout" class="header-btn logout-btn">로그아웃</a>
</header>