package security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomLoginSuccessHandler successHandler;
    private final Custom403Handler fourOhThreeHandler;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        
        // 1. CSRF 설정
        http.csrf(csrf -> csrf.disable());

        // 2. 권한 설정
        http.authorizeHttpRequests(auth -> auth
            .requestMatchers("/admin/**").hasRole("ADMIN")
            .requestMatchers("/member/", "/member/login", "/member/join", "/resources/**", "/").permitAll()
            .anyRequest().authenticated()
        );

        // 3. 로그인 설정
        http.formLogin(form -> form
            .loginPage("/member/")
            .loginProcessingUrl("/member/login")
            .usernameParameter("id")
            .passwordParameter("password")
            .successHandler(successHandler) // 성공 핸들러 연결
            .permitAll()
        );

        // 4. 예외 처리 (403 에러)
        http.exceptionHandling(ex -> ex.accessDeniedHandler(fourOhThreeHandler));

        // 5. 로그아웃
        http.logout(logout -> logout
            .logoutUrl("/member/logout")
            .logoutSuccessUrl("/member/")
            .invalidateHttpSession(true)
        );

        return http.build();
    }
    
    @Bean(name = "mvcHandlerMappingIntrospector")
    public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
        return new HandlerMappingIntrospector();
    }
}