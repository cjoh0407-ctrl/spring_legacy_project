package service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import dto.BoardDTO;
import dto.BoardListPaginDTO;
import dto.MemberDTO;
import dto.MemberListPaginDTO;
import lombok.RequiredArgsConstructor;
import mapper.MemberMapper;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{
	
	private final MemberMapper memberMapper;
	private final PasswordEncoder passwordEncoder;

	@Override
	public List<MemberDTO> selectAll() {
		return memberMapper.selectAll();
	}

	@Override
	public MemberDTO selectById(String id) {
		return memberMapper.selectById(id);
	}

	@Override
	public void insert(MemberDTO dto) {
        // 회원가입 시 비밀번호 암호화 처리
        if (dto.getPassword() != null) {
            String encodedPw = passwordEncoder.encode(dto.getPassword());
            dto.setPassword(encodedPw);
        }
		memberMapper.insert(dto);
	}
	
	@Override
	public void update(MemberDTO dto) {
        // 4. 정보 수정 시에도 비밀번호가 넘어온다면 암호화해야 함
        if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
            // 이미 암호화된 비밀번호가 아닐 때만 암호화 (선택 사항)
            if (!dto.getPassword().startsWith("$2a$")) {
                dto.setPassword(passwordEncoder.encode(dto.getPassword()));
            }
        }
		memberMapper.update(dto);
	}
	
	@Override
	public void delete(String id) {
		memberMapper.delete(id);	
	}

	@Override
	public int getTotalMemberCount() {
		return memberMapper.getTotalMemberCount();
	}

	@Override
	public List<MemberDTO> getRecentMembers() {
		return memberMapper.getRecentMembers();
	}

	
	@Override
	public MemberDTO login(String id, String password) {
		return memberMapper.login(id, password);
	}
	
	
	@Override
	public void updateEnabled(String id, boolean enabled) {
		memberMapper.updateEnabled(id, enabled);
	}

	@Override
	public MemberListPaginDTO getListPaging(int page, int size, String types, String keyword) {

		int skip = (page - 1) * size;
		
		List<MemberDTO> listPaging = memberMapper.getListPaging(skip, size);
		
		int totalCount = memberMapper.getPagingCount();
		
		return new MemberListPaginDTO(listPaging, totalCount, page, size, types, keyword);
	}

	@Override
	public int getPagingCount() {
		return memberMapper.getPagingCount();
	}

	@Override
	public List<MemberDTO> memberListSearch(int skip, int size, String types, String keyword) {
		return memberMapper.memberListSearch(skip, size, types, keyword);
	}

	@Override
	public int memberCountSearch(String types, String keyword) {
		return memberMapper.memberCountSearch(types, keyword);
	}

	
	

}
