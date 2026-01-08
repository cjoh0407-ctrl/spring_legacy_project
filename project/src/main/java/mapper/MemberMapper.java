package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import dto.BoardDTO;
import dto.MemberDTO;

@Mapper
public interface MemberMapper {

	List<MemberDTO> selectAll();	// 전체 조회
	
	
	MemberDTO selectById(String id);		// 1개만 조회
	
	
	void insert(MemberDTO dto);		// insert 추가
	
	
	void delete(String id); 		// delete 삭제
	
	
	void update(MemberDTO dto);		// update 수정
	
	
	int getTotalMemberCount(); // 총 회원 수
	
	
	List<MemberDTO> getRecentMembers(); // 최근에 가입한 회원 5명.
	
	
	MemberDTO login(@Param("id") String id, @Param("password") String password);	//login check
	
	
	void updateEnabled(@Param("id") String id, @Param("enabled") boolean enabled);	// 계정 활성화 여부 업데이트
	
	
	List<MemberDTO> getListPaging(@Param("skip") int skip, @Param("size") int size); //페이징 처리 리스트 가져오기.
	
	
	int getPagingCount(); // 페이징 처리를 위한 게시물 개수 카운트
	
	
	// 회원 검색 목록
    List<MemberDTO> memberListSearch(
        @Param("skip") int skip, 
        @Param("size") int size, 
        @Param("types") String types, 
        @Param("keyword") String keyword
    );

    // 검색된 회원 총 수
    int memberCountSearch(
        @Param("types") String types, 
        @Param("keyword") String keyword
    );
}
