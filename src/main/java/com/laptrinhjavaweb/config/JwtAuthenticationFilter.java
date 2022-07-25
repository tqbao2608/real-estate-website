package com.laptrinhjavaweb.config;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.service.impl.CustomUserDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private CustomUserDetailService userDetailService;

    @Autowired
    private TokenProvider jwtTokenUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain) throws ServletException, IOException {
        String header = httpServletRequest.getHeader(SystemConstant.HEADER_STRING);
        String username = null;
        String authToken = null;
        if (header != null && header.startsWith(SystemConstant.TOKEN_PREFIX)) {
            authToken = header.replace(SystemConstant.TOKEN_PREFIX,"");

        }
    }
}
