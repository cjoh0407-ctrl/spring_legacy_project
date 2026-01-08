package dto;

import java.util.List;
import java.util.stream.IntStream;
import lombok.Data;

@Data
public class BoardListPaginDTO {

    private List<BoardDTO> boardDTOList;  // 현재 페이지 목록
    private int totalCount;               // 전체 게시글 수
    private int page, size;               // 페이지번호, 한 페이지당 개수
    private int start, end;               // 페이지 시작, 끝 번호
    private boolean prev, next;           // 이전, 다음 버튼 활성 여부
    private List<Integer> pageNums;       // 화면에 뿌릴 페이지 번호들 [1,2,3...10]
    private String types;                 // 검색 유형
    private String keyword;               // 검색어

    public BoardListPaginDTO(List<BoardDTO> boardDTOList, int totalCount, 
                             int page, int size, String types, String keyword) {
        
        this.boardDTOList = boardDTOList;
        this.totalCount = totalCount;
        this.page = page;
        this.size = size;
        this.types = types;
        this.keyword = keyword;

        // 1. 끝 번호(tempEnd) 우선 계산 (10개씩 보여준다고 가정)
        this.end = (int)(Math.ceil(this.page / 10.0)) * 10;

        // 2. 시작 번호 계산
        this.start = this.end - 9;

        // 3. 실제 마지막 페이지 번호(last) 계산
        // 검색 결과가 0개일 경우를 대비해 Math.max(1, ...)를 사용합니다.
        int last = (int)(Math.ceil(totalCount / (double)size));
        last = last == 0 ? 1 : last; 

        // 4. 만약 계산된 end가 실제 last보다 크다면 last를 end로 설정
        if (this.end > last) {
            this.end = last;
        }

        // 5. 이전/다음 버튼 활성화 여부
        this.prev = this.start > 1;
        this.next = totalCount > (this.end * this.size);

        // 6. 페이지 번호 리스트 생성 (IntStream)
        this.pageNums = IntStream.rangeClosed(start, end)
                                .boxed()
                                .toList();
    }
}