package com.cxp.openadmin.util;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import javax.crypto.SecretKey;
import java.util.Date;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@SuppressWarnings("WeakerAccess")
@Component
public class JwtOperator {

    @Value("${secret:aaabbbcccdddeeefffggghhhiiijjjkkklllmmmnnnooopppqqqrrrsssttt}")
    private String secret;

    @Value("${expire-time-in-second:1209600}")
    private Long expirationTimeInSecond;


    public Claims getClaimsFromToken(String token) {
        try {
            return Jwts.parser()
                .setSigningKey(this.secret.getBytes())
                .parseClaimsJws(token)
                .getBody();
        } catch (ExpiredJwtException | UnsupportedJwtException | MalformedJwtException | IllegalArgumentException e) {
            log.error("token解析错误", e);
            throw new IllegalArgumentException("Token invalided.");
        }
    }


    public Date getExpirationDateFromToken(String token) {
        return getClaimsFromToken(token)
            .getExpiration();
    }


    private Boolean isTokenExpired(String token) {
        Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }


    public Date getExpirationTime() {
        return new Date(System.currentTimeMillis() + this.expirationTimeInSecond * 1000);
    }

    public String generateToken(Map<String, Object> claims) {
        Date createdTime = new Date();
        Date expirationTime = this.getExpirationTime();


        byte[] keyBytes = secret.getBytes();
        SecretKey key = Keys.hmacShaKeyFor(keyBytes);

        return Jwts.builder()
            .setClaims(claims)
            .setIssuedAt(createdTime)
            .setExpiration(expirationTime)
            .signWith(key, SignatureAlgorithm.HS256)
            .compact();
    }


    public Boolean validateToken(String token) {
        return !isTokenExpired(token);
    }

}