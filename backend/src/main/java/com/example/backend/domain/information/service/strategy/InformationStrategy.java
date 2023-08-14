package com.example.backend.domain.information.service.strategy;

import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.CommentResponse;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InformationStrategy {
    List<CommonResponse> findAll();
    StrategyName getStrategyName();
    CommentResponse findCommentById(long id);
    Long findDetailId(long id);

    enum StrategyName {
        POWERTRAIN("powertrain"),
        BODYTYPE("bodytype"),
        DRIVING_SYSTEM("driving-system"),
        EXTERIOR_COLOR("exterior-color"),
        INTERIOR_COLOR("interior-color"),
        WHEEL("wheel"),
        ADDITIONAL_OPTION("additional-option");

        private String requestUri;
        private static final Map<String, StrategyName> uris;

        static {
            uris = new HashMap<>();
            for (StrategyName uri: StrategyName.values()) {
                uris.put(uri.requestUri, uri);
            }
        }

        public static StrategyName getByUri(String uri) {
            return uris.get(uri);
        }

        StrategyName(String requestUri) {
            this.requestUri = requestUri;
        }
    }
}
