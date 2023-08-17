package com.example.backend.domain.global.utils;

public class StringUtils {
    public static final String DASH = "-";
    public static final String UNDER_BAR = "_";

    private StringUtils() {
    }

    public static String transUriToColumnId(String uri) {
        return uri.replace(DASH, UNDER_BAR) + "_id";
    }
}
