package mapper;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import dto.BoardDTO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
class BoardMapperTest {

	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	void testSelectAll() {
		//given
		
		
		//when
		List<BoardDTO> list = boardMapper.selectAll();	
		
		//then
		assertNotNull(list);
		list.forEach(m -> log.info(m));
		
	}

	@Test
	void testModify() {
		//given
		int seq = 2;
				
		//when
		BoardDTO modify = boardMapper.detailByOne(seq);
		
		//then
		assertNotNull(modify);
		log.info(modify);
	}

	@Test
	void testInsert() {
		//given
		BoardDTO dto = BoardDTO.builder()
						.writer("user01")	// member테이블 id와 참조무결성 제약이라서 id에 있는 값만 사용해야함.
						.title("test")
						.content("test")
						.build();
		
		//when
		boardMapper.insert(dto);
		
		//then
		assertNotNull(dto);
		testSelectAll();
	}

	@Test
	void testDelete() {
		//given
		int seq = 2;
		
		
		//when
		boardMapper.delete(seq);
		
		//then
		
		
	}

	@Test
	void testUpdate() {
		//given
		int seq = 2;
		
		BoardDTO dto = BoardDTO.builder()
				.seq(seq)
				.title("testupdate1")
				.content("testupdate1")
				.build();
		//when
		boardMapper.update(dto);;
		
		//then
		assertNotNull(dto);
		
		testSelectAll();
		

	}
	
	@Test
	void testHitPlus() {
		//given
		int seq = 3;
		
		//when
		boardMapper.plusHit(seq);
		
		//then
	}

}
