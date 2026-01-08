package service;

import java.util.List;

import org.springframework.stereotype.Service;

import dto.BoardDTO;
import dto.BoardListPaginDTO;
import lombok.RequiredArgsConstructor;
import mapper.BoardMapper;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardMapper boardMapper;

	@Override
	public List<BoardDTO> selectAll() {
		return boardMapper.selectAll();
	}

	@Override
	public BoardDTO detailByOne(int seq) {
		return boardMapper.detailByOne(seq);
	}

	@Override
	public void insert(BoardDTO dto) {
		boardMapper.insert(dto);
	}

	@Override
	public void delete(int seq) {
		boardMapper.delete(seq);
	}
	
	@Override
	public void restore(int seq) {
		boardMapper.restore(seq);
	}

	@Override
	public void update(BoardDTO dto) {
		boardMapper.update(dto);
	}
	
	@Override
	public void plusHit(int seq) {
		boardMapper.plusHit(seq);
	}

	@Override
	public int getTotalCount() {
		return boardMapper.getTotalCount();
	}

	@Override
	public int getTodayCount() {
		return boardMapper.getTodayCount();
	}

	@Override
    public BoardListPaginDTO getListPaging(int page, int size, String types, String keyword, String role) {
        
        // 1. 시작 위치 계산
        int skip = (page - 1) * size;
        
        // 2. 검색 조건과 role이 포함된 리스트 호출
        List<BoardDTO> listPaging = boardMapper.listSearch(skip, size, types, keyword, role);
        
        // 3. 검색 조건과 role이 포함된 전체 개수 호출
        int totalCount = boardMapper.listCountSearch(types, keyword, role);
        
        // 4. 결과 리턴 (기존 DTO 구조에 맞춰서 리턴)
        return new BoardListPaginDTO(listPaging, totalCount, page, size, types, keyword);
    }

	@Override
	public int getPagingCount() {
		return boardMapper.getPagingCount();
	}

	@Override
    public List<BoardDTO> listSearch(int skip, int size, String types, String keyword, String role) {
        return boardMapper.listSearch(skip, size, types, keyword, role);
    }

    @Override
    public int listCountSearch(String types, String keyword, String role) {
        return boardMapper.listCountSearch(types, keyword, role);
    }
	
	
	
}
