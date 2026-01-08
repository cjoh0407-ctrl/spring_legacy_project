package service;


import org.apache.ibatis.annotations.Param;

import dto.ReplyDTO;
import dto.ReplyListPaginDTO;

public interface ReplyService {

    int insert(ReplyDTO replyDTO);	// 댓글 등록
    
    ReplyDTO read(@Param("rno") int rno); // 1개 댓글 조회, 읽기

    int delete(@Param("rno") int rno);	// 댓글 삭제
    
    int update(ReplyDTO replyDTO);	// 댓글 수정
   
    ReplyListPaginDTO listOfBoard(
            int bno,    // 게시물 번호
            int page,   // 보고 싶은 페이지 번호 (예: 1, 2, 3...)
            int size    // 한 페이지에 보여줄 댓글 개수 (예: 5, 10...)
    );

    int countOfBoard(int bno);	// 게시물에 달린 댓글 개수
	
}
