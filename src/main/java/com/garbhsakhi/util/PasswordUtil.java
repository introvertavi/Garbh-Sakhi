package com.garbhsakhi.util;

import org.mindrot.jbcrypt.BCrypt;
import java.security.MessageDigest;

public class PasswordUtil {

    // =========================
    // VERIFY PASSWORD
    // Supports SHA-256 (legacy) + BCrypt (current)
    // =========================
    public static boolean verify(String plainPassword, String storedHash) {

        try {
            if (storedHash == null || storedHash.isBlank()) {
                return false;
            }

            // BCrypt
            if (storedHash.startsWith("$2a$") || storedHash.startsWith("$2b$")) {
                return BCrypt.checkpw(plainPassword, storedHash);
            }

            // SHA-256 (legacy)
            return sha256(plainPassword).equals(storedHash);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================
    // HASH NEW PASSWORD (BCrypt ONLY)
    // =========================
    public static String hash(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // =========================
    // SHA-256 HELPER (LEGACY)
    // =========================
    private static String sha256(String input) throws Exception {

        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(input.getBytes("UTF-8"));

        StringBuilder hex = new StringBuilder();
        for (byte b : hash) {
            String h = Integer.toHexString(0xff & b);
            if (h.length() == 1) hex.append('0');
            hex.append(h);
        }
        return hex.toString();
    }
}
