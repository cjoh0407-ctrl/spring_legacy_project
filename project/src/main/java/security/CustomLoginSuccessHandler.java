package security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import mapper.MemberMapper;
import dto.MemberDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@RequiredArgsConstructor // 매퍼나 서비스를 주입받기 위해 필요합니다
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    // DB 조회를 위해 매퍼나 서비스를 가져옵니다
    private final MemberMapper memberMapper; 

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, 
                                        Authentication authentication) throws IOException, ServletException {
        
        // 1. 로그인 성공한 사용자의 ID 가져오기
        String userId = authentication.getName(); 
        
        // 2. DB에서 해당 유저의 모든 정보(이름, 이메일, 전화번호 등) 조회
        MemberDTO loginMember = memberMapper.selectById(userId);
        
        // 3. 기존에 쓰던 방식 그대로 세션에 "member"라는 이름으로 저장!! (핵심)
        HttpSession session = request.getSession();
        session.setAttribute("member", loginMember);
        
        // 4. 권한 확인 후 리다이렉트
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));

        if (isAdmin) {
            response.sendRedirect(request.getContextPath() + "/admin/main");
        } else {
            // 일반 회원이 가야 할 곳 (게시판 목록 등)
            response.sendRedirect(request.getContextPath() + "/board/list");
        }
    }
}