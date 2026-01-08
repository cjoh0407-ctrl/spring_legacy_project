package security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class Custom403Handler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, 
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
        
        // 권한 부족 시 /member/access-denied 경로로 리다이렉트
        // (컨트롤러에서 해당 경로를 받아 JSP를 열어주거나, 직접 JSP 경로로 포워딩할 수 있습니다.)
        
        // URL 경로로 리다이렉트 (컨트롤러에 @GetMapping("/member/access-denied")가 있어야 함)
    	response.sendRedirect(request.getContextPath() + "/member/access-denied");

    }
}