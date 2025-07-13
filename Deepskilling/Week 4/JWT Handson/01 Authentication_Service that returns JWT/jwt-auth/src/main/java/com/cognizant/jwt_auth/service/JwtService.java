package com.cognizant.jwt_auth.service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Date;

@Service
public class JwtService {

    private final SecretKey secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    public String generateToken(String username) {
        long now = System.currentTimeMillis();
        long expiry = 1000 * 60 * 60; // 1 hour expiration

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + expiry))
                .signWith(secretKey, SignatureAlgorithm.HS256)
                .compact();
    }
}
