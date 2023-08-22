package com.example.backend.domain.global.utils;

import com.example.backend.domain.global.exception.RestApiException;
import com.example.backend.domain.global.model.enums.ResultCode;
import nonapi.io.github.classgraph.fileslice.reader.ClassfileReader;
import org.springframework.core.io.ClassPathResource;

import java.io.*;

public class StringUtils {
    public static final String DASH = "-";
    public static final String UNDER_BAR = "_";

    private StringUtils() {
    }

    public static String transUriToColumnId(String uri) {
        return uri.replace(DASH, UNDER_BAR) + "_id";
    }

    public static String readSQLFile(String filePath) {
        ClassPathResource resource = new ClassPathResource(filePath);
        StringBuilder stringBuilder = new StringBuilder();
        String tmp;

        try (BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()))) {
            while ((tmp = br.readLine()) != null) {
                stringBuilder.append(tmp).append("\n"); // 개행문자 추가
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new RestApiException(ResultCode.FAIL_TO_READ_SQL_FILE);
        }

        return stringBuilder.toString();
    }
}
