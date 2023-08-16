package com.example.backend.domain.global.utils;

public class StringUtils {
    private StringUtils() {
    }

    public static String transUriToColumnId(String uri) {
        return uri.replaceAll("-", "_") + "_id";
    }
}
