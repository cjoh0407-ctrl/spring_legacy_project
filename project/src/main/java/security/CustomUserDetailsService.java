package security;

import lombok.RequiredArgsConstructor;
import mapper.MemberMapper;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import dto.MemberDTO;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberMapper memberMapper; // 본인의 매퍼 주입

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // DB에서 아이디로 회원 조회
        MemberDTO dto = memberMapper.selectById(username);

        if (dto == null) {
            throw new UsernameNotFoundException("존재하지 않는 사용자: " + username);
        }

        // 시큐리티 전용 User 객체 생성 (Role은 반드시 "ADMIN", "USER" 형태여야 함)
        return User.builder()
                .username(dto.getId())
                .password(dto.getPassword()) // DB에 암호화된 비밀번호가 있어야 함
                .roles(dto.getRole())  // 시큐리티가 자동으로 ROLE_를 붙여줌
                .build();
    }
}