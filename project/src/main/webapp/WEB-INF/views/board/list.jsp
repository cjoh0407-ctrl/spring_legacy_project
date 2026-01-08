<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
    .container { width: 1000px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    .header-area { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #333; padding-bottom: 10px; }
    h2 { margin: 0; color: #333; }
    
    /* 검색창 스타일 */
    .search-area { display: flex; justify-content: flex-end; margin-bottom: 15px; gap: 5px; }
    .search-area select, .search-area input { padding: 6px; border: 1px solid #ddd; border-radius: 4px; }
    .search-area input { width: 200px; }

    .btn-group { display: flex; gap: 10px; }
    .btn { padding: 8px 16px; text-decoration: none; border-radius: 5px; font-size: 14px; transition: 0.3s; cursor: pointer; border: none; }
    .btn-dark { background-color: #333; color: #fff; }
    
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; }
    th { background-color: #f8f9fa; color: #333; }
    .text-left { text-align: left; }
    .title-link { color: #007bff; text-decoration: none; font-weight: bold; }
    tr:hover { background-color: #f9f9f9; }
    .no-data { padding: 50px; color: #999; }

    .pagination { display: flex; justify-content: center; list-style: none; padding: 0; margin-top: 30px; gap: 5px; }
    .pagination li a { display: block; padding: 8px 12px; border: 1px solid #ddd; text-decoration: none; color: #333; border-radius: 3px; }
    .pagination li.active a { background-color: #333; color: #fff; border-color: #333; }
</style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div class="container">
    <div class="header-area">
        <h2>게시판 목록</h2>
        <div class="btn-group">
            <a href="/board/register" class="btn btn-dark">글쓰기</a>
        </div>
    </div>

    <form action="/board/list" method="get" class="search-area">
        <select name="types">
            <option value="t" ${pageList.types == 't' ? 'selected' : ''}>제목</option>
            <option value="c" ${pageList.types == 'c' ? 'selected' : ''}>내용</option>
            <option value="w" ${pageList.types == 'w' ? 'selected' : ''}>작성자</option>
            <option value="tc" ${pageList.types == 'tc' ? 'selected' : ''}>제목+내용</option>
        </select>
        <input type="text" name="keyword" value="${pageList.keyword}" placeholder="검색어를 입력하세요">
        <button type="submit" class="btn btn-dark">검색</button>
    </form>

    <table>
        <thead>
            <tr>
                <th style="width: 12%;">번호</th>
                <th style="width: 40%;">제목</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 20%;">작성일</th>
                <th style="width: 12%;">조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty pageList.boardDTOList}">
                    <c:forEach items="${pageList.boardDTOList}" var="board">
                        <tr>
                            <td>${board.seq}</td>
                            <td class="text-left">
                                <%-- 검색 정보(types, keyword)를 유지하며 이동하도록 수정 --%>
                                <a href="/board/detail?seq=${board.seq}&page=${pageList.page}&size=${pageList.size}&types=${pageList.types}&keyword=${pageList.keyword}" class="title-link">
                                    <c:out value="${board.title}" />
                                </a>
                            </td>
                            <td>${board.writer}</td>
                            <td>${board.regdateShort}</td>
                            <td>${board.hit}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="no-data">등록된 게시글이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <ul class="pagination">
        <c:if test="${pageList.prev}">
            <li>
                <a href="/board/list?page=${pageList.start - 1}&size=${pageList.size}&types=${pageList.types}&keyword=${pageList.keyword}">이전</a>
            </li>
        </c:if>

        <c:forEach items="${pageList.pageNums}" var="num">
            <li class="${pageList.page == num ? 'active' : ''}">
                <a href="/board/list?page=${num}&size=${pageList.size}&types=${pageList.types}&keyword=${pageList.keyword}">${num}</a>
            </li>
        </c:forEach>

        <c:if test="${pageList.next}">
            <li>
                <a href="/board/list?page=${pageList.end + 1}&size=${pageList.size}&types=${pageList.types}&keyword=${pageList.keyword}">다음</a>
            </li>
        </c:if>
    </ul>
</div>
</body>
</html>