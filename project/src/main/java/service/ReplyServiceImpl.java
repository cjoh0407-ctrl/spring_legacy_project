package service;

import java.util.List;

import org.springframework.stereotype.Service;

import dto.ReplyDTO;
import dto.ReplyListPaginDTO;
import lombok.RequiredArgsConstructor;
import mapper.ReplyMapper;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService{

	private final ReplyMapper replyMapper;
	
	@Override
	public int insert(ReplyDTO replyDTO) {
		return replyMapper.insert(replyDTO);
	}

	@Override
	public ReplyDTO read(int rno) {
		return replyMapper.read(rno);
	}

	@Override
	public int delete(int rno) {
		return replyMapper.delete(rno);
	}

	@Override
	public int update(ReplyDTO replyDTO) {
		return replyMapper.update(replyDTO);
	}

	@Override
	public ReplyListPaginDTO listOfBoard(int bno, int page, int size) {
	    
	    // 1. MyBatis용 skip 계산 (몇 개 건너뛸지)
	    int skip = (page - 1) * size;
	    
	    // 2. DB에서 실제 댓글 목록 가져오기
	    List<ReplyDTO> list = replyMapper.listOfBoard(bno, skip, size);
	    
	    // 3. DB에서 해당 게시물의 전체 댓글 개수 가져오기
	    int totalCount = replyMapper.countOfBoard(bno);
	    
	    // 4. 모든 정보를 PagingDTO에 담아서 반환
	    // (보여주신 MemberListPagingDTO와 같은 구조의 생성자 호출)
	    return new ReplyListPaginDTO(list, totalCount, page, size);
	}

	@Override
	public int countOfBoard(int bno) {
		return replyMapper.countOfBoard(bno);
	}

}
