package com.example.backend.domain.information.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class CommentResponse {
    private String comment;

    @Builder
    public CommentResponse(String comment){
        this.comment = comment;
    }
}
