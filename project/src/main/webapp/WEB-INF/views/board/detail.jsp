<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
    /* 1. 기본 레이아웃 및 본문 스타일 */
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f7f6; margin: 0; }
    .container { width: 850px; margin: 40px auto; background: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
    
    .detail-header { border-bottom: 2px solid #333; padding-bottom: 20px; margin-bottom: 30px; }
    .detail-title { font-size: 28px; font-weight: bold; color: #222; margin-bottom: 15px; }
    
    .info-bar { display: flex; color: #888; font-size: 14px; gap: 20px; background: #f9f9f9; padding: 10px 15px; border-radius: 6px; }
    .info-bar b { color: #333; }

    .content-area { 
        margin-top: 30px; 
        min-height: 400px; 
        line-height: 1.8; 
        font-size: 16px; 
        color: #444; 
        white-space: pre-wrap; 
        border-bottom: 1px solid #eee;
        padding-bottom: 30px;
    }

    .btn-area { display: flex; justify-content: space-between; margin-top: 30px; margin-bottom: 50px; }
    .btn { padding: 10px 25px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 600; text-decoration: none; border: none; transition: 0.2s; display: inline-block; }
    
    .btn-list { background-color: #6c757d; color: white; }
    .btn-modify { background-color: #007bff; color: white; }
    .btn-delete { background-color: #dc3545; color: white; }
    .btn:hover { opacity: 0.8; }

    /* 2. 댓글 영역 스타일 */
    .reply-section-title { border-left: 5px solid #007bff; padding-left: 15px; margin-bottom: 25px; font-size: 20px; color: #333; }
    
    .reply-input-box { background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 30px; border: 1px solid #eee; }
    #replyText { width: 100%; height: 80px; padding: 12px; border-radius: 6px; border: 1px solid #ddd; resize: none; box-sizing: border-box; font-family: inherit; }

    #replyList { list-style: none; padding: 0; }
    .reply-item { background: #fff; border-bottom: 1px solid #eee; padding: 20px 10px; transition: 0.3s; }
    .reply-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
    .replyer-name { font-weight: bold; color: #333; font-size: 15px; }
    .reply-content { color: #555; font-size: 15px; line-height: 1.6; }
    
    .reply-manage-btns a { font-size: 12px; color: #999; text-decoration: none; margin-left: 10px; }
    .reply-manage-btns a:hover { color: #007bff; text-decoration: underline; }

    .edit-textarea { width: 100%; height: 70px; padding: 10px; border: 1px solid #007bff; border-radius: 6px; box-sizing: border-box; margin-bottom: 10px; }

    /* 3. 페이징 버튼 스타일 */
    .paging-btn { display: inline-block; padding: 8px 14px; margin: 0 4px; border: 1px solid #ddd; border-radius: 4px; color: #666; text-decoration: none; font-size: 13px; font-weight: 500; transition: 0.2s; }
    .paging-btn:hover { background-color: #f4f4f4; border-color: #bbb; }
    .paging-btn.active { background-color: #007bff; color: white; border-color: #007bff; }
    .paging-arrow { background-color: #f9f9f9; font-weight: bold; }
</style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="container">
    <div class="detail-header">
        <div class="detail-title">${board.title}</div>
        <div class="info-bar">
            <span>번호: <b>${board.seq}</b></span>
            <span>작성자: <b>${board.writer}</b></span>
            <span>작성일: <b>${board.regdateShort}</b></span>
            <span>조회수: <b>${board.hit}</b></span>
        </div>
    </div>

    <div class="content-area">${board.content}</div>

    <div class="btn-area">
	    <a href="/board/list?page=${page}&size=${size}&types=${types}&keyword=${keyword}" class="btn btn-list">목록으로</a>
	    
	    <div class="btn-group">
	        <c:if test="${sessionScope.member.id == board.writer}">
	            <a href="/board/modify?seq=${board.seq}&page=${page}&types=${types}&keyword=${keyword}" class="btn btn-modify">수정하기</a>
	            
	            <a href="/board/delete?seq=${board.seq}&page=${page}&types=${types}&keyword=${keyword}" 
	               class="btn btn-delete" 
	               onclick="return confirm('게시글을 정말 삭제하시겠습니까?');">삭제</a>
	        </c:if>
	    </div>
	</div>

    <div class="reply-wrapper">
        <h3 class="reply-section-title">댓글 <span id="replyCount" style="color: #007bff;">0</span></h3>
        
        <div class="reply-input-box">
            <textarea id="replyText" placeholder="댓글을 입력해주세요."></textarea>
            <div style="text-align: right; margin-top: 10px;">
                <button id="addReplyBtn" class="btn btn-modify">댓글 등록</button>
            </div>
        </div>

        <ul id="replyList"></ul>

        <div id="replyPaging" style="display: flex; justify-content: center; margin-top: 40px;"></div>
    </div>
</div>

<script>
    const bno = "${board.seq}"; 
    const loginId = "${sessionScope.member.id}"; 
    
    // 현재 페이지 번호를 기억하기 위한 변수 (값이 변하므로 let 사용)
    let currentPage = 1; 
	
    document.addEventListener("DOMContentLoaded", function() {
        printReplies(1); 

        // 댓글 등록 버튼 이벤트 연결
        document.getElementById("addReplyBtn").addEventListener("click", addReply);
    });

    // 1. 댓글 목록 출력
    function printReplies(page) {
        // 호출된 페이지 번호를 현재 페이지로 저장
        currentPage = page; 
        
        const url = "/reply/list/" + bno + "?page=" + page;
        fetch(url)
            .then(res => res.json())
            .then(data => {
                document.getElementById("replyCount").innerText = data.totalCount;
                let replyUL = document.getElementById("replyList");
                let str = "";
                
                if(data.replyList && data.replyList.length > 0) {
                    data.replyList.forEach(reply => {
                        str += '<li class="reply-item" id="reply-li-' + reply.rno + '">';
                        str += '    <div class="reply-header">';
                        str += '        <span class="replyer-name">👤 ' + reply.replyer + '</span>';
                        
                        if(loginId === reply.replyer) {
                            str += '    <div class="reply-manage-btns">';
                            str += '        <a href="javascript:showEditForm(' + reply.rno + ')">수정</a>';
                            str += '        <a href="javascript:removeReply(' + reply.rno + ')" style="color:#dc3545;">삭제</a>';
                            str += '    </div>';
                        }
                        
                        str += '    </div>';
                        str += '    <div class="reply-content">' + reply.replyText + '</div>';
                        str += '</li>';
                    });
                } else {
                    str = '<li style="text-align:center; padding: 40px 0; color: #999;">등록된 댓글이 없습니다.</li>';
                }
                replyUL.innerHTML = str;
                printPaging(data);
            })
            .catch(err => console.error("댓글 로드 실패:", err));
    }

    // 2. 댓글 등록
    function addReply() {
        const replyText = document.getElementById("replyText").value;
        if(!loginId) { alert("로그인이 필요합니다."); return; }
        if(!replyText) { alert("내용을 입력하세요."); return; }

        fetch('/reply/add', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                bno: bno,
                replyText: replyText,
                replyer: loginId
            })
        })
        .then(res => res.text())
        .then(data => {
            if(data === "success") {
                alert("댓글이 등록되었습니다.");
                document.getElementById("replyText").value = "";
                // 새 댓글 등록 시에는 보통 1페이지로 가는 것이 일반적입니다.
                printReplies(1); 
            }
        });
    }

    // 3. 수정 폼 전환
    function showEditForm(rno) {
        const li = document.getElementById('reply-li-' + rno);
        const contentDiv = li.querySelector('.reply-content');
        const originalText = contentDiv.innerText;

        let editHtml = '<textarea class="edit-textarea">' + originalText + '</textarea>';
        editHtml += '<div style="text-align:right;">';
        editHtml += '   <button onclick="modifyReply(' + rno + ')" class="btn btn-modify" style="padding:5px 15px; font-size:12px;">완료</button>';
        // 취소 시 현재 보고 있던 페이지(currentPage)를 다시 호출하도록 수정
        editHtml += '   <button onclick="printReplies(currentPage)" class="btn btn-list" style="padding:5px 15px; font-size:12px; margin-left:5px;">취소</button>';
        editHtml += '</div>';

        contentDiv.innerHTML = editHtml;
    }

    // 4. 서버에 수정 전송 (@RequestBody 방식)
    function modifyReply(rno) {
        const li = document.getElementById('reply-li-' + rno);
        const modText = li.querySelector('.edit-textarea').value;

        if(!modText) { alert("내용을 입력하세요."); return; }

        fetch('/reply/modify', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ rno: rno, replyText: modText })
        })
        .then(res => res.text())
        .then(data => {
            if(data === "success") {
                alert("댓글이 수정되었습니다.");
                // 수정 완료 후 현재 페이지(currentPage) 유지
                printReplies(currentPage);
            }
        });
    }

    // 5. 삭제 처리
    function removeReply(rno) {
        if(!confirm("정말 삭제하시겠습니까?")) return;
        
        fetch('/reply/delete?rno=' + rno, { 
            method: 'POST' 
        })
        .then(res => res.text())
        .then(data => {
            if(data.trim() === "success") {
                alert("댓글이 삭제되었습니다.");
                // 삭제 후 현재 페이지 유지 (데이터가 다 삭제되어 비어있을 경우를 대비해 로직 보강 가능)
                printReplies(currentPage);
            } else {
                alert("삭제 실패");
            }
        })
        .catch(err => console.error("삭제 실패:", err));
    }

    // 6. 페이징 출력
    function printPaging(data) {
        let pagingDiv = document.getElementById("replyPaging");
        let str = "";
        if(data.prev) {
            str += "<a href='javascript:printReplies(" + (data.start - 1) + ")' class='paging-btn paging-arrow'>&lt;</a>";
        }
        data.pageNums.forEach(num => {
            // data.page가 현재 서버에서 온 페이지 번호이므로 이를 이용해 active 표시
            let activeClass = (num === data.page) ? "active" : "";
            str += "<a href='javascript:printReplies(" + num + ")' class='paging-btn " + activeClass + "'>" + num + "</a>";
        });
        if(data.next) {
            str += "<a href='javascript:printReplies(" + (data.end + 1) + ")' class='paging-btn paging-arrow'>&gt;</a>";
        }
        pagingDiv.innerHTML = str;
    }
</script>

</body>
</html>